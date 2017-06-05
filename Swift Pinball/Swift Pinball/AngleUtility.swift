//
//  AngleUtility.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 05/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation
import SpriteKit

class AngleUtility
{
    private static let RadiansToDegrees: CGFloat = 180 / CGFloat(M_PI);
    private static let DegreesToRadians: CGFloat = CGFloat(M_PI) / 180;
    
    public static func ToDegrees(radians: CGFloat) -> CGFloat
    {
        return radians * RadiansToDegrees;
    }
    
    public static func ToRadians(degrees: CGFloat) -> CGFloat
    {
        return degrees * DegreesToRadians;
    }
}
