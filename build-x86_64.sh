#!/bin/bash

OUTPUT=output-x86_64
mkdir -p ${OUTPUT}
cp local.mk ${OUTPUT}
make -O=${OUTPUT} $1

