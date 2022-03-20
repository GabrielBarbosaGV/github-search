#!/bin/bash

for FOLDER_NAME in $(echo ./collected-projects/*/); do
	TEXT_DESTINATION="$(echo $FOLDER_NAME | sed 's/\/$//g')".txt

	[ -f $TEXT_DESTINATION ] || pdet $FOLDER_NAME --debug --crash --showDialog > $TEXT_DESTINATION 2>>errors.txt
done
