#!/bin/bash
#
#  Copyright 2023 The original authors
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

<<<<<<< Updated upstream:calculate_average_Ujjwalbharti.sh

JAVA_OPTS=""
time java $JAVA_OPTS --class-path target/average-1.0.0-SNAPSHOT.jar dev.morling.onebrc.CalculateAverage_Ujjwalbharti
=======
set -euo pipefail
#JAVA_OPTS="-XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xms128m -Xmx128m -XX:-AlwaysPreTouch -XX:-TieredCompilation -XX:CICompilerCount=1"
JAVA_OPTS="-Xmx64m --enable-preview  -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -XX:+AlwaysPreTouch -XX:+TrustFinalNonStaticFields"

# Profiling
#JAVA_OPTS="$JAVA_OPTS -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints -agentpath:/home/shade/trunks/shipilev-async-profiler/build/libasyncProfiler.so=start,event=cpu,file=/home/shade/Desktop/profile.html"

#JAVA_OPTS="$JAVA_OPTS -XX:CompileCommand=inline,dev.morling.onebrc.CalculateAverage_shipilev\$MeasurementsMap::bucket"
#JAVA_OPTS="$JAVA_OPTS -XX:+UnlockDiagnosticVMOptions -XX:+PrintCompilation -XX:+PrintInlining -XX:CompileCommand=inline,dev.morling.onebrc.CalculateAverage_shipilev\$MeasurementsMap::bucket"
#JAVA_OPTS="$JAVA_OPTS -Xlog:safepoint -Xlog:gc -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xmx512m -XX:+HeapDumpOnOutOfMemoryError"
#JAVA_OPTS="$JAVA_OPTS -Xlog:gc"

for sample in $(ls src/test/resources/samples/*.txt); do
  echo "Validating $sample"

  rm -f measurements.txt
  ln -s $sample measurements.txt

  java $JAVA_OPTS -Dunsafe=true --class-path target/average-1.0.0-SNAPSHOT.jar dev.morling.onebrc.CalculateAverage_obourgain > actual.out
  java $JAVA_OPTS -Dunsafe=false --class-path target/average-1.0.0-SNAPSHOT.jar dev.morling.onebrc.CalculateAverage_obourgain > actual.out
#  hexdump -C actual.out > actual.hex
#  hexdump -C ${sample%.txt}.out > sample.hex
#  diff -uwb sample.hex actual.hex
done

rm measurements.txt
ln -sf measurements2.txt measurements.txt

#/usr/bin/time java $JAVA_OPTS --class-path target/average-1.0.0-SNAPSHOT.jar dev.morling.onebrc.CalculateAverage_shipilev
# runs with -Xmx32m on my machine, playing it safe with a larger heap
#perf record -F max java $JAVA_OPTS --class-path target/average-1.0.0-SNAPSHOT.jar dev.morling.onebrc.CalculateAverage_shipilev
#perf stat -r 10 -e task-clock,cycles,instructions,branches,cache-references,cache-misses java $JAVA_OPTS --class-path target/average-1.0.0-SNAPSHOT.jar dev.morling.onebrc.CalculateAverage_shipilev

time java $JAVA_OPTS -Dunsafe=true --class-path target/average-1.0.0-SNAPSHOT.jar dev.morling.onebrc.CalculateAverage_obourgain
time java $JAVA_OPTS -Dunsafe=false --class-path target/average-1.0.0-SNAPSHOT.jar dev.morling.onebrc.CalculateAverage_obourgain
>>>>>>> Stashed changes:calculate_average_obourgain_test_and_run.sh
