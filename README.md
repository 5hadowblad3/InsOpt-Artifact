# InsOpt with Magma Benchmark

This artifact accompanies the paper "Revisiting Path Coverage Tracing from a Node-centric View" and contains the implementation of InsOpt, our optimal node-centric instrumentation engine for edge coverage tracing. The artifact enables the reproduction of all experimental results presented in the paper, including:

Instrumentation reduction measurements (RQ1-2)

Fuzzing performance improvements (RQ3)

**This repo will be made public upon paper acceptance.**


## Details

As InsOpt has been successfully integrated with the state-of-the-art fuzzer, AFL++, and evaluated on the Magma benchmark, the major evaluation results rely on the configuration provided by the Magma benchmark, as mentioned below. 

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
   ├── repo                    Source code of Insopt
   ├── runonce.sh              Build script in magma format
   └── run.sh                  Build script in magma format

````

Specifically, you can find the implementation of our instrumentation in the following two files:
````


````


### Reproduce procedure

To reproduce the evaluation shown in the paper, please follow the document of Magma on [the Magma homepage]([https://hexhive.epfl.ch/magma](https://hexhive.epfl.ch/magma/docs/getting-started.html)).
Here is the main step to run:

1. Modify the `captinrc` file in `tools/captain` and with the following settings for changing the fuzzer under test to InsOpt. You can change to other baselines mentioned in the paper.
   ````
    # WORKDIR: path to the directory where shared volumes will be created
    WORKDIR=./workdir

    # FUZZERS: an array of fuzzer names (from magma/fuzzers/*) to evaluate
    FUZZERS=(insopt)

    # [TIMEOUT]: time to run each campaign. This variable supports one-letter
    # suffixes to indicate duration (s: seconds, m: minutes, h: hours, d: days)
    # (default: 1m)

    TIMEOUT=1d

   ````
2. Run the fuzzer Insopt stored in `fuzzer/insopt` using the script provided:
   ````
    ./tools/captain/run.sh
   ````

## Result

**If the previous step runs properly, the result can be found in `workdir/insopt`.**

**The `workdir/log` directory contains the build and run logs of the campaign.** 

The instrumentation results can be found in `workdir/instrumentation_stats` to evaluate RQ(1-2) for checking the number of instrumentation node selected by our method, which is also the main contribution of this paper. The related statistics are shown in Figures 5-6 of the paper.


### Backup data

We also provide the raw data previously collected as an example. The compilation data can be found in
`tools/captain/datadir/`
which can help validate the instrumented node mentioned in RQ1-2 and the compilation time.

For project `xxx`, e.g., libsndfile, you can find its data in the log file `tools/captain/datadir/aflplusplus_entropy_libsndfile_build.log`.
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

**PS: As fuzzing involves various randomness factors and environmental configuration, performance can vary across evaluation runs.**


