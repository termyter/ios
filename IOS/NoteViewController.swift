import UIKit

struct Note {
    private var headerText: String
    private var mainText: String?
    private var datePicker: String
    private var isEmpty: Bool {
        if self.headerText == ""{
            return true
        }
        return false
    }

    init() {
        self.headerText = ""
        self.mainText = nil
        self.datePicker = ""
    }

    mutating func setHeaderText(headerText: String) {
        self.headerText = headerText
    }

    mutating func setMainText(mainText: String) {
        self.mainText = mainText
    }

    mutating func setDatePicker(datePicker: String) {
        self.datePicker = datePicker
    }
}

final class NoteViewController: UIViewController {
    private var rightBarButton = UIBarButtonItem()
    private var headerText = UITextField()
    private var datePicker = UIDatePicker()
    private var dateField = UITextField()
    private var mainText = UITextView()

    lazy var note = Note()

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
    private func setupAlert() {
        let alert = UIAlertController(title: "Внимание", message: "Не все поля заполнены", preferredStyle: .alert)
        let buttonAlert = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(buttonAlert)

        present(alert, animated: true, completion: nil)
    }

    @objc private func didRightBarButtonTapped(_ sender: Any) {
        view.endEditing(true)
        setupModel()
        if note.getIsEmpty() {
            setupAlert()
        }
    }
    func setupModel() {
        note.setHeaderText(headerText: headerText.text!)
        note.setMainText(mainText: mainText.text)
        note.setDatePicker(datePicker: dateField.text!)
    }
}
extension Note {
    func getIsEmpty() -> Bool {
        return self.isEmpty
    }
}
