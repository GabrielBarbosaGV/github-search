#!/bin/bash

. ./err.sh

. .env

# This call captures the "$username/$repository_name"
# from the obtained repository url
# "ri" is shorthand for "repository identifier"
jq 'select(.visited == false) | .url | capture("/(?<ri>[^/]+/[^/]+)$").ri' < android_pipeline_result.txt \
	| ./code_pipeline_consumer.sh \
	> code_pipeline_fetched_info.txt

jq '.items | select(length > 0) | {name: .[0].repository.full_name, count: length}' \
	< code_pipeline_fetched_info.txt \
	>> code_pipeline_result.txt

if [ "$?" -ne "0" ]; then
	echo_err "As an error occurred, consumed repositories will not be marked as visited"
	exit 1
fi

jq '.visited = true' < android_pipeline_result.txt > android_pipeline_result_temp.txt

mv android_pipeline_result_temp.txt android_pipeline_result.txt
