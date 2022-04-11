import UIKit

final class NoteViewController: UIViewController {
    private let noteView = NoteView()
    private var noteModel = NoteModel(headerText: "", datePicker: "" )
    private var rightBarButton = UIBarButtonItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Заметка"
        setupRightBarButton()
        noteView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(noteView)
        noteView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        noteView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 0
        ).isActive = true
        noteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        noteView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

    private func setupRightBarButton() {
        rightBarButton.title = "Готово"
        rightBarButton.target = self
        rightBarButton.action = #selector(didRightBarButtonTapped(_:))
        navigationItem.rightBarButtonItem = rightBarButton
    }

    @objc private func didRightBarButtonTapped(_ sender: Any) {
        noteView.setupModel()
        if noteView.isEmptyView() {
            showAlert()
        } else {
            view.endEditing(true)
            setupModel()
        }
    }

    func setupModel() {
        noteModel.headerText = noteView.model.headerText
        noteModel.datePicker = noteView.model.datePicker
        noteModel.mainText = noteView.model.mainText
    }

    private func showAlert() {
        let alert = UIAlertController(title: "Внимание", message: "Не все поля заполнены", preferredStyle: .alert)
        let buttonAlert = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(buttonAlert)

        present(alert, animated: true, completion: nil)
    }
}

extension NoteView {
    func isEmptyView() -> Bool {
        self.model.isEmpty
    }
}
