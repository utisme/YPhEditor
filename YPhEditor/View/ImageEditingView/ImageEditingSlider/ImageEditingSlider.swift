//
//  ImageEditingSlider.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 14.02.24.
//

// TODO: - доделать инерцию

import UIKit
import RxSwift

final class ImageEditingSlider: UIControl {
    
    private let thumb = IESThumb()
    private let initValueMarker = IESInitValueMarker()
    
    private let selectionFeetbackGenerator = UISelectionFeedbackGenerator()
    
    private let resistanceCoef: CGFloat = 0.01
    private let inertionCoef: CGFloat = 0.001
    
    private var thumbCenter: CGFloat = 0 {
        didSet {
            updateThumbPosition()
            thumbCenter = correctThumbPositionIfNeeded(thumbCenter, withCenter: false)
            generateVibrationIfNeeded()
            sendActions(for: .valueChanged)
        }
    }
    private var firstPosition: CGFloat = 0
    private var dragDelta: CGFloat = 0
    private var vibrationFilter: CGFloat = 0
    
    private var minValue: CGFloat = 0
    private var maxValue: CGFloat = 100
    private var initValue: CGFloat = 50
    private(set) var value: CGFloat {
        get {
            switch thumbCenter {
            case (...bounds.minX):
                return maxValue
            case(bounds.maxX...):
                return minValue
            default:
                let percentage = 1 - ((thumbCenter - bounds.minX) / (bounds.maxX - bounds.minX))
                let result = ((maxValue - minValue) * percentage) + minValue
                return result.rounded()
            }
        }
        set {
            switch newValue {
            case (...minValue):
                thumbCenter = bounds.maxX
            case (maxValue...):
                thumbCenter = bounds.minX
            default:
                let percentage = 1 - ((newValue - minValue) / (maxValue - minValue))
                let result = ((bounds.maxX - bounds.minX) * percentage) + bounds.minX
                thumbCenter = result
            }
        }
    }
    
    convenience init(minValue: CGFloat, maxValue: CGFloat, initValue: CGFloat) {
        self.init(frame: .zero)
        
        self.minValue = minValue
        self.maxValue = maxValue
        self.initValue = initValue
        
        configure()
        configureAppearance()
        setupSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        constraintSubviews()
        value = initValue
    }
    
// MARK: GENERAL LOGIC
    // (CONSISTENTLY)
    @objc private func grabFirstPosition(_ sender: UIButton, forEvent event: UIEvent) {
        
        guard let touch = event.allTouches?.first else { return }
        let location = touch.location(in: self)
        
        firstPosition = location.x
    }
    
    @objc private func calculateNewPosition(_ sender: UIButton, forEvent event: UIEvent) {
        
        guard let touch = event.allTouches?.first else { return }
        let location = touch.location(in: self)
        
        let currentPosition = location.x
        dragDelta = firstPosition - currentPosition
        
        firstPosition = currentPosition
        thumbCenter = thumbCenter - dragDelta
    }
    
    private func updateThumbPosition() {
        
        thumb.center = CGPoint(x: thumbCenter, y: bounds.midY)
    }
    
    private func generateVibrationIfNeeded() {
        
        let value = value
        guard 
            value.truncatingRemainder(dividingBy: 5) == 0,
            value != vibrationFilter
        else { return }
        vibrationFilter = value
        selectionFeetbackGenerator.selectionChanged()
        
//        if value == initValue {
//            (0...10).forEach { _ in
//                selectionFeetbackGenerator.prepare()
//                selectionFeetbackGenerator.selectionChanged()
//            }
//        }
    }
    
    @objc func returnWithinLimits() {

//        while abs(dragDelta) > inertionCoef {
//            dragDelta = dragDelta - (inertionCoef * dragDelta)            // TODO: - инерция слишком резкая из-за цикла while
//            thumbCenter = thumbCenter - dragDelta
//        }
        
        let _ = Timer.scheduledTimer(withTimeInterval: 0.006, repeats: true) { [weak self] timer in
            guard let self else { return }
            if self.thumbCenter == self.correctThumbPositionIfNeeded(self.thumbCenter, withCenter: true) {
                timer.invalidate()
            } else {
                self.thumbCenter = self.correctThumbPositionIfNeeded(self.thumbCenter, withCenter: true)
            }
        }
    }
    
//MARK: - SUPPORTIVE FUNCS
    
    private func correctThumbPositionIfNeeded(_ center: CGFloat, withCenter centerFlag: Bool) -> CGFloat {
        
        var attenuationCoef: CGFloat
        let correctedCenter: CGFloat
        
        switch center {
            
        case (bounds.maxX...):
            
            attenuationCoef = (center - bounds.maxX) * resistanceCoef
            correctedCenter = center - attenuationCoef.rounded(to: 2)
        
        case(...bounds.minX):
            
            attenuationCoef = (bounds.minX - center) * resistanceCoef
            correctedCenter = center + attenuationCoef.rounded(to: 2)
        
        case ((bounds.midX - thumb.ticksInterval)...(bounds.midX + thumb.ticksInterval)):
            
            if centerFlag {
                attenuationCoef = -(bounds.midX - center) * resistanceCoef
                correctedCenter = center - attenuationCoef.rounded(to: 2)
            } else {
                fallthrough
            }
            
        default:
            return center
        }
        return correctedCenter
    }
}

// MARK: - CONFIGURATIONS
extension ImageEditingSlider {
    
    private func configure() {
        
        addTarget(nil, action: #selector(grabFirstPosition), for: .touchDown)
        addTarget(nil, action: #selector(calculateNewPosition), for: [.touchDragInside, .touchDragEnter])
        addTarget(nil, action: #selector(returnWithinLimits), for: [.touchUpInside, .touchDragExit])
    }
    
    private func configureAppearance() {
        
    }
    	
    private func setupSubviews() {
        
        addSubviews(thumb, initValueMarker)
    }
    
    private func constraintSubviews() {
        
        thumb.frame.size = CGSize(width: bounds.width, height: 20)
        thumb.setInitPoint(withInitMarkerAt: (initValue - minValue) / (maxValue - minValue))
        initValueMarker.frame = CGRect(x: Int(bounds.midX), y: Int(bounds.midY) - 9, width: 2, height: 20)
    }
}
