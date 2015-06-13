#!/bin/bash

read parse
data=$(curl http://127.0.0.1:8500/v1/kv/sync?recurse)

echo $parse > /data/parse
echo $data | jq '.' > /data/datap
