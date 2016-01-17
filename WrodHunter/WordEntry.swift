//
//  WordEntryPosition.swift
//  WrodHunter
//
//  Created by Maksa on 1/16/16.
//  Copyright © 2016 Manta Ray. All rights reserved.
//

import UIKit
import Foundation

enum EntryStatus {
    case Solved
    case Unsolved
}

class WordEntry : NSObject {
    var word : String
    var positions : [ NSIndexPath ] = [ NSIndexPath ]()
    var direction : WordDirection?
    var status : EntryStatus = EntryStatus.Unsolved
    init( theword: String ) {
        word = theword
    }

    func intersects( otherEntry: WordEntry ) -> Bool {
        let s1 : Set<NSIndexPath> = Set<NSIndexPath>(otherEntry.positions)
        let s2 : Set<NSIndexPath> = Set<NSIndexPath>(self.positions)
        return ( s1.intersect(s2).count > 0 )
    }
    
}
