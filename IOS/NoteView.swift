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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupHeaderText()
        setupDateField()
        setupMainText()
        mainText.becomeFirstResponder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getHeaderText() -> String{
        return self.headerText.text!
    }

    func getMainText() -> String{
        return self.mainText.text
    }
    func getDataField() -> String{
        return self.dateField.text!
    }

    func setDataField(dataField:String) {
        self.dateField.text = dataField
    }

    func setMainText(mainText:String) {
        self.mainText.text = mainText
    }

    func setHeaderText(headerText:String) {
        self.headerText.text = headerText
    }



    private func setupDateField() {
        dateField.translatesAutoresizingMaskIntoConstraints = false
        dateField.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        setupDatePicker()
        dateField.inputView = datePicker
        getDateFromPicker()
        datePicker.addTarget(self, action: #selector(getDateFromPicker), for: .valueChanged)

        self.addSubview(dateField)
        dateField.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 0).isActive = true
        dateField.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor,
            constant: 0
        ).isActive = true
        dateField.trailingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.trailingAnchor,
            constant: 0
        ).isActive = true
    }

    private func setupDatePicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
    }

    @objc private func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "Дата: dd MMMM yyyy"
        dateField.text = formatter.string(from: datePicker.date)
    }

    private func setupMainText() {
        mainText.translatesAutoresizingMaskIntoConstraints = false
        mainText.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.addSubview(mainText)
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

    private func setupHeaderText() {
        headerText.translatesAutoresizingMaskIntoConstraints = false
        headerText.placeholder = "Заметка"
        headerText.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.addSubview(headerText)
        headerText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
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
