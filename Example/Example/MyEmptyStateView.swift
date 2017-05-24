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
        let stack = super.setupStack(imageView, textLabel, button)
        stack.spacing = 14
        stack.alignment = .center
        button.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.8).isActive = true
        imageView.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.5).isActive = true
        return stack
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
