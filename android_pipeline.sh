#!/bin/bash

. .env

PAGE=$(cat page.txt)

PAGE_CONTENT=$(./do_fetch.sh --token $TOKEN --page $PAGE --scope repo)

echo $PAGE_CONTENT \
	| jq '.items[] | {url: .html_url, stars: .watchers_count, visited: false}' \
	>> android_pipeline_result.txt

echo $(expr $PAGE + 1) > page.txt
