//
//  AngleUtility.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 05/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation
import SpriteKit

class Angle
{
    private static let Pi: CGFloat = CGFloat(Double.pi);
    private static let RadiansToDegrees: CGFloat = 180 / Pi;
    private static let DegreesToRadians: CGFloat = Pi / 180;
    
    public static func ToDegrees(radians: CGFloat) -> CGFloat
    {
        return radians * RadiansToDegrees;
    }
    
    public static func ToRadians(degrees: CGFloat) -> CGFloat
    {
        return degrees * DegreesToRadians;
    }
}
