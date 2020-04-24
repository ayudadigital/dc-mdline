#!/bin/bash
set -euo pipefail

cd "$(dirname $0)/../test"
docker run -v $(pwd)/:/workspace ayudadigital/dc-mdline:beta example.md | diff example.html -