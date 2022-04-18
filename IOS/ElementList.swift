//
//  ElementList.swift
//  IOS
//
//  Created by termyter on 13.04.2022.
//

import Foundation
import UIKit

class ElementList: UIView {
    var headerText = UILabel()
    var mainText = UILabel()
    var date = UILabel()
    public var completion: ((NoteModel) -> Void)?
    var model: NoteModel = NoteModel(headerText: "", mainText: "", date: "") {
        didSet {
            headerText.text = model.headerText
            date.text = model.date
            mainText.text = model.mainText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupHeaderText()
        setupMainText()
        setupDate()
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: topAnchor).isActive = true
        leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 16
        ).isActive = true
        trailingAnchor.constraint(
            equalTo: trailingAnchor, constant: -16
        ).isActive = true
    }

    func didTapCompletion() {
        completion?(self.model)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHeaderText() {
        headerText.translatesAutoresizingMaskIntoConstraints = false
        headerText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        addSubview(headerText)

        headerText.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        headerText.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        headerText.trailingAnchor.constraint(
            equalTo: trailingAnchor, constant: -16
        ).isActive = true
    }

    private func setupMainText() {
        mainText.translatesAutoresizingMaskIntoConstraints = false
        mainText.font = UIFont.systemFont(ofSize: 10, weight: .thin)
        addSubview(mainText)

        mainText.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 4).isActive = true
        mainText.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        mainText.trailingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16
        ).isActive = true
    }

    private func setupDate() {
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        addSubview(date)

        date.topAnchor.constraint(equalTo: mainText.safeAreaLayoutGuide.bottomAnchor, constant: 24).isActive = true
        date.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        date.trailingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.trailingAnchor
        ).isActive = true
        date.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}
