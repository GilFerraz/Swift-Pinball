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
    //Scenes related stuff
    override func didMove(to view: SKView)
    {
        backgroundColor=SKColor.black
        DrawText()
    }
    
    override func sceneDidLoad()
    {
        //Father, forgive me for I have hardcoded.
        GameScore.instance.Lives=5
        GameScore.instance.Score=0
    }
    
    //Auxilliary Stuff
    func DrawText()
    {
        let titleLabel = SKLabelNode(text:"Swift")
        titleLabel.fontName = "Copperplate Bold";
        titleLabel.fontColor = SKColor.white
        titleLabel.fontSize = 60
        titleLabel.position = CGPoint(x:self.frame.size.width/2, y:self.frame.size.height/2 + 50)
        self.addChild(titleLabel)
        
        let title2Label = SKLabelNode(text:"Pinball")
        title2Label.fontName = "Copperplate Bold";
        title2Label.fontColor = SKColor.white
        title2Label.fontSize = 70
        title2Label.position=CGPoint(x:self.frame.size.width/2, y:self.frame.size.height/2)
        self.addChild(title2Label)
        
        let tipLabel=SKLabelNode(text:"Tap to Begin")
        tipLabel.fontName = "Copperplate Bold";
        tipLabel.fontColor=SKColor.white
        tipLabel.fontSize=40
        tipLabel.position=CGPoint(x:self.frame.size.width/2,y:tipLabel.fontSize)
        self.addChild(tipLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let newScene = GameScene(fileNamed: "GameScene")
        newScene?.scaleMode=scaleMode;
        
        let transition=SKTransition.flipVertical(withDuration: 1)
        self.view?.presentScene(newScene!,transition:transition);
    }
}
