//
//  ProductSpecificationStackView.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 08.01.2023.
//

import UIKit

final class ProductSpecificationStackView: UIStackView {
    
    // MARK: - Properties
    
    private var cpuLabel: UILabel
    private var cameraLabel: UILabel
    private var ramLabel: UILabel
    private var hddLabel: UILabel
    
    // MARK: - Computed properties
    
    private lazy var cpuWidthConstraint: NSLayoutConstraint = self.createWidthConstraintForLabel(label: self.cpuLabel)
    
    private lazy var cameraWidthConstraint: NSLayoutConstraint = self.createWidthConstraintForLabel(label: cameraLabel)
    
    private lazy var ramWidthConstraint: NSLayoutConstraint =         self.createWidthConstraintForLabel(label: ramLabel)

    
    private lazy var hddWidthConstraint: NSLayoutConstraint = self.createWidthConstraintForLabel(label: hddLabel)
    
    // MARK: - Initialiser
    
    init(cpuLabel: UILabel,
         cameraLabel: UILabel,
         ramLabel: UILabel,
         hddLabel: UILabel) {
        self.cpuLabel = cpuLabel
        self.cameraLabel = cameraLabel
        self.ramLabel = ramLabel
        self.hddLabel = hddLabel
        super.init(frame: .zero)
        axis = .horizontal
        distribution = .fillEqually
        spacing = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        // Create main views
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
        addArrangedSubviews(cpuView,
                            cameraView,
                            ramView,
                            hddView)
        cpuView.addSubviews(cpuImageView, self.cpuLabel)
        cameraView.addSubviews(cameraImageView, self.cameraLabel)
        ramView.addSubviews(ramImageView,self.ramLabel)
        hddView.addSubviews(hddImageView, self.hddLabel)
        
        NSLayoutConstraint.activate([
            // Labels constraints
            cpuWidthConstraint,
            cpuLabel.centerXAnchor.constraint(equalTo: cpuView.centerXAnchor),
            cpuLabel.bottomAnchor.constraint(equalTo: cpuView.bottomAnchor),
            cpuLabel.heightAnchor.constraint(equalToConstant: 14),
            cameraWidthConstraint,
            cameraLabel.centerXAnchor.constraint(equalTo: cameraView.centerXAnchor),
            cameraLabel.bottomAnchor.constraint(equalTo: cameraView.bottomAnchor),
            cameraLabel.heightAnchor.constraint(equalToConstant: 14),
            ramWidthConstraint,
            ramLabel.centerXAnchor.constraint(equalTo: ramView.centerXAnchor),
            ramLabel.bottomAnchor.constraint(equalTo: ramView.bottomAnchor),
            ramLabel.heightAnchor.constraint(equalToConstant: 14),
            hddWidthConstraint,
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

        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private method
    
    private func createWidthConstraintForLabel(label: UILabel) -> NSLayoutConstraint {
        let widthConstraint = label.widthAnchor.constraint(equalToConstant: (label.text?.width(withConstrainedHeight: 8,
                                                                                                  font: .markProRegular(ofSize: 11)))!)
        return widthConstraint
    }
    
    // MARK: - Method
    
    func updateLabelWidthConstraints() {
        self.cpuWidthConstraint.constant = (self.cpuLabel.text?.width(withConstrainedHeight: 8,
                                                              font: .markProRegular(ofSize: 11)))!
        self.cameraWidthConstraint.constant = (self.cameraLabel.text?.width(withConstrainedHeight: 8,
                                                              font: .markProRegular(ofSize: 11)))!
        self.hddWidthConstraint.constant = (self.hddLabel.text?.width(withConstrainedHeight: 8,
                                                              font: .markProRegular(ofSize: 11)))!
        self.ramWidthConstraint.constant = (self.ramLabel.text?.width(withConstrainedHeight: 8,
                                                              font: .markProRegular(ofSize: 11)))!
    }
}
