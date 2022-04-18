//
//  ListViewController.swift
//  IOS
//
//  Created by termyter on 13.04.2022.
//
import UIKit

class ListViewController: UIViewController {
    private var stackView = UIStackView()
    private var scrollView = UIScrollView()
    private var rightBarButton = UIBarButtonItem()
    private let addButton = UIButton()
    var listView = [UIView()]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        navigationItem.title = "Заметки"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setupScrollView()
        setupAddButton()
        listView = [UIView()]
        setupStackView()
    }

    private func setupAddButton() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.layer.cornerRadius = 25
        addButton.clipsToBounds = true
        addButton.contentVerticalAlignment = .bottom
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 36, weight: .regular)
        addButton.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        addButton.addTarget(self, action: #selector(didRightBarButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 600).isActive = true
        addButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 301).isActive = true
        addButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -19).isActive = true
        addButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30).isActive = true
    }

    @objc private func didRightBarButtonTapped(_ sender: Any) {
        let newNote = NoteViewController()
        let element = ElementList()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        element.addGestureRecognizer(tap)
        newNote.completion = {[weak self] noteModel in
            element.model = noteModel
            self?.listView.append(element)
            self?.setupStackView()
        }
        self.navigationController?.pushViewController(newNote, animated: true)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let item = sender.view as? ElementList {
            print(item.model)
            let newNote = NoteViewController()
            newNote.noteView.model = item.model
            newNote.completion = { [weak self] noteModel in
                item.model = noteModel
                self?.setupStackView()
            }
            self.navigationController?.pushViewController(newNote, animated: true)
        } else {
            print("не ElementList") }
    }

    private func setupScrollView() {
        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor
        ).isActive = true
        scrollView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor
        ).isActive = true
        scrollView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor
        ).isActive = true
    }

    private func setupStackView() {
        stackView = UIStackView(arrangedSubviews: listView)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        scrollView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}
extension UIView {
    func addTapGesture(tapNumber: Int, target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}
