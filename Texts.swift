//
//  Texts.swift
//  WrodHunter
//
//  Created by Maksa on 1/16/16.
//  Copyright © 2016 Manta Ray. All rights reserved.
//

import UIKit

class Texts: NSObject {
    var text = "Била једном три прасета. Два прасета су била весели другари, који су волели песму и игру. Треће им је често говорило: Боље би било да сазидате неку кућицу у којој бисте били сигурни од љутог вука, уместо што се играте по цео дан. И оно је сазидало за себе лепу камену кућицу. Прво прасе је тада рекло: Па добро, и направило кућицу од сламе. Али, вук је дошао и почео да дува и напослетку одувао целу кућицу. Тада је прво прасе отрчало, што је брже могло, другом брату, који је саградио кућицу од дрвета. Међутим вук је стигао за њим и опет почео да дува што је могао јаче. Одувао је, разуме се, опет целу кућицу. Два прасета су онда отрчала кући трећег брата. Пусти нас унутра Вук нам је одувао кућице и сад нам је за петама, закукала су браћа. Брат их је увео у кућу, а убрзо се појавио и вук. Пусти ме унутра, викнуо је, иначе ћу и твоју кућицу одувати. Покушај само одговорило му је прасе. И вук је дувао и дувао, али кућица није пала. Онда се попео на кров и покушао да уђе у кућу кроз димњак. Али треће прасе га је чуло и запалило велику ватру на огњишту. Вук је пропао кроз димњак право у ватру и изгорео"
    var cleanedUpString : String = ""
    var words : [ String ] = [ String ]()
    override init() {
        var nonalpha : Set<Character> = Set<Character>()
        nonalpha.insert(".")
        nonalpha.insert(",")
        nonalpha.insert(":")
        for char in text.uppercaseString.characters {
            if( !nonalpha.contains( char )) {
                cleanedUpString.append( char )
            }
        }
        words = cleanedUpString.characters.split{$0 == " "}.map(String.init)
    }
    
    func randomWords( howMany: Int, maximumlength: Int ) -> [ String ] {
        var set = Set<String>()
        while( set.count < howMany ) {
            var randomWord = ""
            repeat {
                let randomIndex = Int.random(0...words.count-1)
                randomWord = words[randomIndex]
            } while (randomWord.characters.count > maximumlength )
            if ( !set.contains(randomWord) && randomWord.characters.count > 3 ) {
                    set.insert(randomWord)
            }

        }
        return Array(set)
    }

}
