import UIKit

final class NoteViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var headerText: UITextField!
    @IBOutlet weak var mainText: UITextView!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton.target = self
        mainText.becomeFirstResponder()
        rightBarButton.action = #selector(didRightBarButtonTapped(_:))
    }

    @objc private func didRightBarButtonTapped(_ sender: Any) {
            view.endEditing(true)
        }
}
