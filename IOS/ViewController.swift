import UIKit

class ViewController: UIViewController {
    private var rightBarButton = UIButton()
    private var titleTextView = UITextView()
    private var descTextView = UITextView()

    private var isEditingMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTitleTextView()
        setupTextView()
        setupRightBarButton()
        }

    private func setupRightBarButton() {
        rightBarButton.configuration = .plain()
        rightBarButton.configuration?.title = "Готово"
        rightBarButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupTextView() {
        descTextView.isUserInteractionEnabled = true
        descTextView.becomeFirstResponder()
        descTextView.translatesAutoresizingMaskIntoConstraints = false
        descTextView.isUserInteractionEnabled = isEditingMode

        descTextView.text = "Текст заметки"
        descTextView.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        view.addSubview(descTextView)
        NSLayoutConstraint(
                           item: descTextView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 0
                           ).isActive = true
        NSLayoutConstraint(
                            item: descTextView,
                            attribute: .trailingMargin,
                            relatedBy: .equal,
                            toItem: view,
                            attribute: .trailingMargin,
                            multiplier: 1,
                            constant: 0
                            ).isActive = true
        NSLayoutConstraint(
                            item: descTextView,
                            attribute: .top,
                            relatedBy: .equal,
                            toItem: view,
                            attribute: .topMargin,
                            multiplier: 1,
                            constant: 60
                            ).isActive = true
        NSLayoutConstraint(
                            item: descTextView,
                            attribute: .height,
                            relatedBy: .equal,
                            toItem: descTextView,
                            attribute: .width,
                            multiplier: 1,
                            constant: 0
                            ).isActive = true
    }

    private func setupTitleTextView() {
        titleTextView.isUserInteractionEnabled = true
        titleTextView.becomeFirstResponder()
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        titleTextView.isUserInteractionEnabled = isEditingMode

        titleTextView.text = "Заголовок"
        titleTextView.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        view.addSubview(titleTextView)
        NSLayoutConstraint(
                            item: titleTextView,
                            attribute: .leading,
                            relatedBy: .equal,
                            toItem: view,
                            attribute: .leading,
                            multiplier: 1,
                            constant: 0
                            ).isActive = true
        NSLayoutConstraint(
                            item: titleTextView,
                            attribute: .trailingMargin,
                            relatedBy: .equal,
                            toItem: view,
                            attribute: .trailingMargin,
                            multiplier: 1,
                            constant: 0
                            ).isActive = true
        NSLayoutConstraint(
                            item: titleTextView,
                            attribute: .top,
                            relatedBy: .equal,
                            toItem: view,
                            attribute: .topMargin,
                            multiplier: 1,
                            constant: 10
                            ).isActive = true
        NSLayoutConstraint(
                            item: titleTextView,
                            attribute: .height,
                            relatedBy: .equal,
                            toItem: titleTextView,
                            attribute: .width,
                            multiplier: 1,
                            constant: 0
                            ).isActive = true
    }
}
