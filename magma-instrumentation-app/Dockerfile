FROM ubuntu:18.04

# TODO remove sudo for user "magma" to avoid unwanted priv escalation from
# other attack vectors.

RUN apt-get update && apt-get install -y sudo

## Magma directory hierarchy
# magma_root is relative to the docker-build's working directory
# The Docker image must be built in the root of the magma directory
ARG magma_root=./

## Path variables inside the container
ENV MAGMA_R /magma
ENV OUT		/magma_out
ENV SHARED 	/magma_shared

ENV CC  /usr/bin/gcc
ENV CXX /usr/bin/g++
ENV LD /usr/bin/ld
ENV AR /usr/bin/ar
ENV AS /usr/bin/as
ENV NM /usr/bin/nm
ENV RANLIB /usr/bin/ranlib

ARG USER_ID=1000
ARG GROUP_ID=1000
RUN mkdir -p /home && \
	groupadd -g ${GROUP_ID} magma && \
	useradd -l -u ${USER_ID} -K UMASK=0000 -d /home -g magma magma && \
	chown magma:magma /home
RUN	echo "magma:amgam" | chpasswd && usermod -a -G sudo magma

RUN mkdir -p ${SHARED} ${OUT} && \
	chown magma:magma ${SHARED} ${OUT} && \
	chmod 744 ${SHARED} ${OUT}

ARG magma_path=magma
ENV MAGMA 	${MAGMA_R}/${magma_path}
USER root:root
RUN mkdir -p ${MAGMA} && chown magma:magma ${MAGMA}
COPY --chown=magma:magma ${magma_root}/${magma_path} ${MAGMA}/
RUN ${MAGMA}/preinstall.sh
USER magma:magma
RUN ${MAGMA}/prebuild.sh

ARG fuzzer_name="afl_entropy"
ARG fuzzer_path=fuzzers/${fuzzer_name}
ENV FUZZER 	${MAGMA_R}/${fuzzer_path}
USER root:root

RUN mkdir -p ${FUZZER} && chown magma:magma ${FUZZER}
COPY --chown=magma:magma ${magma_root}/${fuzzer_path} ${FUZZER}/
RUN mkdir -p ${FUZZER}/repo

RUN ${FUZZER}/preinstall.sh && \
    chown -R magma:magma ${FUZZER} && \
    chmod -R 777 ${FUZZER}

COPY --chown=magma:magma ./docker/repo ${MAGMA_R}/fuzzers/afl_entropy/repo 

USER magma:magma
RUN ${FUZZER}/fetch.sh
RUN ${FUZZER}/build.sh

# 将所有 Targets 复制到容器中
ARG target_path=targets
ENV TARGETS ${MAGMA_R}/${target_path}
USER root:root
RUN mkdir -p ${TARGETS} && chown magma:magma ${TARGETS}
COPY --chown=magma:magma ${magma_root}/${target_path} ${TARGETS}/

# 复制 Instrument_run.sh 到容器中
COPY --chown=magma:magma ./magma-instrumentation-app/Instrument_run.sh /magma/Instrument_run.sh
RUN chmod +x /magma/Instrument_run.sh



