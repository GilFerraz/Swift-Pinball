//
//  Bumper.swift
//  Swift Pinball
//
//  Created by The Enchantress of the White Juice on 07/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation;
import SpriteKit;

class Bumper : SKSpriteNode
{
    public var PointsToGive: Int
    {
        get
        {
            return pointsToGive;
        }
    }
    
    internal var pointsToGive: Int = 0;
    internal var animationAction: SKAction?;
    
    //==============================================================
    // Initializers
    //==============================================================
    
    init()
    {
        let texture = SKTexture(imageNamed: "Bumper");
        let color = SKColor.white;
        let size = CGSize(width: 1.0, height: 1.0);
        
        super.init(texture: texture, color: color, size: size);
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    public func Initialize(pointsToGive: Int)
    {
        self.pointsToGive = pointsToGive;
        
        InitializePhysicsBody();
        InitializeAnimationAction();
    }
    
    //==============================================================
    // Public Functions
    //==============================================================
    
    public func Collided()
    {
        self.run(animationAction!);
    }
    
    //==============================================================
    // Internal Functions
    //==============================================================
    
    internal func InitializePhysicsBody()
    {
        self.physicsBody!.isDynamic = false;
        self.physicsBody!.affectedByGravity = false;
        self.physicsBody!.allowsRotation = false;
        
        self.physicsBody!.categoryBitMask = PhysicsCategory.BumperCategory;
        self.physicsBody!.collisionBitMask = PhysicsCategory.BallCategory;
        self.physicsBody!.contactTestBitMask = PhysicsCategory.BallCategory;
    }
    
    internal func InitializeAnimationAction()
    {
        let inactiveTexture = SKTexture(imageNamed: "Inactive");
        let semiActiveTexture = SKTexture(imageNamed: "Semi-Active");
        let activeTexture = SKTexture(imageNamed: "Active");
        
        let textureList = [semiActiveTexture, activeTexture, inactiveTexture];
        animationAction = SKAction.animate(with: textureList, timePerFrame: 0.05);
        
        // Sets the default texture.
        self.texture = inactiveTexture;
    }
}
