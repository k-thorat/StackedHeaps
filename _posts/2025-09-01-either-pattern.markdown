---
layout: post
title: "Either Pattern in Swift - Stacked Heaps"
description: "Learn how to use the Either pattern in Swift when you can't inject dependencies. Includes code examples and a playground."
date: 2025-09-01
categories: [tech, software-engineering]
tags: [pattern, architecture]
permalink: /either-pattern/
---

# Either Pattern

How do you extend a class to support a new type? In following code, how would you extend class A to take TypeB instead of TypeA?

```
class A {

    let type: TypeA

    var title: String {
        type.name
    }

    func ready() {
        type.doThing()
    }

}

class TypeA {

    let name: String

    func doThing() {

    }

}
```

One approach is to inject dependency. We can update concrete dependency with a protocol. Now any type confirming to a protocol can be used in class A.

```
protocol ThingType {

    var name: String { get }
    func doThing()

}

class A {

    let type: ThingType

    var title: String {
        type.name
    }

    func ready() {
        type.doThing()
    }

}

class TypeA: ThingType {

    let name: String

    func doThing() {

    }

}
```

What if, you can't inject your dependencies? Like you can't construct an object or constructor is dependent on the properties/state of the class A. What other options do you have? `Either` is very powerful pattern you can use in cases like this. 

```
// This can be extended to as many cases you need. 
public enum Either<A, B> {
    case a(A)
    case b(B)
}

public class A {
    let type: Either<EitherTypeA, EitherTypeB>

    public init(with rawType: String, name: String) {
        // Made up scenario to show dependencies are not injected.  
        if rawType == "a" {
            self.type = Either.a(EitherTypeA(name: name))
        } else {
            self.type = Either.b(EitherTypeB(name: name))
        }
    }

    public func ready() {
        type.doThing()
    }
}

public class EitherTypeA {
    public let nameA: String

    public init(name: String) {
        self.nameA = name
    }

    public func doAThing() {
        print("Doing \(nameA) thing")
    }
}

public class EitherTypeB {
    public let nameB: String

    public init(name: String) {
        self.nameB = name
    }

    public func doBThing() {
        print("Doing \(nameB) thing")
    }
}

/// Property and function signatures doesn't need to be identical. We can map them as needed. 
extension Either where A == EitherTypeA, B == EitherTypeB {

    var name: String {
        switch self {
        case .a(let typeA): return typeA.nameA
        case .b(let typeB): return typeB.nameB
        }
    }

    func doThing() {
        switch self {
        case .a(let typeA): typeA.doAThing()
        case .b(let typeB): typeB.doBThing()
        }
    }
}
```

If you have to work with Class A without `Either` pattern. Class A will be full of switch-cases/if-else and optional properties. 

Here is [playground](https://github.com/k-thorat/StackedHeaps/tree/main/Playground/Either%20Design%20Pattern) with all the above scenarios. 


{% include post-tags.html %}
