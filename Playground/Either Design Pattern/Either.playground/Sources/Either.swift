import Foundation

public class EitherA {
    let type: Either<EitherTypeA, EitherTypeB>

    public init(with rawType: String, name: String) {
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

public enum Either<A, B> {
    case a(A)
    case b(B)
}

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
