//
//  MainViewCell.swift
//  UniversityInformation
//
//  Created by ILKER on 16.06.2023.
//

import UIKit
class MainViewCell: UITableViewCell {
    // MARK: - Properties
    var viewModel: MainViewCellViewModel? {
        didSet{ configure() }
    }
    private let universityImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "university")
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return imageView
    }()
    private let universityNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Fırat Üniversitesi"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    private var stackView: UIStackView!
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension MainViewCell {
    private func setup() {
        stackView = UIStackView(arrangedSubviews: [universityImageView, universityNameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    private func configure() {
        guard let viewModel = self.viewModel else { return }
        self.universityNameLabel.text = viewModel.name
    }
}
