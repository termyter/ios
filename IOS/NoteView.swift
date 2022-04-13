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
    private var datePicker = UIDatePicker()
    private var dateField = UITextField()
    private var mainText = UITextView()
    private var  formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "Дата: dd MMMM yyyy"
        return formatter
   }()
    var model: NoteModel = NoteModel(headerText: "", date: "") {
         didSet {
                headerText.text = model.headerText
                dateField.text = model.date
                mainText.text = model.mainText
         }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupHeaderText()
        setupDateField()
        setupMainText()
        mainText.becomeFirstResponder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDateField() {
        dateField.translatesAutoresizingMaskIntoConstraints = false
        dateField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        setupDatePicker()
        updateDateField()
        dateField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(updateDateField), for: .valueChanged)

        if model.date.isEmpty == true {
            dateField.text = formatter.string(from: datePicker.date)
            updateDateField()
        } else {
            dateField.text = model.date
        }

        addSubview(dateField)
        dateField.topAnchor.constraint(equalTo: headerText.bottomAnchor).isActive = true
        dateField.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor
        ).isActive = true
        dateField.trailingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.trailingAnchor
        ).isActive = true
    }

    private func setupDatePicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
    }

    @objc private func updateDateField() {
        dateField.text = formatter.string(from: datePicker.date)
    }

    private func setupMainText() {
        mainText.translatesAutoresizingMaskIntoConstraints = false
        mainText.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        addSubview(mainText)
        mainText.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 0).isActive = true
        mainText.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        mainText.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor,
            constant: 0
        ).isActive = true
        mainText.trailingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.trailingAnchor,
            constant: 0
        ).isActive = true
    }

    func setupModel() {
        self.model.headerText = headerText.text ?? ""
        self.model.date = dateField.text ?? ""
        self.model.mainText = mainText.text
    }

    private func setupHeaderText() {
        headerText.translatesAutoresizingMaskIntoConstraints = false
        headerText.placeholder = "Заметка"
        headerText.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        addSubview(headerText)
        headerText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        headerText.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor,
            constant: 0
        ).isActive = true
        headerText.trailingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.trailingAnchor,
            constant: 0
        ).isActive = true
    }
}
