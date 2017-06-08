//
//  MusicPlayer.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 08/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation;
import SpriteKit;

class MusicPlayer
{
    private var music: SKAudioNode;
    
    init(scene: SKScene, fileNamed: String)
    {
        music = SKAudioNode(fileNamed: fileNamed);
        music.autoplayLooped = true;
        
        scene.addChild(music);
    }
    
    public func Play()
    {
        //music.run(SKAction.play());
    }
}
