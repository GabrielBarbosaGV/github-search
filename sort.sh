#!/bin/bash
jq -s 'sort_by(.count) | reverse | .[]' < code_pipeline_result.txt > sorted.txt
