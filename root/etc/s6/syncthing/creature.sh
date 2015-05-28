#!/bin/bash

syncthing -gui-address="0.0.0.0:8080" -no-browser | tee >(cat - >&2)