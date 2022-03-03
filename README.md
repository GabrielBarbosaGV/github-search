# Searching for Android repositories that contain files ending in "Activity.java"

This repository belongs to a greater context of an utility to classify Android java projects as one of
MVP, MVC, MVVM, MVI.

Further instructions are planned for later. For now, these may be of use:


1. Install jq. jq is a great tool/language for filtering JSON data, and it is used by this project,
therefore being a requirement. It is a small binary, suitable for most environments. As execution of the tasks presented
here require bash, it is very unlikely for you to be unable to run it. Obtain it [here](https://stedolan.github.io/jq/).

2. Create a .env file. This file will be sourced by other bash scripts. In it, you may place what best serves you, but
it is essential that a TOKEN variable be defined for performing requests to Github. If no other modifications to this
file are intended, place this sole line in it:

```
TOKEN=$TOKEN
```

Where $TOKEN is your Github OAuth token. Instructions from Github on generating this token may be found [here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).
Beware of rate limits.

3. Create a page.txt file. In this file, you should place the number of the page you desire to fetch. This number will be
automatically incremented through the execution of another script.

4. Modify the script files to be executable. This command:

```
chmod u+x $SCRIPT
```

where $SCRIPT is the target's filename, should perform what's intended. If it does not, please seek information on
how to do so for your system.

5. Execute ./android\_pipeline.sh once. Execution of this script consists of a request for a single page, which was
specified in page.txt, of Github's repositories themed around Android. The response is filtered by jq, and piped into
android\_pipeline\_result.txt. page.txt will have its number incremented, and further executions will request next pages
for it.

6. Execute ./code\_pipeline.sh once. This will perform a request for each repository listed in
android\_pipeline\_result.txt that is marked as unvisited, outputting those that respond with at least one matching file,
along with respective counts, to code\_pipeline\_result.txt. All entries in android\_pipeline\_result.txt will be marked
as visited.

7. Last, but not least, have a nice day!
