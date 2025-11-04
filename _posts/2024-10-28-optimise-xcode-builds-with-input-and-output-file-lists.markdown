---
layout: post
title: "Optimise Xcode builds with Input & Output file lists"
date: 2024-04-01
categories: [tech, xcode, tools]
tags: [build, build-phase, run-script, performance]
---

# Optimise Xcode builds with Input & Output file lists

Xcode `Run Scripts` have one of the amazing feature to optimise build process. In my opinion, it is well known but frequently unused.

To get started, provide input file/files and output file/files in the `Run Script`. Also, check `Based on dependency analysis` option in the `Run Script`. This feature has no impact on the script itself, such as restricting access to input files. Idea is to run the script only if the input has changed.

It is important to understand purpose of your script to optimise build. Some examples would include running the script on specific file types or only on files that have changes.

I have written two simple scripts to facilitate a smooth start. One script builds list of files by file-type and other by changed files.

Use the script that suites your needs followed by script you want to run.

Your Run Script in Xcode will look something like this:

```
# Script to create file list for Xcode.
$PROJECT_DIR/Scripts/input_output_list_for_file_types.sh SwiftFiles swift

# Script you want to execute when there are changes in the input file list. 
$PROJECT_DIR/Scripts/$YOUR_SCRIPT
```

## Xcode - Run Script:

IMAGE (Xcode_RunScript_InputOutput_FileList.png)

## Create list by file-types:

```
$PROJECT_DIR/$SCRIPT_LOCATION/input_output_list_for_file_types.sh $FILE_NAME "$TYPE_1 $TYPE_2"
```

EMBED <https://gist.github.com/k-thorat/53d67ad0d75ba5d2992939d7fc85c104>


## Create list of changed files:

EMBED <https://gist.github.com/k-thorat/40bbc062e797f7d4a5b63d1c0dc31621>


{% include post-tags.html %}
