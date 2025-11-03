---
layout: post
title: "Restrict changes in Xcode Build Settings"
date: 2024-04-01
categories: [tech]
tags: [xcode, build-settings, tools, run-script]
---

# Restrict changes in Xcode Build Settings


We use Xcode [**Build Settings**](https://developer.apple.com/documentation/xcode/adding-a-build-configuration-file-to-your-project/#) to update project to our preferences.

`Build Settings` are available for every `Target` and `Project` in your workspace/project. 

I often find myself falling into one common pitfall: Project - Build Settings are overridden by Target. So you could be looking at a Project setting and not realizing it is overridden in Target.

Fortunately, Xcode provides a way to see customized settings. However they could be easily lost in the pool of settings.

All your settings are stored in `*.xcodeproj/*.pbxproj`. It also contains changes like add/move/remove a file or group, build phases, package dependencies, test target settings and more.

One way to solve this is to keep build settigns changes in `*.xcconfig` files. All your settings are out of `*.xcodeproj/*.pbxproj` and code reviews are lot more simpler. 

Great! So we decided to use xcconfig. How do we stop everyone from making changes to build settings? Complexities of `*.xcodeproj/*.pbxproj` XML makes it unreliable to review build settings changes in a PR. `xcodebuild` command line option doesn't have anything that helps our cause. 

Let's explore other options.

#### Parse `pbxproj` XML and review build setting changes.
One of the popular tool is [Xcodeproj](https://github.com/CocoaPods/Xcodeproj). We can use Xcodeproj and other Ruby tools to write a script that will find build setting changes. 
- Adds dependency on third-party tool and overhead of managing Ruby environment. If you already using Ruby then it could be a promising option. 

#### Generate `*.xcodeproj/*.pbxproj`. 
Tools like [XcodeGen](https://github.com/yonaskolb/XcodeGen) help to create `xcodeproj` with a script. It will force use to move all our settings in Xcconfig. Xcodegen` comes with features like using directory structure for project. This is a great tool and would recommended as a best practice.
- Adds dependency on third-party tool. If you are not interested in the other features provided by the tool, it could be overkill.

#### Write a shell script to find changes in build settings.
Simplest option, no dependencies! You own and maintain the script.


After listing down above options, I started working on a shell script. I looked at the XML structure and git changes on updating a setting. 

Empty buildSettings:

```
buildSettings = {
}
```
Modified buildSettings:

```
buildSettings = {
    $SETTINGS_NAME1=$VALUE1,
    $SETTINGS_NAME2=$VALUE2
}
```

Since project file contains buildSettings for project &amp; every target. You do have multiple occurrence of buildSettings. All of them follow same pattern. After looking at diff it was clear what should my script do.

We can find occurrence of **`buildSettings = {`** count number of line till **`}`**

If buildSettings is empty total number of lines will be twice as many of start lines (start + end). If any of the settings are updated, number of lines will be more (start + content + end).

Count occurrence of `buildSettings = {`

```
SETTINGS_START_OCCURRENCES=$(sed -n '/buildSettings = {/p' $PBXPROJ_FILE | wc -l)
```

Count number of lines from `buildSettings = {` to `}`

```
SETTINGS_ACTUAL_START_TO_END_LINE_COUNT=$(sed -n '/buildSettings = {/,/}/p' $PBXPROJ_FILE | wc -l)
```

If the build settings are empty, the following conditions will return true; otherwise, they will return false.

```
SETTINGS_ACTUAL_START_TO_END_LINE_COUNT == 2 * SETTINGS_START_OCCURRENCES
```

I am not a shell script expert. If I could find non-empty occurrence of `buildSettings = { }` that would be even better. Anyhoo, above works just the great!

Here is the entire script.

<script src="https://gist.github.com/k-thorat/528106b9e34ec6079ba1172db3f1c9b8.js"></script>

{% include post-tags.html %}