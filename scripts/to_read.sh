#!/bin/bash

ACTUAL="$(echo ./collected-projects/*/ | tr ' ' '\n' | sed 's/.*\/\(.\+\)\//"\1"/g' | jq -s)"

EXPECTED="$(jq '.name | split("/")[1]' < ./github-search/sorted.txt | jq -s)"

UNIQUE="$(( echo "$ACTUAL" ; echo "$EXPECTED" ) | jq -s '(.[1] | unique) - (.[0] | unique)')"

( echo $UNIQUE ; jq -s < ./github-search/sorted.txt ) \
	| jq -s '. as [$partial, $full] | $partial[] as $p | $full[] as $f | $f | select($f.name | contains($p))' \
	| jq -s 'sort_by(.count) | reverse'
