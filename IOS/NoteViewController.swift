import UIKit

final class NoteViewController: UIViewController {
    private var rightBarButton = UIBarButtonItem()
    private var headerText = UITextField()
    private var datePicker = UIDatePicker()
    private var dateField = UITextField()
    private var mainText = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Заметка"
        setupRightBarButton()
        setupHeaderText()
        setupDateField()
        setupMainText()
        mainText.becomeFirstResponder()
    }

    private func setupDateField() {
        dateField.translatesAutoresizingMaskIntoConstraints = false
        dateField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        setupDatePicker()
        dateField.inputView = datePicker
        getDateFromPicker()
        datePicker.addTarget(self, action: #selector(getDateFromPicker), for: .valueChanged)

        view.addSubview(dateField)
        dateField.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 0).isActive = true
        dateField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 0
        ).isActive = true
        dateField.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
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
        formatter.dateFormat = "Дата: " + "dd MMMM yyyy"
        dateField.text = formatter.string(from: datePicker.date)
    }

    private func setupMainText() {
        mainText.translatesAutoresizingMaskIntoConstraints = false
        mainText.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.addSubview(mainText)
        mainText.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 0).isActive = true
        mainText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        mainText.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 0
        ).isActive = true
        mainText.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: 0
        ).isActive = true
    }

    private func setupHeaderText() {
        headerText.translatesAutoresizingMaskIntoConstraints = false
        headerText.placeholder = "Заметка"
        headerText.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.addSubview(headerText)
        headerText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        headerText.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 0
        ).isActive = true
        headerText.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: 0
        ).isActive = true
    }

    private func setupRightBarButton() {
        rightBarButton.title = "Готово"
        rightBarButton.target = self
        rightBarButton.action = #selector(didRightBarButtonTapped(_:))
        navigationItem.rightBarButtonItem = rightBarButton
    }

    @objc private func didRightBarButtonTapped(_ sender: Any) {
        view.endEditing(true)
    }
}
