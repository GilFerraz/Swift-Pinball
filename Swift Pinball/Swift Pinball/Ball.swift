//
//  Ball.swift
//  Swift Pinball
//
//  Created by The Enchantress of the White Juice on 07/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation;
import SpriteKit;

class Ball : SKSpriteNode
{
    private var spawnPoint : CGPoint = CGPoint(x: 0.0, y: 0.0);
    private var heighThreshold : CGFloat = 0.0;
    
    //==============================================================
    // Initializers
    //==============================================================
    
    init()
    {
        let texture = SKTexture(imageNamed: "Ball");
        let color = SKColor.white;
        let size = CGSize(width: 1.0, height: 1.0);
        
        super.init(texture: texture, color: color, size: size);
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    //==============================================================
    // Public Functions
    //==============================================================
    
    public func Initialize(spawnPoint: CGPoint, screenHeight: CGFloat)
    {
        Debug.Log("The ball is initializing...");
        
        self.spawnPoint = spawnPoint;
        self.heighThreshold = -(screenHeight * 0.5) - self.size.height * 0.5;
        
        self.physicsBody!.isDynamic = true;
        self.physicsBody!.categoryBitMask = PhysicsCategory.BallCategory;
        self.physicsBody!.contactTestBitMask = PhysicsCategory.FlipperCategory;
        self.physicsBody!.collisionBitMask = PhysicsCategory.FlipperCategory;
    }
    
    public func CheckIfResetBall() -> Bool
    {
        if self.position.y < heighThreshold
        {
            ResetBall();
            
            return true;
        }
        
        return false;
    }
    
    //==============================================================
    // Private Functions
    //==============================================================
    
    private func ResetBall()
    {
        Debug.Log("The ball is resetting...");
        
        let spawnPosition = spawnPoint;
        self.position = spawnPosition;
        
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0);
        self.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 1000));
    }
}
