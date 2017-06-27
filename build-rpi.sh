#!/bin/bash

OUTPUT=output-rpi
mkdir -p ${OUTPUT}
cp local.mk ${OUTPUT}
make -O=${OUTPUT} $1

