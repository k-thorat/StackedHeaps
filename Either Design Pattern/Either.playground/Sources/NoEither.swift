import Foundation

public class NoEitherA {
    var typeA: NoEitherTypeA?
    var typeB: NoEitherTypeB?

    public init(
        with typeA: NoEitherTypeA?,
        or typeB: NoEitherTypeB?
    ) {
        if let a = typeA {
            self.typeA = a
        } else if let b = typeB {
            self.typeB = b
        }
    }

    public func ready() {
        if let a = typeA {
            a.doThing()
        } else if let b = typeB {
            b.doThing()
        }
    }
}

public class NoEitherTypeA {
    let name: String

    public init(name: String = "NoEitherTypeA") {
        self.name = name
    }

    func doThing() {
        print("Doing \(name) thing")
    }
}

public class NoEitherTypeB {
    let name: String

    public init(name: String = "NoEitherTypeB") {
        self.name = name
    }

    func doThing() {
        print("Doing \(name) thing")
    }
}
