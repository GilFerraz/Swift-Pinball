//
//  Arrows.swift
//  Swift Pinball
//
//  Created by The Enchantress of the White Juice on 07/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation;
import SpriteKit;

class Arrows : SKSpriteNode
{
    private var forceToApply: CGVector?;
    
    //==============================================================
    // Initializers
    //==============================================================
    
    init()
    {
        let texture = SKTexture(imageNamed: "Arrows");
        let color = SKColor.white;
        let size = CGSize(width: 1.0, height: 1.0);
        
        super.init(texture: texture, color: color, size: size);
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    public func Initialize(forceToApply: CGVector, timePerFrame: CGFloat)
    {
        // Sets the force to apply when the ball collides with the arrows.
        self.forceToApply = forceToApply;
        
        // Sets the physics body.
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size);
        self.physicsBody!.isDynamic = false;
        self.physicsBody!.affectedByGravity = false;
        self.physicsBody!.allowsRotation = false;
        self.physicsBody!.pinned = true;
        self.physicsBody!.categoryBitMask = Physics.ArrowsCategory.rawValue //PhysicsCategory.ArrowsCategory;
        self.physicsBody!.contactTestBitMask = Physics.BallCategory.rawValue //PhysicsCategory.BallCategory;
        self.physicsBody!.collisionBitMask = 0;
        
        // Sets the animation's action.
        let timeInterval = TimeInterval(timePerFrame);
        
        let arrowsA = SKTexture(imageNamed: "Arrow1");
        let arrowsB = SKTexture(imageNamed: "Arrow2");
        let arrowsC = SKTexture(imageNamed: "Arrow3");
        let arrowsList = [arrowsA, arrowsB, arrowsC];
        
        let action = SKAction.animate(with: arrowsList, timePerFrame: timeInterval);
        self.run(SKAction.repeatForever(action));
    }
    
    public func Collided(ball: Ball)
    {
        ball.physicsBody?.applyForce(forceToApply!);
    }
}
