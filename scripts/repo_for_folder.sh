#!/bin/bash

{ sed 's/\(.*\)/"\1"/g' | jq -s; (jq -s < ./github-search/sorted.txt) } \
	| jq -s '. as [$folders, $repos] | $folders[] as $folder | $repos[].name | select(. != null and contains($folder))'
