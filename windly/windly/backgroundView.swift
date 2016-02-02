//
//  backgroundView.swift
//  stormy
//
//  Created by Kyle Ong on 1/28/16.
//  Copyright © 2016 Kyle Ong. All rights reserved.
//

import UIKit

class backgroundView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        // Background View
        
        //// Color Declarations
        let steelBlue: UIColor = UIColor(red: 0.274, green: 0.509, blue: 0.705, alpha: 1.000)
        let lightSlateGray: UIColor = UIColor(red: 0.467, green: 0.533, blue: 0.600, alpha: 1.000)
        
        let context = UIGraphicsGetCurrentContext()
        
        //// Gradient Declarations
        let purpleGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [steelBlue.CGColor, lightSlateGray.CGColor], [0, 1])
        
        //// Background Drawing
        let backgroundPath = UIBezierPath(rect: CGRectMake(0, 0, self.frame.width, self.frame.height))
        CGContextSaveGState(context)
        backgroundPath.addClip()
        CGContextDrawLinearGradient(context, purpleGradient,
            CGPointMake(160, 0),
            CGPointMake(160, 568),
            [.DrawsBeforeStartLocation, .DrawsAfterEndLocation])
        
    }
    

}
//01/28/2016 - modify the appearance of the table view - custom drawing