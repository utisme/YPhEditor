//
//  IESThumb.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 15.02.24.
//

import Foundation
import UIKit

final class IESThumb: BaseView {
    
    private let ticksAmount: CGFloat = 200 / 5
    private let ticksWidth: CGFloat = 1
    private let elementsColor = Resources.Colors.elementGray?.cgColor
    private let markersColor = Resources.Colors.element?.cgColor
    
    private var initValueMarkerPoint: CGPoint!
    private let initValueMarkerWidth: CGFloat = 6
    
    lazy var ticksInterval: CGFloat = bounds.maxX / ticksAmount
    
    override func layoutSubviews() {
        
        isUserInteractionEnabled = false
        drawTicks()
        drawInitValueMarker(at: initValueMarkerPoint)
    }
    
    private func drawInitValueMarker(at point: CGPoint) {
        
        let path = UIBezierPath()
        path.move(to: point)
        path.addLine(to: point)
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = markersColor
        layer.lineWidth = initValueMarkerWidth
        layer.lineCap = .round
        
        self.layer.addSublayer(layer)
    }
    
    private func drawTicks() {
        
        var xPosition = bounds.minX
        let ticksInterval: CGFloat = bounds.maxX / ticksAmount
        
        var startPoint = CGPoint(x: xPosition, y: bounds.midY)
        var endPoint = CGPoint(x: xPosition, y: bounds.maxY)
        
        (0...Int(ticksAmount)).forEach {
            
            startPoint = CGPoint(x: xPosition, y: bounds.midY)
            endPoint = CGPoint(x: xPosition, y: bounds.maxY)
            
            let tickPath = UIBezierPath()
            tickPath.move(to: startPoint)
            tickPath.addLine(to: endPoint)
            
            let tickLayer = CAShapeLayer()
            tickLayer.path = tickPath.cgPath
            
            tickLayer.lineWidth = ticksWidth
            if $0 % 10 == 0 {
                tickLayer.strokeColor = markersColor
            } else {
                tickLayer.strokeColor = elementsColor
            }
            
            xPosition += ticksInterval
            
            layer.addSublayer(tickLayer)
        }
    }
    
    func setInitPoint(withInitMarkerAt xCoord: CGFloat) {
        
        initValueMarkerPoint = CGPoint(x: bounds.minX + (xCoord * (bounds.maxX - bounds.minX)), y: bounds.minY)
    }
}
