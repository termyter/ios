//
//  NoteView.swift
//  IOS
//
//  Created by termyter on 07.04.2022.
//

import Foundation
import UIKit

class NoteView: UIView {
    private var headerText = UITextField()
    private var date = UILabel()
    private var mainText = UITextView()
    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy  eeee h:mm"
        return formatter
    }()
    private var time = NSDate()
    var model: NoteModel = NoteModel(headerText: "", mainText: "", date: "") {
        didSet {
            headerText.text = model.headerText
            date.text = model.date
            mainText.text = model.mainText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupDate()
        setupHeaderText()
        setupMainText()
        mainText.becomeFirstResponder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDate() {
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        date.textColor = .gray
        date.textAlignment = .center
        date.text = formatter.string(from: time as Date)
        if model.date.isEmpty {
            model.date = formatter.string(from: time as Date)
        } else {
            date.text = model.date
        }

        addSubview(date)
        date.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        date.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor
        ).isActive = true
        date.trailingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.trailingAnchor
        ).isActive = true
    }

    private func setupMainText() {
        mainText.translatesAutoresizingMaskIntoConstraints = false
        mainText.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        addSubview(mainText)
        mainText.topAnchor.constraint(equalTo: headerText.bottomAnchor).isActive = true
        mainText.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainText.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20
        ).isActive = true
        mainText.trailingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 20
        ).isActive = true
    }

    func updateModel() {
        self.model.headerText = headerText.text ?? ""
        self.model.date = date.text ?? ""
        print(mainText.text!)
        self.model.mainText = mainText.text ?? ""
    }

    private func setupHeaderText() {
        headerText.translatesAutoresizingMaskIntoConstraints = false
        headerText.placeholder = "Введите название"
        headerText.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        addSubview(headerText)
        headerText.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 20).isActive = true
        headerText.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20
        ).isActive = true
        headerText.trailingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.trailingAnchor
        ).isActive = true
    }
}
