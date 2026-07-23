# README.md

# Magma Instrumentation App

## Overview

The Magma Instrumentation App is designed to facilitate the instrumentation of various targets using the afl_entropy fuzzer. This project provides a Dockerized environment that simplifies the setup and execution of fuzzing campaigns, allowing users to collect and analyze statistics from the instrumentation runs.

## Project Structure

- **Dockerfile**: Sets up a Docker image that includes all targets and copies the afl_entropy fuzzer for instrumentation.
- **Instrument_run.sh**: A script for running the afl_entropy fuzzer on all targets and collecting statistics.
- **targets/all_targets.conf**: Configuration file listing all targets for instrumentation, including parameters and settings.
- **fuzzers/afl_entropy/repo**: Contains the source code and resources for the afl_entropy fuzzer.
- **stats/collect_stats.sh**: Script for collecting and processing statistics from the instrumentation runs.
- **README.md**: Documentation for the project.

## Getting Started

### Prerequisites

- Docker installed on your machine.
- Basic knowledge of Docker and shell scripting.

### Building the Docker Image

To build the Docker image, navigate to the project directory and run the following command:

```bash
docker build -t magma-instrumentation-app .
```

### Running the Instrumentation

After building the Docker image, you can run the instrumentation using the provided script:

```bash
docker run --rm magma-instrumentation-app ./Instrument_run.sh
```

### Collecting Statistics

Once the instrumentation is complete, you can collect and analyze the statistics generated during the runs. Use the following command to execute the statistics collection script:

```bash
./stats/collect_stats.sh
```

## Interpreting Results

The results of the instrumentation runs will be available in the specified output directories. Review the collected statistics to understand the performance and coverage of the fuzzing campaigns.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.