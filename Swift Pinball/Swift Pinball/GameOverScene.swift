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

class GameOverScene:SKScene{
    
    // Scene Transition Stuff
    override func didMove(to view: SKView) {
        backgroundColor=SKColor.black
        DrawGameOverScreen()
    }
    
    override func sceneDidLoad() {
        print(GameScore.instance.Score)
    }
    //Auxiliary Functions
    func DrawGameOverScreen()
    {
        let gameOverLabel=SKLabelNode(text:"Game Over")
        gameOverLabel.fontColor=SKColor.white
        gameOverLabel.fontSize=70
        gameOverLabel.position=CGPoint(x:self.frame.size.width/2,y:self.frame.size.height/2)
        self.addChild(gameOverLabel)
        
        let scoreDisplayLabel=SKLabelNode(text:"Score: \(GameScore.instance.Score)")
        scoreDisplayLabel.fontColor=SKColor.white
        scoreDisplayLabel.fontSize=40
        scoreDisplayLabel.position=CGPoint(x:self.frame.size.width/2,y:(self.frame.size.height/2)-scoreDisplayLabel.fontSize)
        self.addChild(scoreDisplayLabel)
        
        let tipLabel=SKLabelNode(text:"Tap to Retry")
        tipLabel.fontColor=SKColor.white
        tipLabel.fontSize=40
        tipLabel.position=CGPoint(x:self.frame.size.width/2,y:tipLabel.fontSize)
        self.addChild(tipLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let newScene=GameScene(size:self.size)
        newScene.scaleMode=scaleMode
    }
}
