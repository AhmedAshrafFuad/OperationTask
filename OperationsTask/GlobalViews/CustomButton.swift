//
//  CustomButton.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 26/12/2020.
//

import UIKit


@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 { didSet { layer.cornerRadius = cornerRadius }}
    @IBInspectable var startColor:   UIColor = .black { didSet { gradientLayer.startColor = startColor }}
    @IBInspectable var endColor:     UIColor = .white { didSet { gradientLayer.endColor = endColor }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { gradientLayer.startLocation = startLocation }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { gradientLayer.endLocation = endLocation }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { gradientLayer.horizontalMode = horizontalMode }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { gradientLayer.diagonalMode = diagonalMode }}
    
    override public class var layerClass: AnyClass { GradientLayer.self }
    var gradientLayer: GradientLayer { layer as! GradientLayer }
    
 
    var isTapped: Bool =  false {
        didSet {
            if subviews.contains(selectionView) {
                selectionView.removeFromSuperview()
            }else{
                addSubview(selectionView)
            }
        }
    }
    
    private lazy var selectionView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = .black
        view.alpha = 0.3
        view.layer.borderColor = UIColor.blue.cgColor
        return view
    }()
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.viewDidLayoutSubViews()
    }
    
    
    func removeSelection(){
        selectionView.removeFromSuperview()
    }
    
}
