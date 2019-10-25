//
//  Pair.swift
//  Pair
//
//  Created by Michael Di Cesare on 10/25/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import Foundation




class Pair: Codable {
    var name: String
    init(name: String){
        self.name = name
    }
}

extension Pair: Equatable {
    static func == (lhs: Pair, rhs: Pair) -> Bool {
        return rhs.name == lhs.name
    }
}
