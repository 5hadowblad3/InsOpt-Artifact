# InsOpt with Magma Benchmark

This artifact accompanies the paper "Revisiting Path Coverage Tracing from a Node-centric View" and contains the implementation of InsOpt, our optimal node-centric instrumentation engine for edge coverage tracing. The artifact enables the reproduction of all experimental results presented in the paper, including:

Instrumentation reduction measurements (RQ1-2)

Fuzzing performance improvements (RQ3)

**This repo will be made public upon paper acceptance.**


## Details

As InsOpt has been successfully integrated with the state-of-the-art fuzzer, AFL++, and evaluated on the Magma benchmark, the major evaluation results rely on the configuration provided by the [Magma benchmark](https://hexhive.epfl.ch/magma/docs/getting-started.html), as mentioned below. 

### Structure 

The first layer of the project inherits the basic structure of the Magma benchmark. Our instrumentation code has been integrated with AFL++ so that you can find it in `fuzzers/insopt/repo`

````
   .
   ├── build.sh                Build script in magma format
   ├── Calculate.sh            Instrumentation statistic collection
   ├── CountInstrument.sh      Instrumentation statistic collection
   ├── fetch.sh                Build script in magma format
   ├── findings.sh             Build script in magma format
   ├── instrument.sh           Build script in magma format
   ├── preinstall.sh           Build script in magma format
   ├── repo                    Source code of Insopt, integrated with AFL++
   ├── runonce.sh              Build script in magma format
   └── run.sh                  Build script in magma format

````

Specifically, you can find the implementation of our instrumentation in the following two files (the rest are conventional AFL++):
````
fuzzers/insopt/repo/instrumentation/SanitizerCoveragePCGUARD.so.cc
fuzzers/insopt/repo/instrumentation/SanitizerCoverageLTO.so.cc
````
to support regular compilation and LTO compilation, respectively.

### Kick-the-Tires Instructions

The basic functionality and compilation correctness:

Dependency (You can also find it [here](fuzzers/insopt/preinstall.sh), which is the same in the Magma benchmark and will be automatically setup during reproduction):
````
#!/bin/bash
set -e

apt-get update && \
    apt-get install -y make \
        build-essential git gcc-7-plugin-dev cmake git flex bison libglib2.0-dev libpixman-1-dev python3-setuptools cargo libgtk-3-dev

wget https://apt.llvm.org/llvm-snapshot.gpg.key
apt-key add llvm-snapshot.gpg.key
sudo add-apt-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-13 main"
apt-get update --fix-missing && \
    apt-get install -y make llvm-13 clang-13 llvm-13-dev


update-alternatives \
  --install /usr/lib/llvm              llvm             /usr/lib/llvm-13  20 \
  --slave   /usr/bin/llvm-config       llvm-config      /usr/bin/llvm-config-13  \
    --slave   /usr/bin/llvm-ar           llvm-ar          /usr/bin/llvm-ar-13 \
    --slave   /usr/bin/llvm-as           llvm-as          /usr/bin/llvm-as-13 \
    --slave   /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  /usr/bin/llvm-bcanalyzer-13 \
    --slave   /usr/bin/llvm-c-test       llvm-c-test      /usr/bin/llvm-c-test-13 \
    --slave   /usr/bin/llvm-cov          llvm-cov         /usr/bin/llvm-cov-13 \
    --slave   /usr/bin/llvm-diff         llvm-diff        /usr/bin/llvm-diff-13 \
    --slave   /usr/bin/llvm-dis          llvm-dis         /usr/bin/llvm-dis-13 \
    --slave   /usr/bin/llvm-dwarfdump    llvm-dwarfdump   /usr/bin/llvm-dwarfdump-13 \
    --slave   /usr/bin/llvm-extract      llvm-extract     /usr/bin/llvm-extract-13 \
    --slave   /usr/bin/llvm-link         llvm-link        /usr/bin/llvm-link-13 \
    --slave   /usr/bin/llvm-mc           llvm-mc          /usr/bin/llvm-mc-13 \
    --slave   /usr/bin/llvm-nm           llvm-nm          /usr/bin/llvm-nm-13 \
    --slave   /usr/bin/llvm-objdump      llvm-objdump     /usr/bin/llvm-objdump-13 \
    --slave   /usr/bin/llvm-ranlib       llvm-ranlib      /usr/bin/llvm-ranlib-13 \
    --slave   /usr/bin/llvm-readobj      llvm-readobj     /usr/bin/llvm-readobj-13 \
    --slave   /usr/bin/llvm-rtdyld       llvm-rtdyld      /usr/bin/llvm-rtdyld-13 \
    --slave   /usr/bin/llvm-size         llvm-size        /usr/bin/llvm-size-13 \
    --slave   /usr/bin/llvm-stress       llvm-stress      /usr/bin/llvm-stress-13 \
    --slave   /usr/bin/llvm-symbolizer   llvm-symbolizer  /usr/bin/llvm-symbolizer-13 \
    --slave   /usr/bin/llvm-tblgen       llvm-tblgen      /usr/bin/llvm-tblgen-13

update-alternatives \
  --install /usr/bin/clang                 clang                  /usr/bin/clang-13     20 \
  --slave   /usr/bin/clang++               clang++                /usr/bin/clang++-13 \
  --slave   /usr/bin/clang-cpp             clang-cpp              /usr/bin/clang-cpp-13

````

After the dependecy has been properly installed, the instrumentaion code integrated with AFL++ can be correctly compiled with sanity check:
````
cp -r fuzzers/insopt/repo sanitity-test
cd sanitity-test
make
````

If there is no error message appear (warning is acceptable, especially those coming from AFL++), then everything should work.


### Reproduce procedure

To reproduce the evaluation shown in the paper, here are the main steps to run (You can also find more explanation according to the document of Magma on [the Magma homepage](https://hexhive.epfl.ch/magma/docs/getting-started.html):

1. Modify the `captinrc` file in `tools/captain` and with the following settings for changing the fuzzer under test to InsOpt. You can change to other baselines mentioned in the paper by modifying the fuzzers used in `FUZZERS`.
   ````
    # WORKDIR: path to the directory where shared volumes will be created
    WORKDIR=./workdir

    # FUZZERS: an array of fuzzer names (from magma/fuzzers/*) to evaluate
    FUZZERS=(insopt)

    # [TIMEOUT]: time to run each campaign. This variable supports one-letter
    # suffixes to indicate duration (s: seconds, m: minutes, h: hours, d: days)
    # (default: 1m)

    TIMEOUT=1d

   # [fuzzer_TARGETS]: an array of target names (from magma/targets/*) to fuzz with
   # `fuzzer`. The `fuzzer` prefix is a fuzzer listed in the FUZZERS array
   # (default: all targets)

   # if you want evaluate specific target with fuzzer, here is an example.
   # insopt_TARGETS=(libpng)

   ````
2. Run the fuzzer Insopt stored in `fuzzer/insopt` using the script provided:
   ````
    ./tools/captain/run.sh
   ````

## Result

**If the previous step runs properly, the result can be found in `./workdir_CURRENT_DATE/` (`workdir` is set according to the previous configuration in step 1).**

**The `workdir_CURRENT_DATE/log` directory contains the build and run logs of the campaign.** 

The instrumentation results can be found in `workdir/instrumentation_stats` to evaluate RQ(1-2) for checking the number of instrumentation node selected by our method, which is also the main contribution of this paper. The related statistics are shown in Figures 5-6 of the paper.

For each project, e.g., libsndfile, you can find its data in the log file `insopt_libsndfile_build.log`.
The data can be found through searching the following keywords as an indicator:
````
=== AFL++ LLVM_MODE Instrumentation Statistics ===
```` 

### Backup data

We also provide the raw data previously collected as an example. The compilation data can be found in
`tools/captain/datadir/`
which can help validate the instrumented node mentioned in RQ1-2 and the compilation time.

For each project, e.g., libsndfile, you can find its data in the log file `tools/captain/datadir/aflplusplus_entropy_libsndfile_build.log`.
The data can be found through searching the following keywords as an indicator:
````
=== AFL++ LLVM_MODE Instrumentation Statistics ===
```` 



### Fuzzer results for bug detection (RQ3)

In addition, the fuzzer logs and outputs can be found in `workdir/insopt/TARGET_PROJECT/TARGET_PROGRAM/FUZZER_INSTANCE_INDEX/findings`. To see the result, please use the [tool](https://hexhive.epfl.ch/magma/docs/technical.html#:~:text=Benchd%20Toolset:%20Processing%20Results) provided by the Magma benchmark to see the bug detection speed, which is related to Table 3 and Figure 8 of the paper.
Here is the main step to run:
````
tools/benchd/exp2json.py workdir bugs.json
````
PS: Please ensure the `workdir` correlates to the output folder used in step 1.

Here is the detailed usage from the Magma document:
````
tools/report_df/exp2json.py [-h] [--workers WORKERS] workdir outfile

positional arguments:
  workdir            The path to the Captain tool output workdir.
  outfile            The file to which the output will be written, or - for
                     stdout.

optional arguments:
  -h, --help         show this help message and exit
  --workers WORKERS  The number of concurrent processes to launch.
````
Then the evaluation result in fuzzing should be found in the outfile.

If everything works properly, an example folder named `tools/report_df/sanity_test_report` will appear in the `tools/report_df` folder. You can check the detection results in the `tools/report_df/sanity_test_report/data` folder to validate the bug detection performance mentioned in RQ3, Table 5.

**PS: As the performance of fuzzing is determined by various randomness factors and environmental configuration, the results can vary across evaluation runs.**


