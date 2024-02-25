//
//  IESInitValueMarker.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 16.02.24.
//

import UIKit

final class IESInitValueMarker: UIView {
    
    private let markerColor = Resources.Colors.element?.cgColor
    private let markerWidth: CGFloat = 1.5
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        isUserInteractionEnabled = false
        drawMarker()
    }
    
    private func drawMarker() {
        
        let startPoint = CGPoint(x: bounds.midX - markerWidth / 2, y: bounds.maxY)
        let endPoint = CGPoint(x: bounds.midX - markerWidth / 2, y: bounds.minY)
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        let markerLayer = CAShapeLayer()
        markerLayer.path = path.cgPath
        
        markerLayer.strokeColor = markerColor
        markerLayer.lineWidth = markerWidth
        
        layer.addSublayer(markerLayer)
    }
}
