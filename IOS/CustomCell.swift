//
//  CustomCell.swift
//  IOS
//
//  Created by termyter on 25.04.2022.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    private var cellView = ElementList()
    private var selectedButton = UIButton(type: .custom)
    var model: NoteModel? {
        get {
            cellView.model
        }
        set {
            cellView.model = newValue!
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        setupView()
        layer.cornerRadius = 14
        layer.shadowRadius = 14
    }

    func changeModeEnding(_ isEnding: Bool) {
        cellView.isEditing = isEnding
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isHidden = false
        isSelected = false
        isHighlighted = false

        cellView.model = NoteModel(headerText: "", mainText: "", date: "", isSelected: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cellView)

        cellView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        cellView.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        cellView.trailingAnchor.constraint(
            equalTo: trailingAnchor, constant: -16
        ).isActive = true
        cellView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -4).isActive = true
    }
}
