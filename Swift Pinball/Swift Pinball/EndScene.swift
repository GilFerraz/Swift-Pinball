//
//  SecondScene.swift
//  Swift Pinball
//
//  Created by Mike Hunt on 08/06/2017.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EndScene:SKScene
{
    //==============================================================
    // Public Override Functions
    //==============================================================
    
    override public func didMove(to view: SKView)
    {
        backgroundColor = SKColor.black;
        DrawGameOverScreen();
    }
    
    override public func sceneDidLoad()
    {
        print(GameScore.instance.Score);
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {        
        let newScene = MenuScene(size:self.size);
        newScene.scaleMode = scaleMode;
        
        let transition=SKTransition.doorsOpenHorizontal(withDuration: 1);
        self.view?.presentScene(newScene,transition:transition);
    }
    
    //==============================================================
    // Private Functions
    //==============================================================
    
    private func DrawGameOverScreen()
    {
        let gameOverLabel=SKLabelNode(text:"Game Over")
        SetFontSettings(label: gameOverLabel, fontColor: SKColor.white, fontSize: 70);
        gameOverLabel.position=CGPoint(x:self.frame.size.width/2, y:self.frame.size.height/2);
        
        let scoreDisplayLabel=SKLabelNode(text:"Score: \(GameScore.instance.Score)")
        SetFontSettings(label: scoreDisplayLabel, fontColor: SKColor.white, fontSize: 40);
        scoreDisplayLabel.position=CGPoint(x:self.frame.size.width/2,
                                           y:(self.frame.size.height/2) - scoreDisplayLabel.fontSize);
        
        let tipLabel=SKLabelNode(text:"Tap to Retry")
        SetFontSettings(label: tipLabel, fontColor: SKColor.white, fontSize: 40);
        tipLabel.position=CGPoint(x:self.frame.size.width/2,y:tipLabel.fontSize);
        
        self.addChild(gameOverLabel);
        self.addChild(scoreDisplayLabel);
        self.addChild(tipLabel);
    }
    
    private func SetFontSettings(label: SKLabelNode, fontColor: SKColor, fontSize: Int)
    {
        label.fontName = "Copperplate Bold";
        label.fontColor = fontColor;
        label.fontSize = CGFloat(fontSize);
    }
}
