//
//  MyEmptyStateView.swift
//  Example
//
//  Created by Antonio Zaitoun on 25/05/2017.
//  Copyright © 2017 Antonio Zaitoun. All rights reserved.
//

import UIKit

@IBDesignable
class MyEmptyStateView: AZEmptyStateView{
    
    let defaultFont = "Helvetica-Light"
    
    
    @IBInspectable
    public var messageFontSize: CGFloat = 16.0{
        didSet{
            if let currentFontName: String = textLabel?.font.fontName
                , let font = UIFont(name: currentFontName, size: messageFontSize){
                textLabel.font = font
            }
        }
    }
    
    @IBInspectable
    public var messageFont: String{
        get{
            return textLabel.font.fontName
        }set{
            if let font = UIFont(name: newValue, size: messageFontSize){
                textLabel.font = font
            }
        }
    }
    
    @IBInspectable
    public var messageTextColor: UIColor{
        get{
            return textLabel.textColor
        }set{
            textLabel.textColor = newValue
        }
    }
    
    @IBInspectable
    public var imageRatioMultiplier: CGFloat = 0.5{
        didSet{
            if imageConstraint != nil {
                imageConstraint.isActive = false
            }
            
            if stackView != nil{
                imageConstraint = imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: imageRatioMultiplier)
                imageConstraint.isActive = true
            }
        }
    }
    
    // stackview ref
    fileprivate var stackView: UIStackView!
    
    // image constraint ref
    fileprivate var imageConstraint: NSLayoutConstraint!
    
    // update button background
    override var buttonTint: UIColor{
        set{
            super.buttonTint = newValue
            self.button.backgroundColor = newValue
        }get{
            return super.buttonTint
        }
    }
    
    //Use image with content mode of `scale aspect fit`
    override func setupImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    //Use the default label with extra modifications, such as different font and different color.
    override func setupLabel() -> UILabel {
        let label = super.setupLabel()
        label.font = UIFont(name: "Helvetica-Light", size: 16)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }
    
    //use a custom subclass of UIButton
    override func setupButton() -> UIButton {
        return HighlightableButton()
    }
    
    //setup the stack view to your liking
    override func setupStack(_ imageView: UIImageView, _ textLabel: UILabel, _ button: UIButton) -> UIStackView {
        stackView = super.setupStack(imageView, textLabel, button)
        stackView.spacing = 14
        stackView.alignment = .center
        button.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8).isActive = true
        
        imageConstraint = imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: imageRatioMultiplier)
        imageConstraint.isActive = true
        
        return stackView
    }
}

class HighlightableButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.737254902, blue: 0.6117647059, alpha: 1)
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    override var isHighlighted: Bool{
        set{
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.alpha = newValue ? 0.5 : 1
                self?.transform = newValue ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            }
            super.isHighlighted = newValue
        }get{
            return super.isHighlighted
        }
    }
}
