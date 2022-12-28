//
//  BottomSheetFilterControllerView.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 24.12.2022.
//

import UIKit

class BottomSheetFilterControllerView: UIViewController, UITableViewDelegate {
    
    // MARK: - View and Properties
    
    var viewModel: BottomSheetFilterViewViewModelType!
    
    private lazy var containerView = UIView(background: .white,
                                            cornerType: .rounded)
    private lazy var titleStackView = UIStackView(with: .horizontal,
                                                  layoutMargins: Metrics.titleStackViewLayotMargins)
    private lazy var closeBottomSheetButton = CustomButton(internalObject: UIImage(named: "xmark") ?? UIImage(),
                                                           objectColor: .white,
                                                           backgroundView: .roundedCorner(color: .customDarkBlue))
    private lazy var titleLabel = UILabel(constant: Strings.constantTitleLabelText,
                                          with: Metrics.titleLabelTextSize,
                                          and: .medium,
                                          .customDarkBlue,
                                          adjustFontSizeToFit: false)
    private lazy var doneButton = CustomButton(internalObject: Strings.constantDoneButtonText,
                                               objectColor: .white,
                                               backgroundView: .roundedCorner(color: .customOrange),
                                               textStyle: .smallButtomStyle)
    private lazy var filterParametersTableView: UITableView = {
        let tableView = UITableView(background: .clear)
        tableView.register(FilterParametersTableViewCell.self,
                           forCellReuseIdentifier: FilterParametersTableViewCell.reuseID)
        tableView.register(FilterParametersTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: FilterParametersTableViewHeader.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = Metrics.filterParametersTableViewHeight
        tableView.isScrollEnabled = false
        return tableView
    }()
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        view.addSubview(containerView)
        containerView.addSubviews(titleStackView,
                                  filterParametersTableView)
        titleStackView.addArrangedSubviews(closeBottomSheetButton,
                                           titleLabel,
                                           doneButton)
    }
    
    private func setupLayout() {
        containerView.fillSuperview()
        preferredContentSize = CGSize(width: Metrics.screenWidth,
                                      height: Metrics.containerViewHeight)
        view.heightAnchor.constraint(equalToConstant: Metrics.containerViewHeight).isActive = true
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleStackView.heightAnchor.constraint(equalToConstant: Metrics.titleLabelHeight)
        ])
        
        NSLayoutConstraint.activate([
            closeBottomSheetButton.widthAnchor.constraint(equalToConstant: Metrics.closeButtonWidth)
        ])
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: Metrics.titleLabelWidth)
        ])
        NSLayoutConstraint.activate([
            filterParametersTableView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor),
            filterParametersTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                               constant: Metrics.filterParametersTableViewLayotMargins.left),
            filterParametersTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                                constant: -Metrics.filterParametersTableViewLayotMargins.right),
            filterParametersTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                                              constant: Metrics.filterParametersTableViewLayotMargins.bottom)
        ])
    }
    
    private func setupView() {
        // view setup
        view.backgroundColor = .clear
        titleLabel.textAlignment = .center
            
        // container view setup
        containerView.layer.shadowColor = UIColor(red: 0.298,
                                                  green: 0.372, 
                                                  blue: 0.562, 
                                                  alpha: 0.2).cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 20
        containerView.layer.shadowOffset = CGSize(width: 0,
                                                  height: -5)
        containerView.layer.masksToBounds = false
        
        // buttons setup
        doneButton.addTarget(self, action: #selector(closeBottomSheet),
                             for: .touchUpInside)
        closeBottomSheetButton.addTarget(self, action: #selector(closeBottomSheet),
                                         for: .touchUpInside)

    }
    
    // MARK: - Methods
    
    @objc
    func closeBottomSheet() {
        self.dismiss(animated: false)
    }
}

// MARK: - Extensions

extension BottomSheetFilterControllerView: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterParametersTableViewCell.reuseID,
                                                       for: indexPath) as? FilterParametersTableViewCell else { fatalError() }
        viewModel.configure(cell: cell,
                            with: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilterParametersTableViewHeader.reuseID) as? FilterParametersTableViewHeader else {fatalError()}
        viewModel.configure(header: header,
                            with: section)
        
        return header
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { fatalError() }
        let allertController = viewModel.selectRowFunctionality(cell: cell,
                                                                indexPath: indexPath)
        present(allertController, animated: true)
    }
}

extension BottomSheetFilterControllerView {
    enum Metrics {
        static let containerViewHeight: CGFloat = 345
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let titleStackViewLayotMargins = UIEdgeInsets(top: 24,
                                                             left: 44,
                                                             bottom: 0,
                                                             right: 20)
        static let titleLabelHeight: CGFloat = 60
        static let closeButtonWidth: CGFloat = 37
        static let titleLabelTextSize: CGFloat = 18
        static let titleLabelWidth: CGFloat = 215
        static let filterParametersTableViewLayotMargins = UIEdgeInsets(top: 0,
                                                                        left: 46,
                                                                        bottom: 44,
                                                                        right: 31)
        static let filterParametersTableViewHeight: CGFloat = 37
    }
    
    enum Strings {
        static let constantTitleLabelText = "Filter options"
        static let constantDoneButtonText = "Done"
    }
}
