//
//  ListViewController.swift
//  IOS
//
//  Created by termyter on 13.04.2022.
//
import UIKit

class ListViewController: UIViewController {
    private let elementList = ElementList()
    private var elementList1 = ElementList()
    private let elementList3 = ElementList()
    private let elementList4 = ElementList()
    private let elementList2 = NoteViewController()
    private var stackView = UIStackView()
    private var scrollView = UIScrollView()
    private var rightBarButton = UIBarButtonItem()

    var listView = Array(arrayLiteral: UIView())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Заметки"
        setupRightBarButton()
        elementList3.backgroundColor = .yellow
        setupScrollView()
        listView = [elementList, elementList1, elementList3, elementList4]
        setupStackView()
    }

    private func setupRightBarButton() {
        rightBarButton.title = "Готово"
        rightBarButton.target = self
        rightBarButton.action = #selector(didRightBarButtonTapped(_:))
        navigationItem.rightBarButtonItem = rightBarButton
    }

    @objc private func didRightBarButtonTapped(_ sender: Any) {
        self.navigationController?.pushViewController(elementList2, animated: true)
    }

    //    func stackView(stackView: UIStackView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //
    //        let cell = stackView.cell as NoteViewController
    //    }

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

        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true



    }
}
