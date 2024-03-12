//
//  IEFCollectionViewCellProgressView.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 16.02.24.
//

import UIKit

final class IEFCollectionViewCellProgressView: BaseView {
    
    func prepareForDrawing() {
        layer.sublayers?.removeAll()
        layoutIfNeeded()
    }
    
    func configure() {
        prepareForDrawing()
        addCircleSublayer()
    }
    
    func configure(filledTo percent: CGFloat) {
        prepareForDrawing()
        addCircleSublayer(color: Resources.Colors.elementYellowSelected?.cgColor)
        addCircleSublayer(filledTo: percent, color: Resources.Colors.elementYellow?.cgColor)
    }
    
    func configure(filledTo percent: CGFloat, clockwise: Bool) {
        prepareForDrawing()
        addCircleSublayer(color: Resources.Colors.elementYellowSelected?.cgColor)
        addCircleSublayer(filledTo: abs(percent), color: Resources.Colors.elementYellow?.cgColor, clockwise: clockwise)
    }
    
    private func addCircleSublayer(filledTo percent: CGFloat? = nil,
                                   color: CGColor? = Resources.Colors.elementGray?.cgColor,
                                   clockwise: Bool = true) {
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = bounds.width / 2
        let startAngle = 3 * CGFloat.pi / 2
        let endAngle = clockwise ? (7 * CGFloat.pi / 2) : (-CGFloat.pi / 2)
        
        let circlePath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise)
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.lineWidth = 2
        circleLayer.strokeColor = color
        circleLayer.fillColor = UIColor.clear.cgColor
        if let percent {
            circleLayer.strokeEnd = percent
        }
        
        layer.addSublayer(circleLayer)
    }
}
