//
//  CustomButton.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 17.12.2022.
//

import UIKit.UIButton

class CustomButton: UIButton {
    
    // MARK: - Properties
    
    // Optional coordinator necessary for back-type button
    
    private var coordinator: CoordinatorProtocol?
    
    // MARK: - Initialise
    
    ///  Custom Button initalise
    /// - Parameters:
    ///   - internalObject: Attention! internal visual object must be either String object type or UIImage object type
    ///   - objectColor: image color
    ///   - backgroundView:  background views corner style
    ///   - textStyle: internal title label style, occur necessary only with defined internalObject as String type
    ///   - isBackButton: setup default back-type buttons view, for setup back action must implement     [setupBackButton](x-source-tag://setupBackButton)  method
    init(internalObject: Any?,
         objectColor: UIColor?,
         backgroundView: BackgroundViewStyle,
         textStyle: TextStyle = .mediumButtonStyle,
         isBackButton: Bool = false) {
        super.init(frame: .zero)
        if let internalObject = internalObject, let objectColor = objectColor {
            if let internalImage = internalObject as? UIImage {
                self.setImage(internalImage.withTintColor(objectColor,
                                                           renderingMode: .alwaysOriginal), for: .normal)
                self.imageView?.contentMode = .center
            } else if let internalString = internalObject as? String {
                setTitle(internalString, for: .normal)
                titleLabel?.textAlignment = .center
                switch textStyle {
                case .smallButtonStyle:
                    titleLabel?.font = .markProBold(ofSize: 13)
                    setTitleColor(objectColor, for: .normal)
                case .bigButtonStyle:
                    titleLabel?.font = .markProBold(ofSize: 20)
                    setTitleColor(objectColor, for: .normal)
                case .mediumButtonStyle:
                    titleLabel?.font = .markProMedium(ofSize: 18)
                    setTitleColor(objectColor, for: .normal)
                }
            }
        } else if isBackButton  {
            self.setImage(UIImage(named: "left-shield")?.withTintColor(.white, renderingMode: .alwaysOriginal),
                          for: .normal)
            
        }
        translatesAutoresizingMaskIntoConstraints = false
        switch backgroundView {
        case .circle(let color, let buttonHeight):
            layer.masksToBounds = true
            setBackgroundImage(UIImage(color: color,
                                       size: CGSize(width: 40, height: 40)), for: .normal)
            layer.cornerRadius = buttonHeight / 2
        case .roundedCorner(let color):
            layer.masksToBounds = true
            setBackgroundImage(UIImage(color: color,
                                       size: CGSize(width: 40, height: 40)), for: .normal)
            layer.cornerRadius = 10
        case .none:
            return
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    static func createFavoriteButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "noFillHeart"),
                        for: .normal)
        button.setImage(UIImage(named: "fillHeart"),
                        for: .selected)
        button.backgroundColor = .white
        button.imageView?.contentMode = .center
        button.layer.cornerRadius = 25 / 2
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 10
        button.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0,
                                                                   y: 0,
                                                                   width: 25,
                                                                   height: 25),
                                               cornerRadius: 25/2).cgPath
        button.layer.shadowOffset = .zero
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    func addCheckMarkToButton() {
        setImage(UIImage(named: "checkmark"), for: .selected)
    }
    
    /// - Tag: setupBackButton
    func setupBackButton(viewControllersCoordinator: CoordinatorProtocol) {
        coordinator = viewControllersCoordinator
        self.addTarget(self, action: #selector(backAction),
                       for: .touchUpInside)
    }
    
    // MARK: - Private Methods
    
    @objc
    private func backAction() {
        guard let coordinator = coordinator else { return }
        coordinator.returnBack()
    }
}

extension CustomButton {
    enum BackgroundViewStyle {
        case circle(color: UIColor,
                    buttonHeight: CGFloat)
        case roundedCorner(color: UIColor)
        case none
    }
    
    enum TextStyle {
        case smallButtonStyle, mediumButtonStyle, bigButtonStyle
    }
}
