import UIKit

final class NoteViewController: UIViewController {
    private var rightBarButton = UIBarButtonItem()
    private var headerText = UITextField()
    private var datePicker = UIDatePicker()
    private var mainText = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Заметка"
        setupRightBarButton()
        setupHeaderText()
        setupDatePicker()
        setupMainText()
        mainText.becomeFirstResponder()
    }
    private func setupDatePicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date

        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 0).isActive = true
        datePicker.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 0
            ).isActive = true
    }

    private func setupMainText() {
        mainText.translatesAutoresizingMaskIntoConstraints = false
        mainText.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.addSubview(mainText)
        mainText.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 0).isActive = true
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
