//
//  RandomFunc.swift
//  Filpping Bird
//
//  Created by Thomas Yu on 5/5/20.
//  Copyright © 2020 Thomas Yu. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat{
    
    
    static func random() -> CGFloat{
        
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    static func random(min : CGFloat, max : CGFloat) -> CGFloat{
        
        return CGFloat.random() * (max - min) + min
    }
    
    
}
