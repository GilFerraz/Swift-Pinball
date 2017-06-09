//
//  Light.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 08/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation;
import SpriteKit;

class Light : SKSpriteNode
{
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
    
    public func Initialize()
    {
        let randomNum = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * 2;
        let randomTime:TimeInterval = TimeInterval(randomNum);
        
        let inactiveTexture = SKTexture(imageNamed: "Light (Inactive)");
        let activeTexture = SKTexture(imageNamed: "Light (Active)");
        
        let textureList = [activeTexture, inactiveTexture];
        let animationAction = SKAction.animate(with: textureList, timePerFrame: randomTime);
        self.run(SKAction.repeatForever(animationAction));
        
        // Sets the default texture.
        self.texture = inactiveTexture;
    }
}
