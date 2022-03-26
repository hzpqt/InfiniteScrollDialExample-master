//
//  InfiniteScrollUnit.swift
//  InfiniteScrollDial
//
//  Created by konhondros on 30/6/15.
//  Copyright (c) 2015 http://www.konhondros.com All rights reserved.
//

import Foundation
import Cocoa

class InfiniteScrollUnit: NSView {
    
    
    // MARK: - Properties
    
    var value: Int! {
        didSet {
            self.needsDisplay = true
        }
    }
    
    
    // MARK: - Initializers
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Methods
    
    
    // MARK: - Draw Content
    
    override func draw(_ dirtyRect: NSRect) {
        
        // Colors
        
        //let color = NSColor(calibratedRed: 0.405, green: 0.694, blue: 0.914, alpha: 1)
        let color = NSColor.white
        
        // Get current context
        guard let context = NSGraphicsContext.current else { return }
        
        
        
        // Rectangle Drawing
        
        let rectanglePath = NSBezierPath(rect: NSMakeRect(0, 0, self.frame.width, self.frame.height))
        color.setFill()
        rectanglePath.fill()
        
        
        let ticks: CGFloat = 10
        let space = self.frame.width / ticks
        
        var tickColor:NSColor!
        var tickHeight:CGFloat = 0
        var tickWidth:CGFloat = 0
        
        for i in 0...Int(ticks) {
            if i != Int(ticks) / 2 {
                tickHeight = self.frame.height * 0.2
                tickWidth = 2
                tickColor = NSColor.orange
            } else {
                tickHeight = self.frame.height * 0.3
                tickWidth = 2
                tickColor = NSColor.black
            }
            
            self.drawTick(context: context.cgContext, pointX: CGFloat(i) * space, width: tickWidth, height: tickHeight, color: tickColor)
        }
        
        //// Text Drawing
        if self.value != nil {
            let textRect = NSMakeRect(self.frame.width / 2 - 40, self.frame.height * 0.4, 80, 40)
            
            let textTextContent = NSString(string: String(self.value))
            let textStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            textStyle.alignment = NSTextAlignment.center
            
            let textFontAttributes = [NSAttributedString.Key.font: NSFont.systemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: NSColor.black, NSAttributedString.Key.paragraphStyle: textStyle]
            
            let textTextHeight: CGFloat = textTextContent.boundingRect(with: NSMakeSize(textRect.width, CGFloat.infinity), options: NSString.DrawingOptions.usesLineFragmentOrigin, attributes: textFontAttributes).size.height
            let textTextRect: NSRect = NSMakeRect(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight)
            
            NSGraphicsContext.saveGraphicsState()
            textRect.clip()
            textTextContent.draw(in: NSOffsetRect(textTextRect, 0, 0), withAttributes: textFontAttributes)
            NSGraphicsContext.restoreGraphicsState()
        }
    }
    
    func drawTick(context: CGContext, pointX: CGFloat, width: CGFloat, height: CGFloat, color: NSColor) {
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(width)
        context.setLineCap(.round)
        context.move(to: CGPoint(x: pointX, y: 0))
        context.addLine(to: CGPoint(x: pointX, y: height))
        context.strokePath()
    }

}
