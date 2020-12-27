//
//  GradientTextField.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 26/12/2020.
//

import UIKit

@IBDesignable
class GradientTextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 0 { didSet { layer.cornerRadius = cornerRadius }}
    @IBInspectable var borderWidth:  CGFloat = 0 { didSet { layer.borderWidth = borderWidth }}
    @IBInspectable var borderColor:  UIColor = .white { didSet { layer.borderColor = borderColor.cgColor }}
    @IBInspectable var startColor:   UIColor = .black { didSet { gradientLayer.startColor = startColor }}
    @IBInspectable var endColor:     UIColor = .white { didSet { gradientLayer.endColor = endColor }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { gradientLayer.startLocation = startLocation }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { gradientLayer.endLocation = endLocation }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { gradientLayer.horizontalMode = horizontalMode }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { gradientLayer.diagonalMode = diagonalMode }}
    
    override public class var layerClass: AnyClass { GradientLayer.self }
    var gradientLayer: GradientLayer { layer as! GradientLayer }

    
    override public func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.viewDidLayoutSubViews()
    }
    

}
