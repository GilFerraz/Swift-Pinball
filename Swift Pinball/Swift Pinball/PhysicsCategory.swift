//
//  PhysicsCategory.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 05/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import Foundation

enum Physics : UInt32
{
    case BallCategory = 2
    case ArrowsCategory = 4
    case FlipperCategory = 8
    case BumperCategory = 16
}

struct PhysicsCategory
{
    static let None            : UInt32 = 0;
    static let All             : UInt32 = UInt32.max;
    static let BallCategory    : UInt32 = Physics.BallCategory.rawValue;
    static let ArrowsCategory  : UInt32 = Physics.ArrowsCategory.rawValue;
    static let FlipperCategory : UInt32 = Physics.FlipperCategory.rawValue;
    static let BumperCategory  : UInt32 = Physics.BumperCategory.rawValue;
}
