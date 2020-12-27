//
//  SoundHelper.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 27/12/2020.
//

import AVFoundation

class SoundHelper{
   
    static let shared = SoundHelper()

    let url: URL
    let player: AVAudioPlayer?

    init() {
        url = Bundle.main.url(forResource: "S_Bubbles", withExtension: "m4r")!
        player = try? AVAudioPlayer(contentsOf: url)
    }
    
    func playOperationDone(){
        guard let _ = player else {return}
        player?.prepareToPlay()
        player?.play()
    }
    
}
