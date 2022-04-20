//
//  ListViewController.swift
//  IOS
//
//  Created by termyter on 13.04.2022.
//
import UIKit

protocol ListDelegate: AnyObject {
    func update(noteModel: NoteModel)
}

class ListViewController: UIViewController, ListDelegate {
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()
    private let rightBarButton = UIBarButtonItem()
    private let addButton = UIButton()
   // private let element = ElementList()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        navigationItem.title = "Заметки"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setupScrollView()
        setupStackView()
        setupAddButton()
    }

    private func setupAddButton() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(UIImage(named: "button"), for: .normal)
        addButton.addTarget(self, action: #selector(didAddButtonTap(_:)), for: .touchUpInside)
        view.addSubview(addButton)

        addButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -19).isActive = true
        addButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30).isActive = true
    }

    @objc private func didAddButtonTap(_ sender: Any) {
        let newNote = NoteViewController()
        newNote.listDelegate = self
        self.navigationController?.pushViewController(newNote, animated: true)
    }

    @objc func handleOneTap(_ sender: UITapGestureRecognizer) {
        if let item = sender.view as? ElementList {
            let newNote = NoteViewController(completion: { [weak self] noteModel in
                item.model = noteModel
            })
            newNote.applyModel(model: item.model)
            self.navigationController?.pushViewController(newNote, animated: true)
        } else {
            print("не ElementList") }
    }
    func update(noteModel: NoteModel) {
        let element = ElementList()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleOneTap))
        element.addGestureRecognizer(tap)
        element.model = noteModel
        stackView.addArrangedSubview(element)
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
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        scrollView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 16)
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
