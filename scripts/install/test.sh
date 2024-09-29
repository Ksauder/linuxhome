#!/bin/sh

echo "$(realpath $(dirname $(realpath $0))/../../lib)"
