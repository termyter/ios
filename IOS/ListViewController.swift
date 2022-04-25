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

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ListDelegate {
    private var listModels: [NoteModel] = []
    private let addButton = UIButton()
    private var table = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        table.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        navigationItem.title = "Заметка"
        table.register(CustomCell.self, forCellReuseIdentifier: "Cell")
        table.delegate = self
        table.dataSource = self
        setupUI()
        setupAddButton()
    }

    func update(noteModel: NoteModel) {
        let element = ElementList()
        element.model = noteModel
        listModels.append(element.model)
        table.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomCell else {
            fatalError("не CustomCell")
        }
        cell.cellView.model = listModels[indexPath.row]
        cell.layer.cornerRadius = 14
        cell.layer.shadowRadius = 14

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let model = listModels[indexPath.row]

        let newNote = NoteViewController()
        newNote.applyModel(model: model)
        newNote.completion = { noteModel in
            self.listModels[indexPath.row] = noteModel
            self.table.reloadData()
        }
        self.navigationController?.pushViewController(newNote, animated: true)
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
        table.separatorStyle = .none
        view.addSubview(table)

        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
