import Foundation

public class BasicA {
    let type: BasicTypeA

    public init(with type: BasicTypeA) {
        self.type = type
    }

    public func ready() {
        type.doThing()
    }
}

public class BasicTypeA {
    let name: String

    public init(name: String = "BasicTypeA") {
        self.name = name
    }

    func doThing() {
        print("Doing \(name) thing")
    }
}
