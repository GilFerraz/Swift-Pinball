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

class MenuScene:SKScene{
    //Scenes related stuff
    override func didMove(to view: SKView) {
        backgroundColor=SKColor.black
        DrawText()
    }
    
    override func sceneDidLoad() {
        //Father, forgive me for I have hardcoded
        GameScore.instance.Lives=5
        GameScore.instance.Score=0
    }
    
    //Auxilliary Stuff
    func DrawText()
    {
        let titleLabel=SKLabelNode(text:"Swift Pinball")
        titleLabel.fontColor=SKColor.white
        titleLabel.fontSize=70
        titleLabel.position=CGPoint(x:self.frame.size.width/2,y:self.frame.size.height/2)
        self.addChild(titleLabel)
        
        let tipLabel=SKLabelNode(text:"Tap to Begin")
        tipLabel.fontColor=SKColor.white
        tipLabel.fontSize=40
        tipLabel.position=CGPoint(x:self.frame.size.width/2,y:tipLabel.fontSize)
        self.addChild(tipLabel)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let newScene = GameScene(fileNamed: "GameScene")
        newScene?.scaleMode=scaleMode
        let transition=SKTransition.flipVertical(withDuration: 1)
        self.view?.presentScene(newScene!,transition:transition)
    }
}
