import Foundation

public protocol ThingType {
    var name: String { get }
    func doThing()
}

public class ProtocolA {
    let type: ThingType

    public init(with type: ThingType) {
        self.type = type
    }

    public func ready() {
        type.doThing()
    }
}

public class ProtocolTypeA: ThingType {
    public let name: String

    public init(name: String = "ProtocolTypeA") {
        self.name = name
    }

    public func doThing() {
        print("Doing \(name) thing")
    }
}


