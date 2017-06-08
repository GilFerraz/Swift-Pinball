//
//  SoundsPlayer.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 08/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation
import SpriteKit;

class SoundsPlayer
{
    private var scene: SKScene;
    
    private var ballCollision: SKAudioNode;
    private var ballRelease: SKAudioNode;
    private var bumper: SKAudioNode;
    private var flipperUp: SKAudioNode;
    private var gate: SKAudioNode;
    private var rollyingMaybe: SKAudioNode;
    private var slingShots: SKAudioNode;
    
    private let playAction = SKAction.play();
    
    init(scene: SKScene)
    {
        self.scene = scene;
        
        ballCollision = SKAudioNode(fileNamed: "BallCollision2.wav");
        ballRelease = SKAudioNode(fileNamed: "BallRelease4.caf");
        bumper = SKAudioNode(fileNamed: "Bumper.mp3");
        flipperUp = SKAudioNode(fileNamed: "FlipperUp.wav");
        gate = SKAudioNode(fileNamed: "Gate4.wav");
        rollyingMaybe = SKAudioNode(fileNamed: "RollyingMaybe.caf");
        slingShots = SKAudioNode(fileNamed: "SlingShots.caf");
        
        InitializeAudioNode(audioNode: ballCollision);
        InitializeAudioNode(audioNode: ballRelease);
        InitializeAudioNode(audioNode: bumper);
        InitializeAudioNode(audioNode: flipperUp);
        InitializeAudioNode(audioNode: gate);
        InitializeAudioNode(audioNode: rollyingMaybe);
        InitializeAudioNode(audioNode: slingShots);
    }
    
    public func PlayBallCollision()
    {
        PlaySoundEffect(audioNode: ballCollision);
    }
    
    public func PlayBallRealease()
    {
        PlaySoundEffect(audioNode: ballRelease);
    }
    
    public func PlayFlipperUp()
    {
        PlaySoundEffect(audioNode: flipperUp);
    }
    
    public func PlayGate()
    {
        PlaySoundEffect(audioNode: gate);
    }
    
    public func PlayBumper()
    {
        bumper.run(SKAction.changeVolume(to: 0.7, duration: 0.0));
        PlaySoundEffect(audioNode: bumper);
    }
    
    private func InitializeAudioNode(audioNode: SKAudioNode)
    {
        audioNode.autoplayLooped = false;
        scene.addChild(audioNode);
    }
    
    private func PlaySoundEffect(audioNode: SKAudioNode)
    {
        audioNode.run(playAction);
    }
}
