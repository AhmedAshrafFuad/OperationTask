//
//  SoundExtensions.swift
//  nKitchen
//
//  Created by AHMED ASHRAF on 6/13/19.
//  Copyright © 2019 KnockTarget. All rights reserved.
//

import AVFoundation

extension SandwichVC{
   
    func addSound(){
        let url = Bundle.main.url(forResource: "S_Bubbles", withExtension: "m4r")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }

            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func removeSound(){
        
        let url = Bundle.main.url(forResource: "your-turn", withExtension: "m4r")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
}

extension LunchBoxVC{
    
    func addSound(){
        let url = Bundle.main.url(forResource: "S_Bubbles", withExtension: "m4r")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func removeSound(){
        let url = Bundle.main.url(forResource: "your-turn", withExtension: "m4r")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
}

extension MakeYourOwnVC{
    func addSound(){
        let url = Bundle.main.url(forResource: "S_Bubbles", withExtension: "m4r")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func removeSound(){
        
        let url = Bundle.main.url(forResource: "your-turn", withExtension: "m4r")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
}
