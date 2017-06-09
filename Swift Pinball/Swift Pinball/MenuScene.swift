//
//  MenuScene.swift
//  Swift Pinball
//
//  Created by Mike Hunt on 08/06/2017.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MenuScene:SKScene
{
    //==============================================================
    // Public Override Functions
    //==============================================================
    
    override public func didMove(to view: SKView)
    {
        backgroundColor = SKColor.black;
        DrawText();
    }
    
    override public func sceneDidLoad()
    {
        //Father, forgive me for I have hardcoded.
        GameScore.instance.Lives = 5;
        GameScore.instance.Score = 0;
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        SKTAudio.sharedInstance().playSoundEffect("CoinIn2.wav");
        
        let newScene = GameScene(fileNamed: "GameScene")
        newScene?.scaleMode=scaleMode;
        
        let transition = SKTransition.doorway(withDuration: 1.0);
        self.view?.presentScene(newScene!, transition: transition);
    }
    
    //==============================================================
    // Private Functions
    //==============================================================
    
    private func DrawText()
    {
        let titleLabel = SKLabelNode(text:"Swift");
        SetFontSettings(label: titleLabel, fontColor: SKColor.white, fontSize: 60);
        titleLabel.position = CGPoint(x:self.frame.size.width/2, y:self.frame.size.height/2 + 50)
        
        
        let title2Label = SKLabelNode(text:"Pinball")
        SetFontSettings(label: title2Label, fontColor: SKColor.white, fontSize: 70);
        title2Label.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2);
        
        
        let tipLabel=SKLabelNode(text:"Tap to Begin")
        SetFontSettings(label: tipLabel, fontColor: SKColor.white, fontSize: 40);
        tipLabel.position=CGPoint(x: self.frame.size.width/2, y: tipLabel.fontSize);
        
        self.addChild(titleLabel);
        self.addChild(title2Label);
        self.addChild(tipLabel);
    }
    
    private func SetFontSettings(label: SKLabelNode, fontColor: SKColor, fontSize: Int)
    {
        label.fontName = "Copperplate Bold";
        label.fontColor = fontColor;
        label.fontSize = CGFloat(fontSize);
    }
}
