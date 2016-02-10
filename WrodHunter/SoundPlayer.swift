import UIKit
import Foundation
import AudioToolbox
import AVFoundation

class SoundPlayer: NSObject {
    var player : AVAudioPlayer = AVAudioPlayer()
    
    func applause() {

        let notepath = NSBundle.mainBundle().pathForResource("aplauz", ofType: "aiff")
        let noteurl = NSURL.fileURLWithPath( notepath! )
        var mySound : SystemSoundID = 0
        
        AudioServicesCreateSystemSoundID(noteurl, &mySound)
        // Play
        AudioServicesPlaySystemSound(mySound);
        
//        do {
//            let player : AVAudioPlayer = try AVAudioPlayer(contentsOfURL: noteurl)
//            player.prepareToPlay()
//            player.play()
//        } catch  {
//            NSLog("couldn't play sound")
//        }
        
    
    }
}
