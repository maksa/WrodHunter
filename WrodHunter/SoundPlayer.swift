import UIKit
import Foundation
import AudioToolbox

class SoundPlayer: NSObject {
    func applause() {

        let notepath = NSBundle.mainBundle().pathForResource("aplauz", ofType: "aiff")
        let noteurl = NSURL.fileURLWithPath( notepath! )
        var mySound : SystemSoundID = 0
        
        AudioServicesCreateSystemSoundID(noteurl, &mySound)
        // Play
        AudioServicesPlaySystemSound(mySound);
    
    }
}
