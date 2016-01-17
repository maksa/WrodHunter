//
//  WordDirection.swift
//  WrodHunter
//
//  Created by Maksa on 1/16/16.
//  Copyright © 2016 Manta Ray. All rights reserved.
//

import Foundation
/** WordDirection Struct

*/
enum WordDirection : Int {
    case TopDown = 0
    case LeftRight = 1
    
    static func getRandomDirection() -> WordDirection {
        return WordDirection(rawValue:Int.random(0...1))!
    }
}
