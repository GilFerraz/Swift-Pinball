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
    //==============================================================
    // Private Varaibles
    //==============================================================
    
    private var scene: SKScene;
    
    private var ballCollision: SKAudioNode;
    private var ballRelease: SKAudioNode;
    private var bumper: SKAudioNode;
    private var flipperUp: SKAudioNode;
    private var gate: SKAudioNode;
    private var rollyingMaybe: SKAudioNode;
    private var gameOver: SKAudioNode;
    
    private let playAction = SKAction.play();
    
    //==============================================================
    // Initializer
    //==============================================================
    
    init(scene: SKScene)
    {
        self.scene = scene;
        
        ballCollision = SKAudioNode(fileNamed: "BallCollision2.wav");
        ballRelease = SKAudioNode(fileNamed: "BallRelease4.caf");
        bumper = SKAudioNode(fileNamed: "Target2.wav");
        flipperUp = SKAudioNode(fileNamed: "FlipperUp.wav");
        gate = SKAudioNode(fileNamed: "Gate4.wav");
        rollyingMaybe = SKAudioNode(fileNamed: "RollyingMaybe.caf");
        gameOver = SKAudioNode(fileNamed: "GameOver.mp3");
        
        InitializeAudioNode(audioNode: ballCollision);
        InitializeAudioNode(audioNode: ballRelease);
        InitializeAudioNode(audioNode: bumper);
        InitializeAudioNode(audioNode: flipperUp);
        InitializeAudioNode(audioNode: gate);
        InitializeAudioNode(audioNode: rollyingMaybe);
        InitializeAudioNode(audioNode: gameOver);
    }
    
    //==============================================================
    // Public Functions
    //==============================================================
    
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
    
    public func PlayGameOver()
    {
        gameOver.run(SKAction.changeVolume(to: 0.7, duration: 0.0));
        PlaySoundEffect(audioNode: gameOver);
    }
    
    //==============================================================
    // Private Functions
    //==============================================================
    
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
