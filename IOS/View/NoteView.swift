//
//  NoteView.swift
//  IOS
//
//  Created by termyter on 07.04.2022.
//

import Foundation
import UIKit

class NoteView: UIView, UITextViewDelegate, UITextFieldDelegate {
    weak var noteDelegate: NoteDelegate?
    private var headerText = UITextField()
    private var scrollView = UIScrollView()
    private var date = UILabel()
    private var mainText = UITextView()
    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy eeee HH:mm"
        return formatter
    }()
    private var time = Date()
    var model: NoteModel = NoteModel.empty {
        didSet {
            headerText.text = model.headerText
            date.text = formatter.string(from: model.date)
            mainText.text = model.mainText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        setupScroll()
        setupDate()
        setupHeaderText()
        setupMainText()
        mainText.becomeFirstResponder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = convert(keyboardScreenEndFrame, from: window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            mainText.contentInset = .zero
        } else {
            mainText.contentInset = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: keyboardViewEndFrame.height - safeAreaInsets.bottom,
                right: 0
            )
        }

        mainText.scrollIndicatorInsets = mainText.contentInset

        let selectedRange = mainText.selectedRange
        mainText.scrollRangeToVisible(selectedRange)
    }

    func textViewDidChange(_ textView: UITextView) {
        noteDelegate?.update(noteModel: model)
    }

    func updateModel() {
        model = NoteModel(headerText: headerText.text ?? "", mainText: mainText.text, date: Date.now)
    }

    private func setupDate() {
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        date.textColor = .gray
        date.textAlignment = .center
        model.date = time
        scrollView.addSubview(date)
        date.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        date.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor
        ).isActive = true
        date.trailingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.trailingAnchor
        ).isActive = true
    }
    private func setupScroll() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.leadingAnchor
        ).isActive = true
        scrollView.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor
        ).isActive = true
        scrollView.bottomAnchor.constraint(
            equalTo: safeAreaLayoutGuide.bottomAnchor
        ).isActive = true
    }

    private func setupMainText() {
        mainText.translatesAutoresizingMaskIntoConstraints = false
        mainText.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        mainText.delegate = self

        scrollView.addSubview(mainText)
        mainText.topAnchor.constraint(equalTo: headerText.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainText.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainText.leadingAnchor.constraint(
            equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20
        ).isActive = true
        mainText.trailingAnchor.constraint(
            equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -20
        ).isActive = true
    }

    private func setupHeaderText() {
        headerText.translatesAutoresizingMaskIntoConstraints = false
        headerText.placeholder = "?????????????? ????????????????"
        headerText.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerText.addTarget(self, action: #selector(textViewDidChange), for: UIControl.Event.editingChanged)
        scrollView.addSubview(headerText)
        headerText.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 20).isActive = true
        headerText.leadingAnchor.constraint(
            equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20
        ).isActive = true
        headerText.trailingAnchor.constraint(
            equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -20
        ).isActive = true
    }
}
