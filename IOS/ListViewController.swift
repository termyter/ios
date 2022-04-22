//
//  ViewController.swift
//  storubord
//
//  Created by termyter on 13.04.2022.
//

import UIKit

protocol ListDelegate: AnyObject {
    func update(noteModel: NoteModel)
}

class ListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, ListDelegate{
    func update(noteModel: NoteModel) {
        let element = ElementList()
        element.model = noteModel
        listModels.append(element.model)
        table.reloadData()
    }


    private var listModels: [NoteModel] = []
    private let addButton = UIButton()
    private var table = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Заметка"
        table.register(ElementList.self, forCellReuseIdentifier: "Cell")
        table.delegate = self
        table.dataSource = self
        setupUI()
        setupAddButton()
    }

    private func setupAddButton() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(UIImage(named: "button"), for: .normal)
        addButton.addTarget(self, action: #selector(didAddButtonTap(_:)), for: .touchUpInside)
        view.addSubview(addButton)

        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
    }

    @objc private func didAddButtonTap(_ sender: Any) {
        let newNote = NoteViewController()
        newNote.listDelegate = self
        self.navigationController?.pushViewController(newNote, animated: true)
    }

    private func setupUI() {
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)

        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ElementList
        cell.model = listModels[indexPath.row]
        cell.layer.cornerRadius = 14
        cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)

        let model = listModels[indexPath.row]

        let newNote = NoteViewController()
        newNote.applyModel(model: model)
        newNote.completion = { noteModel in
            self.listModels[indexPath.row] = noteModel
            self.table.reloadData()
        }
        self.navigationController?.pushViewController(newNote, animated: true)
    }
}
