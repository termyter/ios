import UIKit

final class NoteViewController: UIViewController {
    let noteView = NoteView()
    weak var listViewControlleDelegate: ListViewControlleDelegate?
    private var rightBarButton = UIBarButtonItem()
    public var completion: ((NoteModel) -> Void)?

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

    @objc func adjustForKeyboard(notification: Notification) {
        if notification.name == UIResponder.keyboardWillHideNotification {
            setupRightBarButton()
//            updateListView()
        } else {
            self.navigationItem.setRightBarButton(nil, animated: true)
            //updateListView()
        }
    }
    private func setupRightBarButton() {
        rightBarButton.title = "Готово"
        rightBarButton.target = self
        rightBarButton.action = #selector(didRightBarButtonTapped(_:))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    func updateListView() {
        noteView.updateModel()
        listViewControlleDelegate?.update(noteModel: self.noteView.model)
    }
    @objc private func didRightBarButtonTapped(_ sender: Any) {
        noteView.updateModel()
        if noteView.isEmptyView() {
            showAlert()
        } else {
            listViewControlleDelegate?.update(noteModel: self.noteView.model)
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

        func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
            model.mainText = textView.text //the textView parameter is the textView where text was changed
            print(model.mainText)
        }

    
    func isEmptyView() -> Bool {
        self.model.isEmpty
    }
}
