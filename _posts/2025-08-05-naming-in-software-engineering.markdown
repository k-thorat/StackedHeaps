---
layout: post
title: "Naming in software engineering - Stacked Heaps"
description: "Swift naming conventions guide: Learn best practices for functions, protocols, and variables to improve code readability and maintainability."
date: 2025-08-05
categories: [tech, software-engineering]
tags: [guidelines, namming, practices]
permalink: /naming-in-software-engineering/
---

# Naming in software engineering

Naming - I struggled to name this article. Should this article be Naming in software engineering/development/programming? 

Naming is hard - irrespective of your native language. 

Documentation for code can become outdated, but well-thought-out naming conventions are a living document.

Although subjective, I have some guidelines to assist with naming conventions. While most of these guidelines are applicable to all languages, this article is specifically focused on [Swift](https://www.swift.org).

<b>Follow existing standards set in the projects</b>: IMO, this is really important and it's NOT limited to naming. If you don't have already, please use linting tools to set teams preferences. Linter can help you to set min/max lengths, casing etc. for names. This will save you ton of time in PR reviews.  

## Acronyms

Using acronyms that are internal, business-related, unknown, or associated with a specific feature would lose readability and make the life of a new engineer harder. Well-known acronyms like HTTP, DB, and defined patterns for projects and modules are acceptable.

## Namespacing

This is particularly important for third-party frameworks. I have encountered numerous frameworks using common names like Event, CustomEvent, Location etc. This increases the chances of conflicts when integrating projects. Additionally, common names make it challenging to determine which framework object belongs to.

## Files

Keep files for a single purpose. One Type per file with matching name.

## Types

Avoid using common names that could be conflicted with iOS or third-party frameworks.

## Naming a `protocol` in Swift or `interface` or `abstract class` in other languages

Protocol names should not use a concrete product/service name like Firebase/Adobe for a protocol. Concrete names should be used for concrete implementation. 
Follow a pattern (preferably a suffix) that would help identify a protocol by name. 

Examples:
	- Prefer -> LogType, AnalyticsType, ...
	- Avoid -> FirebaseLog, AdobeAnalytics, ...

## Functions

Follow `verb+noun` pattern for naming a function. Functions should either return a value or update state. They should not do both!

Repeating name of parent/class in the function name. `func configure()` in a User Type doesn't need to be named `func configureUser()` In some cases, when you don't need to know the internals, for example, configure or find, using simply `user` is acceptable as well.

Functions returning a value:
	- Prefer -> fetchUser() -> User, buildUser() -> User, ...
	- Avoid -> userFetch() -> User, userBuild() -> User, ...

Function updating a state:
	- Prefer -> setUser(_ user: User) -> Void, updateUser(_ user: User) -> Void, ...
	- Avoid -> userSet(_ user: User) -> Void, userUpdate(_ user: User) -> Void, ..	

## Properties & local variables 

Practice of pre/suffixing variable types in names was introduced because of a lack of language, IDE, and debugging support. Modern languages, tools, and type safety make this redundant and unnecessary.

Examples:
	- Prefer -> let name: String
	- Avoid -> let nameString: String

## Singleton 

I understand it's considered an anti-pattern. However, at times if I need to use it, I find it useful to have a naming pattern to identify Singleton from its name. For instance, I have used `Shared*` prefix to know the class I am interacting with is a Singleton.

## Unnamed tuples

This feature is called by many different names. In Swift, it is referred to as Unnamed tuples - it is a tuple without variable names. Access to variables is done with index. Access via index reduces readability and could lead to unintended errors from referencing incorrect fields.

Examples:
	- Avoid -> func split(name: String) -> (String, String) { }
	- Prefer -> func split(name: String) -> (first: String, last: String) { }


{% include post-tags.html %}