//
//  Clearable.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/25/21.
//

import Foundation

protocol Clearable {
    func clear() -> Clearable
    func toString() -> String
}

extension Bool: Clearable {
    func clear() -> Clearable {
        return false
    }
    
    func toString() -> String {
        return String(self)
    }
}

extension Int: Clearable {
    func clear() -> Clearable {
        return 1
    }
    
    func toString() -> String {
        return String(self)
    }
}
