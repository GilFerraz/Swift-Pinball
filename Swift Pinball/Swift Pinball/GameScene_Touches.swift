//
//  GameScene_Touches.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 05/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene
{
   
    /* Called when a touch has begins. */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            if (location.x < screenWidth/2)
            {
                tappedLeft();
            }
            else
            {
                tappedRight();
            }
        }
    }
    
    /* Called when a touch has moved. */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            self.touchMoved(toPoint: touch.location(in: self))
        }
    }
    
    /* Called when a touch has ended. */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            self.touchUp(atPoint: touch.location(in: self))
        }
    }
    
        /* Called when a touch has cancelled. */
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
}
