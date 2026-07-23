# InsOpt with Magma Benchmark

This artifact accompanies the paper "Revisiting Path Coverage Tracing from a Node-centric View" and contains the implementation of InsOpt, our optimal node-centric instrumentation engine for edge coverage tracing. The artifact enables the reproduction of all experimental results presented in the paper, including:

Instrumentation reduction measurements (RQ1-2)

Fuzzing performance improvements (RQ3)


## Details

As InsOpt has been successfully integrated with state-of-the-art fuzzer, AFL++, and evaluated in the Magma benchmark. The major evaluation results all rely on configuration provided by the Magma benchmark mentioned below. 

For reproduce the evaluation shown in the paper, please follow the document of Magma on [the Magma homepage]([https://hexhive.epfl.ch/magma](https://hexhive.epfl.ch/magma/docs/getting-started.html)).
Here is the main step to run:

1. Modify the `captinrc` file in `tools/captain` and with the following settings for changing the fuzzer under test to InsOpt. You can change to other for baseline evaluation mentioned in the paper.
   ````
    # WORKDIR: path to directory where shared volumes will be created
    WORKDIR=./workdir

    # FUZZERS: an array of fuzzer names (from magma/fuzzers/*) to evaluate
    FUZZERS=(insopt)

   ````
2. Run the fuzzer Insopt stored in `fuzzer/insopt` using the script provided:
   ````
    ./tools/captain/run.sh
   ````

## Result

**The result can be found in `workdir/insopt`.**

**The `workdir/log` directory contains the build and run logs of the campaign.** 

The instrumentation results can be found in `workdir/instrumentation_stats` to evaluate RQ(1-2) for checking the number of instrumentation node selected by our method, which is also the main contribution of this paper. The related statistic are shown in Figures 5-6 of the paper.

In addition, the fuzzer logs and outputs can be found in `workdir/insopt/TARGET_PROJECT/TARGET_PROGRAM/FUZZER_INSTANCE_INDEX/findings`. To see the result, please use the [tool](https://hexhive.epfl.ch/magma/docs/technical.html#:~:text=Benchd%20Toolset:%20Processing%20Results) provided by the Magma benchmark to see the bug detection speed, which are related to Table 3 and Figure 8 of the paper.
Here is the main step to run:
````
tools/benchd/exp2json.py workdir bugs.json
````

Here is the detail usage from the Magma document:
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
Then the evaluation result in fuzzing should be found in outfile.

