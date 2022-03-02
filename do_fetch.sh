#!/bin/bash

. ./err.sh

set_value() {
	case $1 in
		--token)
			TOKEN=$2
			;;
		--page)
			PAGE=$2
			;;
		--scope)
			SCOPE=$2
			;;
		--repo)
			REPO_IDENT=$2
			;;
		--help)
			echo "Help is yet to be implemented. Apologies for the incovenience."
			;;
		*)
			echo_err "Value for argument $1 is not recognized"
			exit 1
			;;
	esac
}

while [ $# -gt 0 ]; do
	set_value $1 $2
	shift
	shift
done

if [ -z "$TOKEN" ]; then
	echo_err "Github OAuth token must be given as argument. Call with --help for instructions."
	exit 1
elif [ -z "$SCOPE" ]; then
	echo_err "Scope of search must be given. Call with --help for instructions."
	exit 1
elif [ -z "$PAGE" -a "$SCOPE" = "repo" ]; then
	echo_err "Desired page must be given as argument when searching for repositories. Call with --help for instructions."
	exit 1
elif [ -z "$REPO_IDENT" -a "$SCOPE" = "code" ]; then
	echo_err "Repo identifier must be given as argument when searching for code. Call with --help for instructions."
	exit 1
fi

case "$SCOPE" in
	repo)
		URL="https://api.github.com/search/repositories?q=Android&sort=stars&order=desc&page=$PAGE"
		;;
	code)
		URL="https://api.github.com/search/code?q=filename:Activity%2Ejava+repo:$REPO_IDENT"
		;;
	*)
		echo_err "Unknown scope $SCOPE, exiting."
		exit 1
		;;
esac

curl \
    -u GabrielBarbosaGV:$TOKEN \
    -H "Accept: application/vnd.github.v3+json" \
	"$URL"
