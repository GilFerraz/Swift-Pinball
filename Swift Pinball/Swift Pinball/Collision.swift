//
//  CollisionUtility.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 07/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation
import SpriteKit

public class Collision
{
    public static func DidCollideBothWays(contact: SKPhysicsContact, categoryBitMask: UInt32) -> Bool
    {
        let bodyA : SKPhysicsBody = contact.bodyA;
        let bodyB : SKPhysicsBody = contact.bodyB;
        
        if (bodyA.categoryBitMask == categoryBitMask)
        {
            return true;
        }
        
        if (bodyB.categoryBitMask == categoryBitMask)
        {
            return true;
        }
        
        return false;
    }
}
