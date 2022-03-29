#!/bin/bash
jq -s 'unique | sort_by(.count) | reverse | .[]' < code_pipeline_result.txt > sorted.txt
