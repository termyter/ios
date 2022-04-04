import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var headerText: UITextField!
    @IBOutlet weak var mainText: UITextView!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    private var isEditingMode = true

    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton.target = self
        mainText.becomeFirstResponder()
        rightBarButton.action = #selector(didRightBarButtonTapped(_:))
    }

    @objc private func didRightBarButtonTapped(_ sender: Any) {
        isEditingMode = !isEditingMode
        if isEditingMode {
            mainText.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
    }
}
