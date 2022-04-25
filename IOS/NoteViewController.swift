import UIKit

protocol NoteDelegate: AnyObject {
    func update(noteModel: NoteModel)
}
final class NoteViewController: UIViewController, NoteDelegate {
    private let noteView = NoteView()
    weak var listDelegate: ListDelegate?
    public var completion: ((NoteModel) -> Void)?
    private var rightBarButton = UIBarButtonItem()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(noteModel: NoteModel) {
        noteView.updateModel()
        completion?(self.noteView.model)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Заметка"
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
        noteView.noteDelegate = self
        setupRightBarButton()
        noteView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noteView)
        noteView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        noteView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor
        ).isActive = true
        noteView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        noteView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func applyModel(model: NoteModel) {
        noteView.model = model
    }

    @objc func adjustForKeyboard(notification: Notification) {
        if notification.name == UIResponder.keyboardWillHideNotification {
            setupRightBarButton()
        } else {
            self.navigationItem.setRightBarButton(nil, animated: true)
        }
    }

    private func setupRightBarButton() {
        rightBarButton.title = "Готово"
        rightBarButton.target = self
        rightBarButton.action = #selector(didRightBarButtonTapped(_:))
        navigationItem.rightBarButtonItem = rightBarButton
    }

    @objc private func didRightBarButtonTapped(_ sender: Any) {
        noteView.updateModel()
        if noteView.isEmptyView() {
            showAlert()
        } else {
            listDelegate?.update(noteModel: self.noteView.model)
            completion?(self.noteView.model)
            view.endEditing(true)
        }
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
