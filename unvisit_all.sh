#!/bin/bash

jq '.visited = false' < android_pipeline_result.txt > android_pipeline_result_temp.txt

mv android_pipeline_result_temp.txt android_pipeline_result.txt
