//
//  ListViewController.swift
//  IOS
//
//  Created by termyter on 13.04.2022.
//
import UIKit

class ListViewController: UIViewController {
    private let elementList = ElementList()
    private let elementList1 = ElementList()
    private let elementList3 = ElementList()
    private let elementList2 = NoteView()
    private var stackView = UIStackView()

    var listView = Array(arrayLiteral: UIView())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Заметки"
        elementList3.backgroundColor = .yellow
        listView = [elementList, elementList1, elementList1, elementList3]
        setupStackView()
    }

    private func setupStackView() {
        stackView = UIStackView(arrangedSubviews: listView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4

        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor
        ).isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor
        ).isActive = true

    }
}
