//
//  JSString.swift
//  SchoolInventory
//
//  Created by John Sencion on 10/22/25.
//

import SwiftUI

struct JSString: Codable, Hashable, Identifiable, ExpressibleByStringLiteral, CustomStringConvertible {
    var description: String { get { text } }
    var id = UUID()
    var text:String
    
    init(stringLiteral: String) {
        text = stringLiteral
    }
    init (_ t:String) {
        self = .init(stringLiteral: t)
    }
    init (_ g:gbl.type) {
        self = .init(g.rawValue)
    }
    
}
