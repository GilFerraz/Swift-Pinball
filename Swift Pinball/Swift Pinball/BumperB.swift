//
//  BumperB.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 08/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation;
import SpriteKit;

class BumperB : Bumper
{   
    //==============================================================
    // Initializers
    //==============================================================
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    //==============================================================
    // Internal Functions
    //==============================================================
    
    internal override func InitializePhysicsBody()
    {
        self.physicsBody!.isDynamic = false;
        self.physicsBody!.affectedByGravity = false;
        self.physicsBody!.allowsRotation = false;
        
        self.physicsBody!.categoryBitMask = PhysicsCategory.BumperCategory;
        self.physicsBody!.collisionBitMask = PhysicsCategory.BallCategory;
        self.physicsBody!.contactTestBitMask = PhysicsCategory.BallCategory;
    }
    
    internal override func InitializeAnimationAction()
    {
        let semiActiveTexture = SKTexture(imageNamed: "Bumper B (Semi-Active)");
        let activeTexture = SKTexture(imageNamed: "Bumper B (Active)");
        
        let textureList = [activeTexture, semiActiveTexture];
        animationAction = SKAction.animate(with: textureList, timePerFrame: 0.05);
        
        // Sets the default texture.
        self.texture = semiActiveTexture;
    }
}
