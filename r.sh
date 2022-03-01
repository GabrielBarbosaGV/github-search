#!/bin/sh
curl \
    -u GabrielBarbosaGV:$TOKEN \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/search/repositories?q=filename:Activity.java" > t.txt
