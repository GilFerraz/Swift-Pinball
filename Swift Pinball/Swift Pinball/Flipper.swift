//
//  Flipper.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 06/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation
import SpriteKit

class Flipper : SKSpriteNode, IFlipper
{
    var IsUp: Bool = false;
    var LowerRotationLimit: CGFloat = 0.0;
    var UpperRotationLimit: CGFloat = 0.0;
    
    func Initialize(upperRotationLimit: CGFloat, lowerRotationLimit: CGFloat)
    {
        self.UpperRotationLimit = upperRotationLimit;
        self.LowerRotationLimit = lowerRotationLimit;
        self.IsUp = false;
    }
    
    func Update()
    {

    }
}

protocol IFlipper
{
    var UpperRotationLimit : CGFloat { get };
    var LowerRotationLimit : CGFloat { get };
    var IsUp : Bool { get };
    
    func Initialize(upperRotationLimit : CGFloat, lowerRotationLimit : CGFloat);
    func Update();
}
