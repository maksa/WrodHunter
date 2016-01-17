//
//  WordSet.swift
//  WrodHunter
//
//  Created by Maksa on 1/17/16.
//  Copyright © 2016 Manta Ray. All rights reserved.
//

import UIKit

class WordSet: NSObject {
    var wordEntries : [ WordEntry ] = [ WordEntry ]()

    func generatePositionsForWords( words: [String], matrix: (Int, Int) ) {
        for word in words {
            var (direction, positions) = createRandomPositionForWord(word, matrix: matrix)
            let entry = WordEntry(theword: word)
            entry.positions = positions
            entry.direction = direction
            wordEntries.append(entry)
        }
    }
    
    func createRandomPositionForWord( word: String, matrix: (Int, Int) ) -> (WordDirection, [ NSIndexPath ]) {
        NSLog("finding layout for \(word)")
        var (direction, indexpaths) : (WordDirection, [NSIndexPath])
        
        repeat
        {
            (direction, indexpaths) = doCreateRandomPositionForWord(word, matrix: matrix)
            if( !indexpathSetIntersectsWords( indexpaths ) ) {
                return (direction, indexpaths)
            }
        } while( true )
        
        return (direction,indexpaths)
    }
    
    func doCreateRandomPositionForWord( word: String, matrix: (Int, Int) ) -> (WordDirection, [ NSIndexPath ])
    {
        let direction = WordDirection.getRandomDirection()
        switch direction {
        case .LeftRight:
            let randomSection = Int.random( 0..<matrix.1 )
            let startIndex = Int.random( 0...(matrix.0 - word.characters.count - 1))
            let endIndex = startIndex + word.characters.count
            var positions = [ NSIndexPath ]()
            for column in startIndex..<endIndex {
                positions.append(NSIndexPath(forRow: column, inSection: randomSection))
            }
            return (direction, positions)
        case .TopDown:
            var positions = [ NSIndexPath ]()
            let randomColumn = Int.random( 0..<matrix.0 )
            let startIndex = Int.random( 0...(matrix.1 - word.characters.count - 1) )
            let endIndex = startIndex + word.characters.count
            for row in startIndex..<endIndex {
                positions.append(NSIndexPath(forRow: randomColumn, inSection: row ))
            }
            return (direction, positions)
        }
    }

    func indexpathSetIntersectsWords( indexPaths : [ NSIndexPath ] ) -> Bool {
        for entry in wordEntries {
            let s1 = Set<NSIndexPath>( entry.positions )
            let s2 = Set<NSIndexPath>( indexPaths )
            if ( s1.intersect(s2).count > 0 ) {
                NSLog("seku se \(s1) i \(s2)")
                return true
            }
        }
        NSLog("EVO!")
        return false
    }
    
    
    
}
