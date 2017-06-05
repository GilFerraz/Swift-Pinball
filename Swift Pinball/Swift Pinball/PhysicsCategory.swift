//
//  PhysicsCategory.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 05/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation

struct PhysicsCategory
{
    static let None           : UInt32 = 0
    static let All            : UInt32 = UInt32.max
    static let BirdCategory   : UInt32 = 0b1         // 1
    static let GroundCategory : UInt32 = 0b10        // 2
    static let PipeCategory   : UInt32 = 0b11        // 3
    static let ScoreCategory  : UInt32 = 0b100       // 4
}
