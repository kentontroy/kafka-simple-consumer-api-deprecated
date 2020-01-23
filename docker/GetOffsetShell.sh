#!/bin/bash

java -cp ${OFFSET_SHELL_HOME}/depends/*:. kafka.tools.GetOffsetShell \
  --properties ${OFFSET_SHELL_HOME}/sasl.properties \
  --broker-list ${BOOTSTRAP_SERVER} --time -1 \
  --topic "connect"
