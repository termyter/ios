//
//  ListViewController.swift
//  IOS
//
//  Created by termyter on 13.04.2022.
//
import UIKit

class ListViewController: UIViewController {
    //private let elementList = ElementList()
    private var stackView = UIStackView()
    private var scrollView = UIScrollView()
    private var rightBarButton = UIBarButtonItem()
    private let addButton = UIButton()
    //let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    var listView = Array(arrayLiteral: UIView())
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 229, green: 229, blue: 229, alpha: 1)
        navigationItem.title = "Заметки"
        setupRightBarButton()
        setupAddButton()
        setupScrollView()
        listView = [UIView()]
        setupStackView()
    }
    
    private func setupRightBarButton() {
        rightBarButton.title = "Готово"
        rightBarButton.target = self
        rightBarButton.action = #selector(didRightBarButtonTapped(_:))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    private func setupAddButton() {
        addButton.layer.cornerRadius = 25
        addButton.clipsToBounds = true
        addButton.contentVerticalAlignment = .bottom
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 36, weight: .regular)
        addButton.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        //addButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 734).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 321).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 19).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 69).isActive = true
    }

    @objc private func didRightBarButtonTapped(_ sender: Any) {
        let newNote = NoteViewController()
        let element = ElementList()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        element.addGestureRecognizer(tap)
        newNote.completion = {[weak self] noteModel in
            element.model = noteModel
            self?.listView.append(element)
            self?.setupStackView()
        }
        self.navigationController?.pushViewController(newNote, animated: true)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        elementList.didTapCompletion()

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
