//
//  CartViewController.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 09.01.2023.
//

import UIKit

class CartViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var coordinator: CoordinatorProtocol!
    
    // MARK: - Views
    
    private lazy var backButton = CustomButton(internalObject: nil,
                                               objectColor: nil,
                                               backgroundView: .roundedCorner(color: .customDarkBlue),
                                               isBackButton: true)
    private var addAddressButton = CustomButton(internalObject: UIImage(named: "addAddress"),
                                                objectColor: .white,
                                                backgroundView: .roundedCorner(color: .customOrange))
    private lazy var addAddressLabel = UILabel(constant: Strings.addAddressLabelText,
                                              with: Metrics.addAddressLabelTextSize,
                                              and: .medium, .customDarkBlue)
    private lazy var cartTitleLabel = UILabel(constant: Strings.cartTitleLabelText,
                                              with: Metrics.cartTitleLabelTextSize,
                                              and: .bold, .customDarkBlue)
    private lazy var cartContainerView = UIView(background: .customDarkBlue,
                                                cornerType: .rounded)
    private lazy var cartListTabelView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.dataSource = self
        tableView.rowHeight = 40
        return tableView
    }()
    private lazy var tableViewUnderline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var totalParentStackView = UIStackView(with: .horizontal,
                                                        spacing: Metrics.totalParentStackViewSpacing)
    private lazy var keysStack = UIStackView(with: .vertical, distribution: .fillEqually)
    private lazy var valueStack = UIStackView(with: .vertical, distribution: .fillEqually)
    private lazy var totalLabel = UILabel(constant: Strings.totalLabelText,
                                          with: Metrics.totalLabelTextSize,
                                          and: .regular,
                                          .white)
    private lazy var deliveryLabel = UILabel(constant: Strings.deliveryLabelText,
                                             with: Metrics.deliveryLabelTextSize,
                                             and: .regular,
                                             .white)
    
    private lazy var totalValueLabel = UILabel(constant: Strings.valueLabelsPlaceholderText,
                                               with: Metrics.totalValueLabelTextSize,
                                               and: .bold,
                                               .white)
    private lazy var deliveryValueLabel = totalValueLabel.copy() as! UILabel
    private lazy var totalStackUnderline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var checkoutButton = CustomButton(internalObject: Strings.checkoutButtonText,
                                                   objectColor: .white,
                                                   backgroundView: .roundedCorner(color: .customOrange),
                                                   textStyle: .bigButtonStyle)
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        view.addSubviews(backButton,
                         addAddressButton,
                         addAddressLabel,
                         cartTitleLabel,
                         cartContainerView)
        cartContainerView.addSubviews(cartListTabelView,
                                      tableViewUnderline,
                                      totalParentStackView,
                                      totalStackUnderline,
                                      checkoutButton)
        totalParentStackView.addArrangedSubviews(keysStack, valueStack)
        keysStack.addArrangedSubviews(totalLabel,
                                      deliveryLabel)
        valueStack.addArrangedSubviews(totalValueLabel,
                                       deliveryValueLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // MARK: backButton constraints
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.backButtonTopInset),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.backButtonLeadingInset),
            backButton.heightAnchor.constraint(equalToConstant: Metrics.titleButtonsMainSize),
            backButton.widthAnchor.constraint(equalToConstant: Metrics.titleButtonsMainSize),
            
            // MARK: addAddressButton constraints
            addAddressButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            addAddressButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Metrics.addAddressButtonTrailingInset),
            addAddressButton.heightAnchor.constraint(equalToConstant: Metrics.titleButtonsMainSize),
            addAddressButton.widthAnchor.constraint(equalToConstant: Metrics.titleButtonsMainSize),
            
            // MARK: addAddressLabel constraints
            addAddressLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            addAddressLabel.trailingAnchor.constraint(equalTo: addAddressButton.leadingAnchor, constant: Metrics.addAddressLabelTrailingInset),
            addAddressLabel.heightAnchor.constraint(equalToConstant: Metrics.addAddressLabelHeight),
            addAddressLabel.widthAnchor.constraint(equalToConstant: Metrics.returnLabelsWidth(text: addAddressLabel.text!,
                                                                                              with: 11,
                                                                                              and: .markProMedium(ofSize: Metrics.addAddressLabelTextSize))),
            // MARK: cartTitleLabel constraints
            cartTitleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.cartTitleLabelTopInset),
            cartTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.cartTitleLabelLeadingInset),
            cartTitleLabel.heightAnchor.constraint(equalToConstant: Metrics.cartTitleLabelHeight),
            cartTitleLabel.widthAnchor.constraint(equalToConstant: Metrics.returnLabelsWidth(text: cartTitleLabel.text!,
                                                                                             with: Metrics.cartTitleLabelHeight, 
                                                                                             and: .markProBold(ofSize: Metrics.cartTitleLabelTextSize))),
            // MARK: cartContainerView constraints
            cartContainerView.topAnchor.constraint(equalTo: cartTitleLabel.bottomAnchor, constant: Metrics.cartContainerViewTopInset),
            cartContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // MARK: CartListTableView Constraints
            cartListTabelView.topAnchor.constraint(equalTo: cartContainerView.topAnchor, constant: Metrics.cartListTabelViewTopInset),
            cartListTabelView.leadingAnchor.constraint(equalTo: cartContainerView.leadingAnchor, constant: Metrics.cartListTabelViewLeadingInset),
            cartListTabelView.trailingAnchor.constraint(equalTo: cartContainerView.trailingAnchor),
            cartListTabelView.heightAnchor.constraint(equalToConstant: Metrics.cartListTabelViewHeight),
             
            // MARK: TableViewUnderline Constraints
            tableViewUnderline.topAnchor.constraint(equalTo: cartListTabelView.bottomAnchor),
            tableViewUnderline.leadingAnchor.constraint(equalTo: cartContainerView.leadingAnchor, constant: Metrics.tableViewUnderlineSideInset),
            tableViewUnderline.trailingAnchor.constraint(equalTo: cartContainerView.trailingAnchor, constant: -Metrics.tableViewUnderlineSideInset),
            tableViewUnderline.heightAnchor.constraint(equalToConstant: Metrics.tableViewUnderlineHeight),
            
            // MARK: Total Stack Constraints
            totalParentStackView.topAnchor.constraint(equalTo: tableViewUnderline.bottomAnchor, constant: Metrics.totalParentStackViewTopInset),
            totalParentStackView.leadingAnchor.constraint(equalTo: cartContainerView.leadingAnchor, constant: Metrics.totalParentStackViewLeadingInset),
            totalParentStackView.trailingAnchor.constraint(equalTo: cartContainerView.trailingAnchor, constant: Metrics.totalParentStackViewTrailingInset),
            totalParentStackView.heightAnchor.constraint(equalToConstant: Metrics.totalParentStackViewHeight),
            
            // MARK: TotalStackUnderline Constraints
            totalStackUnderline.topAnchor.constraint(equalTo: totalParentStackView.bottomAnchor, constant: Metrics.totalStackUnderlineTopInset),
            totalStackUnderline.leadingAnchor.constraint(equalTo: cartContainerView.leadingAnchor, constant: Metrics.tableViewUnderlineSideInset),
            totalStackUnderline.trailingAnchor.constraint(equalTo: cartContainerView.trailingAnchor, constant: -Metrics.tableViewUnderlineSideInset),
            totalStackUnderline.heightAnchor.constraint(equalToConstant: Metrics.totalStackUnderlineHeight),
            
            // MARK: CheckoutButton Constraints
            checkoutButton.topAnchor.constraint(equalTo: totalStackUnderline.bottomAnchor, constant: Metrics.checkoutButtonTopInset),
            checkoutButton.leadingAnchor.constraint(equalTo: cartContainerView.leadingAnchor, constant: Metrics.checkoutButtonLeadingInset),
            checkoutButton.trailingAnchor.constraint(equalTo: cartContainerView.trailingAnchor, constant: Metrics.checkoutButtonTrailingInset),
            checkoutButton.bottomAnchor.constraint(equalTo: cartContainerView.bottomAnchor, constant: Metrics.checkoutButtonBottomInset)
        ])
    }
    
    private func setupView() {
        // view setup
        view.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        // backButton setup
        backButton.setupBackButton(viewControllersCoordinator: coordinator)
    }
}

extension CartViewController {
    enum Metrics {
        static let backButtonTopInset: CGFloat = 65
        static let backButtonLeadingInset: CGFloat = 42
        static let titleButtonsMainSize: CGFloat = 37
        
        static let addAddressButtonTrailingInset: CGFloat = -48
        
        static let addAddressLabelTextSize: CGFloat = 15
        static let addAddressLabelTrailingInset: CGFloat = -9
        static let addAddressLabelHeight: CGFloat = 19
        
        static let cartTitleLabelTextSize: CGFloat = 35
        static let cartTitleLabelTopInset: CGFloat = 28
        static let cartTitleLabelLeadingInset: CGFloat = 42
        static let cartTitleLabelHeight: CGFloat = 44
        
        static let cartContainerViewTopInset: CGFloat = 30
        
        static let cartListTabelViewTopInset: CGFloat = 51
        static let cartListTabelViewLeadingInset: CGFloat = 23
        static let cartListTabelViewHeight: CGFloat = 394
        
        static let tableViewUnderlineHeight: CGFloat = 2
        static let tableViewUnderlineSideInset: CGFloat = 4
        
        static let totalParentStackViewSpacing: CGFloat = 194
        static let totalParentStackViewTopInset: CGFloat = 15
        static let totalParentStackViewLeadingInset: CGFloat = 55
        static let totalParentStackViewHeight: CGFloat = 50
        static let totalParentStackViewTrailingInset: CGFloat = -20
        
        static let totalLabelTextSize: CGFloat = 15
        static let deliveryLabelTextSize: CGFloat = 15
        static let totalValueLabelTextSize: CGFloat = 15
        
        static let totalStackUnderlineTopInset: CGFloat = 16
        static let totalStackUnderlineHeight: CGFloat = 1
        
        static let checkoutButtonTopInset: CGFloat = 21
        static let checkoutButtonLeadingInset: CGFloat = 44
        static let checkoutButtonTrailingInset: CGFloat = -44
        static let checkoutButtonBottomInset: CGFloat = -44
        
        static func returnLabelsWidth(text: String,
                                      with constrainedHeight: CGFloat,
                                      and font: UIFont) -> CGFloat {
            return text.width(withConstrainedHeight: constrainedHeight, font: font)
        }
    }
    
    enum Strings {
        static let addAddressLabelText = "Add address"
        static let cartTitleLabelText = "Cart"
        static let totalLabelText = "Total"
        static let deliveryLabelText = "Delivery"
        static let valueLabelsPlaceholderText = "Unknown"
        static let checkoutButtonText = "Checkout"
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.backgroundColor = .gray
        var content = cell.defaultContentConfiguration()
        content.text = "хуй"
        cell.contentConfiguration = content
        return cell
        
    }
}
