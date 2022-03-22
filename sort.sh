#!/bin/bash
jq -s 'sort_by(.count) | reverse | unique | .[]' < code_pipeline_result.txt > sorted.txt
