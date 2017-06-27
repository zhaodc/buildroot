#!/bin/bash

OUTPUT=output-kylin
mkdir -p ${OUTPUT}
cp local.mk ${OUTPUT}
make -O=${OUTPUT} $1

