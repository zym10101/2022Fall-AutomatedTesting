#!/bin/bash

# Configure location globals
export BENCH_DIR="/home/zym/桌面"
export SUBJECT="$BENCH_DIR/binutils-2.39"
# Configure compilation globals
export CC="/usr/local/bin/afl-gcc"
export CXX="/usr/local/bin/afl-g++"
# Show configuration results
echo "SUBJECT=$SUBJECT"
echo "CC=$CC"
echo "CXX=$CXX"

# Parameter checking
if [ $# -lt 2 ]; then
  echo "<CAMPAIGN>: <START_IDX> <REPEAT>"
  exit 1
fi
# Configure how many times to run and where (index) to start
START_IDX=$1
REPEAT=$2
# Compute where to stop
END_IDX=$((START_IDX+REPEAT-1))

# Prepare initial seeds for fuzzing
IN_DIR="$SUBJECT/nm_in"
if [ -d $IN_DIR ]; then
  rm -rf $IN_DIR
fi
mkdir $IN_DIR
cp $SUBJECT/test/elf/small_exec.elf $IN_DIR; rm $(find $IN_DIR -size +1000c)

# Instrument subject programs
pushd $SUBJECT || exit 1
  sudo "CC=$CC" ./configure --disable-shared
  make
popd || exit 1

# Start fuzzing campaign.
STARTUP_DUR=10
DUR=$((60*60))
TIMEOUT="$((STARTUP_DUR+DUR))"s
for idx in $(seq "$START_IDX" "$END_IDX"); do

  # Prepare out directories for fuzzing
  OUT_DIR="$SUBJECT/nm_outs/out-$idx"
  if [ -d "$OUT_DIR" ]; then
    rm -rf "$OUT_DIR"
  fi
  mkdir -p "$OUT_DIR"

  # Run fuzzing
  timeout $TIMEOUT afl-fuzz -i "$IN_DIR" -o "$OUT_DIR" $SUBJECT/binutils/nm-new -C @@

done
