//
//  Alphabet.swift
//  WrodHunter
//
//  Created by Maksa on 1/16/16.
//  Copyright © 2016 Manta Ray. All rights reserved.
//

import UIKit

class Alphabet: NSObject {
    var all_letters = [ "А",
        "Б",
        "В",
        "Г",
        "Д",
        "Ђ",
        "Е",
        "Ж",
        "З",
        "И",
        "Ј",
        "К",
        "Л",
        "Љ",
        "М",
        "Н",
        "Њ",
        "О",
        "П",
        "Р",
        "С",
        "Т",
        "Ћ",
        "У",
        "Ф",
        "Х",
        "Ц",
        "Ч",
        "Џ",
        "Ш"]
    
    var randomLetter : String {
        get {
            let index = Int.random(0...all_letters.count-1)
            return all_letters[index]
    
        }
    }
}
