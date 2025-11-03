import Foundation

let basicA = BasicA(with: BasicTypeA())
basicA.ready()

let protocolA = ProtocolA(with: ProtocolTypeA())
protocolA.ready()

let noEitherA = NoEitherA(with: NoEitherTypeA(), or: nil)
noEitherA.ready()
let noEitherB = NoEitherA(with: nil, or: NoEitherTypeB())
noEitherB.ready()

let eitherA = EitherA(with: "a", name: "EitherA")
eitherA.ready()
let eitherB = EitherA(with: "b", name: "EitherB")
eitherB.ready()
