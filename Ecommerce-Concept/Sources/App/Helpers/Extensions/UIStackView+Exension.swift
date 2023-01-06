//
//  UIStackView+Exension.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 17.12.2022.
//

import UIKit

extension UIStackView {
    convenience init(with axis: NSLayoutConstraint.Axis,
         distribution: UIStackView.Distribution = .fill,
         spacing: CGFloat = 0,
         layoutMargins: UIEdgeInsets = .zero) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
        if layoutMargins != .zero {
            isLayoutMarginsRelativeArrangement = true
            self.layoutMargins = layoutMargins
        }
    }
    
    final func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
    
    static func addProductSpecificationStack(cpuLabel: UILabel,
                                             cameraLabel: UILabel,
                                             ramLabel: UILabel,
                                             hddLabel: UILabel) -> UIStackView {
        // Create main views
        let mainStack = UIStackView(with: .horizontal,
                                    distribution: .fillEqually,
                                    spacing: 10)
        let cpuView = UIView()
        let cameraView = UIView()
        let ramView = UIView()
        let hddView = UIView()
        let cpuImageView = UIImageView(baseImage: UIImage(named: "CPU"),
                                       with: .lightGray)
        let cameraImageView = UIImageView(baseImage: UIImage(named: "Camera"),
                                          with: .lightGray)
        let ramImageView = UIImageView(baseImage: UIImage(named: "RAM"),
                                       with: .lightGray)
        let hddImageView = UIImageView(baseImage: UIImage(named: "HDD"),
                                       with: .lightGray)
        // Setup hierarchy
        mainStack.addArrangedSubviews(cpuView,
                                      cameraView,
                                      ramView,
                                      hddView)
        cpuView.addSubviews(cpuImageView, cpuLabel)
        cameraView.addSubviews(cameraImageView, cameraLabel)
        ramView.addSubviews(ramImageView,ramLabel)
        hddView.addSubviews(hddImageView, hddLabel)
        
        // Setup layout
        
        NSLayoutConstraint.activate([
            // Labels constraints
            cpuLabel.widthAnchor.constraint(equalToConstant: (cpuLabel.text?.width(withConstrainedHeight: 8,
                                                                                   font: .markProRegular(ofSize: 11)))!),
            cpuLabel.centerXAnchor.constraint(equalTo: cpuView.centerXAnchor),
            cpuLabel.bottomAnchor.constraint(equalTo: cpuView.bottomAnchor),
            cpuLabel.heightAnchor.constraint(equalToConstant: 14),
            cameraLabel.widthAnchor.constraint(equalToConstant: (cameraLabel.text?.width(withConstrainedHeight: 8,
                                                                                         font: .markProRegular(ofSize: 11)))!),
            cameraLabel.centerXAnchor.constraint(equalTo: cameraView.centerXAnchor),
            cameraLabel.bottomAnchor.constraint(equalTo: cameraView.bottomAnchor),
            cameraLabel.heightAnchor.constraint(equalToConstant: 14),
            ramLabel.widthAnchor.constraint(equalToConstant: (ramLabel.text?.width(withConstrainedHeight: 8,
                                                                                   font: .markProRegular(ofSize: 11)))!),
            ramLabel.centerXAnchor.constraint(equalTo: ramView.centerXAnchor),
            ramLabel.bottomAnchor.constraint(equalTo: ramView.bottomAnchor),
            ramLabel.heightAnchor.constraint(equalToConstant: 14),
            hddLabel.widthAnchor.constraint(equalToConstant: (hddLabel.text?.width(withConstrainedHeight: 8,
                                                                                   font: .markProRegular(ofSize: 11)))!),
            hddLabel.centerXAnchor.constraint(equalTo: hddView.centerXAnchor),
            hddLabel.bottomAnchor.constraint(equalTo: hddView.bottomAnchor),
            hddLabel.heightAnchor.constraint(equalToConstant: 14),
            // ImageViews constraints
            cpuImageView.heightAnchor.constraint(equalToConstant: 28),
            cpuImageView.widthAnchor.constraint(equalToConstant: 28),
            cpuImageView.centerXAnchor.constraint(equalTo: cpuLabel.centerXAnchor),
            cpuImageView.topAnchor.constraint(equalTo: cpuView.topAnchor),
            cameraImageView.heightAnchor.constraint(equalToConstant: 22),
            cameraImageView.widthAnchor.constraint(equalToConstant: 28),
            cameraImageView.centerXAnchor.constraint(equalTo: cameraLabel.centerXAnchor),
            cameraImageView.topAnchor.constraint(equalTo: cameraView.topAnchor),
            ramImageView.heightAnchor.constraint(equalToConstant: 21),
            ramImageView.widthAnchor.constraint(equalToConstant: 28),
            ramImageView.centerXAnchor.constraint(equalTo: ramLabel.centerXAnchor),
            ramImageView.topAnchor.constraint(equalTo: ramView.topAnchor),
            hddImageView.heightAnchor.constraint(equalToConstant: 22),
            hddImageView.widthAnchor.constraint(equalToConstant: 19),
            hddImageView.centerXAnchor.constraint(equalTo: hddLabel.centerXAnchor),
            hddImageView.topAnchor.constraint(equalTo: hddView.topAnchor)
        ])
        
        return mainStack
    }
}
