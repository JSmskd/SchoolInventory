//
//  extensions.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/22/25.
//

import SwiftUI

extension Array<gbl.type> {
    func String() -> [String] {
        var output :[String] = []
        for i in self {
            output.append(i.rawValue)
        }
        return output
    }
    func JSString() -> [JSString] {
        var output :[JSString] = []
        for i in self{
            output.append(i.JSString())
        }
        return output
    }
}
extension Array<JSString> {
    func String() -> [String] {
        var output :[String] = []
        for i in self {
            output.append(i.description)
        }
        return output
    }
}

extension String {
    func JSString() -> JSString { return .init(stringLiteral: self) }
    func blank() -> String? {
        if !self.isEmpty { return self }
        return nil
    }
}
