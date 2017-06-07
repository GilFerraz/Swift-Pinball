//
//  Flipper.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 06/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation
import SpriteKit

class Flipper : SKSpriteNode
{
    private var isUp = false;
    private var lowerRotationLimit: CGFloat = 0.0;
    private var upperRotationLimit: CGFloat = 0.0;
    
    private var upRotation: CGFloat = 0.0;
    private var lowerRotation: CGFloat = 0.0;
    
    private var actionDuration: TimeInterval = TimeInterval();
    private var upRotationAction: SKAction = SKAction();
    private var downRotationAction: SKAction = SKAction();
    
    private var shouldApplyImpulse: Bool = false;
 
    //==============================================================
    // Initializers
    //==============================================================
    
    init()
    {
        let texture = SKTexture(imageNamed: "Flipper");
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
    
    public func Initialize(upperRotationLimit: CGFloat, lowerRotationLimit: CGFloat, actionDuration: CGFloat)
    {
        self.isUp = false;
        self.upperRotationLimit = upperRotationLimit;
        self.lowerRotationLimit = lowerRotationLimit;
        
        self.upRotation = Angle.ToRadians(degrees: upperRotationLimit);
        self.lowerRotation = Angle.ToRadians(degrees: lowerRotationLimit);
        
        self.actionDuration = TimeInterval(actionDuration);
        self.upRotationAction = SKAction.rotate(byAngle: upRotation, duration: self.actionDuration);
        self.downRotationAction = SKAction.rotate(byAngle: lowerRotation, duration: self.actionDuration);
        
        self.physicsBody!.isDynamic = false;
        self.physicsBody!.categoryBitMask = PhysicsCategory.FlipperCategory;
        self.physicsBody!.collisionBitMask = PhysicsCategory.BallCategory;
        self.physicsBody!.contactTestBitMask = PhysicsCategory.BallCategory;
    }
    
    public func MoveUp()
    {
        if !isUp
        {
            self.shouldApplyImpulse = true;
            self.run(upRotationAction, completion: { self.shouldApplyImpulse = false; });
            isUp = true;
        }
    }
    
    public func MoveDown()
    {
        if isUp
        {
            self.run(downRotationAction);
            isUp = false;
        }
    }
    
    public func CheckIfApllyImpulse(ball: Ball, impulse: CGVector)
    {
        if shouldApplyImpulse
        {
          ball.physicsBody?.applyImpulse(impulse);
        }
    }
}
