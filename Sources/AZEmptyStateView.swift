//
//  AZEmptyStateView.swift
//
//
//  Created by Antonio Zaitoun on 24/05/2017.
//  Copyright © 2017 Antonio Zaitoun. All rights reserved.
//

import UIKit

@IBDesignable
public class AZEmptyStateView: UIControl{
    
    /// The empty state image
    @IBInspectable
    public var image: UIImage{
        get{
            return imageView.image!
        }set{
            imageView.image = newValue
        }
    }
    
    
    /// The empty state message
    @IBInspectable
    public var message: String{
        get{
            return textLabel.text ?? ""
        }set{
            textLabel.text = newValue
        }
    }
    
    
    /// The button's text
    @IBInspectable
    public var buttonText: String{
        get{
            return button.title(for: [])!
        }set{
            button.setTitle(newValue, for: [])
        }
    }
    
    @IBInspectable
    public var buttonTint: UIColor{
        get{
            return button.tintColor
        }set{
            button.layer.borderColor = newValue.cgColor
            button.tintColor = newValue
        }
    }
    
    
    /// Is the button visable
    @IBInspectable
    public var buttonHidden: Bool = false{
        didSet{
            button.isHidden = buttonHidden
        }
    }
    
    fileprivate(set) open var imageView: UIImageView!
    
    fileprivate(set) open var textLabel: UILabel!
    
    fileprivate(set) open var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    /// Convenience initailizer
    ///
    /// - Parameters:
    ///   - image: The image of the empty state
    ///   - message: The message of the empty sate
    ///   - buttonText: The text on the button, if nil then button will be hidden.
    public convenience init(image: UIImage ,message: String, buttonText: String? = nil){
        self.init(frame: CGRect.zero)
        self.image = image
        self.message = message
        if let buttonText = buttonText {
            self.buttonText = buttonText
        }else{
            buttonHidden = true
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    final override public func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        button.addTarget(target, action: action, for: controlEvents)
    }
    
    /// A function that is called when it's time to setup the label.
    ///
    /// - Returns: The label view.
    internal func setupLabel()->UILabel{
        let textLabel = UILabel()
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        return textLabel
    }
    
    
    /// A function that is called when it's time to setup the image view.
    ///
    /// - Returns: The image view.
    internal func setupImage()->UIImageView{
        return UIImageView()
    }
    
    
    /// A function that is called when it's time to setup the button.
    ///
    /// - Returns: The button.
    internal func setupButton()->UIButton{
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5
        button.layer.borderColor = button.tintColor.cgColor
        button.layer.borderWidth = 1
        return button
    }
    
    
    /// A function that is called when it's time to setup the stack of the empty state which contains all the views.
    ///
    /// - Parameters:
    ///   - imageView: The image view of the empty state.
    ///   - textLabel: The label of the empty state.
    ///   - button: The button of the empty state.
    /// - Returns: The stack view.
    internal func setupStack(_ imageView: UIImageView,_ textLabel: UILabel,_ button: UIButton)->UIStackView{
        let stackView = UIStackView(arrangedSubviews: [imageView,textLabel,button])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }
    
    
    fileprivate func setup(){
        backgroundColor = .clear
        imageView = setupImage()
        textLabel = setupLabel()
        button = setupButton()
        let stackView = setupStack(imageView,textLabel,button)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
    }

}
