//
//  UIAnimation.swift
//  Swift Pinball
//
//  Created by The Enchantress of the White Juice on 07/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation
import SpriteKit

class UIAnimation
{
    public func FadeIn(node: SKNode, withDuration: CGFloat)
    {
        let fadeInAction = SKAction.fadeIn(withDuration: 2.0);
     
        node.alpha = 0.0;
        node.run(fadeInAction);
    }
}
