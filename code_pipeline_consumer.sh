#!/bin/bash

. .env

while read in; do
	./do_fetch.sh --token $TOKEN --scope code --repo $in
done
