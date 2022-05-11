//
//  NoteView.swift
//  IOS
//
//  Created by termyter on 07.04.2022.
//

import Foundation
import UIKit

class ElementList: UIView {
    var listViewController = ListViewController()
    private var headerText = UILabel()
    private var mainText = UILabel()
    private var date = UILabel()
    var model: NoteModel = NoteModel(headerText: "", mainText: "", date: "", isSelected: false) {
        didSet {
            headerText.text = model.headerText
            date.text = model.date
            mainText.text = model.mainText
            if model.isSelected {
                selectedButton.setImage(UIImage(named: "selected"), for: .normal)
            } else {
                selectedButton.setImage(UIImage(named: "unselected"), for: .normal)
            }
        }
    }
    private var selectedButton = UIButton(type: .custom)
    var buttonLeadingAnchor: NSLayoutConstraint?
    var buttonIsEnabledLeadingAnchor: NSLayoutConstraint?
    var headerLeadingAnchor: NSLayoutConstraint?
    var headderIsEnabledLeadingAnchor: NSLayoutConstraint?
    var mainLeadingAnchor: NSLayoutConstraint?
    var mainIsEnabledLeadingAnchor: NSLayoutConstraint?
    var dateLeadingAnchor: NSLayoutConstraint?
    var dateIsEnabledLeadingAnchor: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupHeaderText()
        setupMainText()
        setupDate()
        setupSelectedButton()
        layer.cornerRadius = 14
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func isEndingCell(isEnding: Bool) {
        if isEnding {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                UIView.animate(
                    withDuration: 1,
                    delay: 0,
                    options: [],
                    animations: { [self] in
                        self.selectedButton.isHidden = false
                        self.headerText.frame.origin.x = 60
                        self.headderIsEnabledLeadingAnchor = self.headerText.leadingAnchor.constraint(
                            equalTo: self.leadingAnchor,
                            constant: 60
                        )
                        self.headerLeadingAnchor?.isActive = false
                        self.headderIsEnabledLeadingAnchor?.isActive = true

                        self.mainText.frame.origin.x = 60
                        self.mainIsEnabledLeadingAnchor = self.mainText.leadingAnchor.constraint(
                            equalTo: self.leadingAnchor,
                            constant: 60
                        )
                        self.mainLeadingAnchor?.isActive = false
                        self.mainIsEnabledLeadingAnchor?.isActive = true

                        self.dateIsEnabledLeadingAnchor = self.date.leadingAnchor.constraint(
                            equalTo: self.leadingAnchor,
                            constant: 60
                        )
                        self.date.frame.origin.x = 60
                        self.dateLeadingAnchor?.isActive = false
                        self.dateIsEnabledLeadingAnchor?.isActive = true

                        self.buttonIsEnabledLeadingAnchor = self.selectedButton.leadingAnchor.constraint(
                            equalTo: self.leadingAnchor,
                            constant: 24
                        )
                        self.selectedButton.frame.origin.x = 24
                        self.buttonLeadingAnchor?.isActive = false
                        self.buttonIsEnabledLeadingAnchor?.isActive = true
                    }
                )
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                UIView.animate(
                    withDuration: 1,
                    delay: 0,
                    options: [],
                    animations: { [self] in
                        self.headerText.frame.origin.x = 16
                        self.mainText.frame.origin.x = 16
                        self.date.frame.origin.x = 16
                        self.selectedButton.frame.origin.x = -50
                    }
                )
                self.headerLeadingAnchor?.isActive = true
                self.headderIsEnabledLeadingAnchor?.isActive = false

                self.mainLeadingAnchor?.isActive = true
                self.mainIsEnabledLeadingAnchor?.isActive = false

                self.dateLeadingAnchor?.isActive = true
                self.dateIsEnabledLeadingAnchor?.isActive = false

                self.buttonLeadingAnchor?.isActive = true
                self.buttonIsEnabledLeadingAnchor?.isActive = false
            }
        }
    }

    @objc private func didAddButtonTap(_ sender: Any) {
        selectedButton.setImage(UIImage(named: "selected"), for: .normal)
    }

    private func setupSelectedButton() {
        selectedButton.translatesAutoresizingMaskIntoConstraints = false
        selectedButton.setImage(UIImage(named: "unselected"), for: .normal)
        selectedButton.addTarget(self, action: #selector(didAddButtonTap(_:)), for: .touchUpInside)

        addSubview(selectedButton)

        buttonLeadingAnchor = selectedButton.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: -50
        )
        self.buttonLeadingAnchor?.isActive = true
        self.selectedButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 37).isActive = true
    }

    private func setupHeaderText() {
        headerText.translatesAutoresizingMaskIntoConstraints = false
        headerText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        addSubview(headerText)

        headerText.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        headerLeadingAnchor = headerText.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 16
        )
        headerLeadingAnchor?.isActive = true
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
        mainLeadingAnchor = mainText.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 16
        )
        mainLeadingAnchor?.isActive = true
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

        dateLeadingAnchor = date.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 16
        )
        dateLeadingAnchor?.isActive = true

        date.trailingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.trailingAnchor
        ).isActive = true
        date.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}
