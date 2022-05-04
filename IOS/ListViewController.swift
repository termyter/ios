//
//  ListViewController.swift
//  IOS
//
//  Created by termyter on 13.04.2022.
//

import UIKit

protocol ListDelegate: AnyObject {
    func createCell(noteModel: NoteModel)
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ListDelegate {
    private var listModels: [NoteModel] {
        get {
            if let date = UserDefaults.standard.value(forKey: "listModels") as? Data {
                let list = try? PropertyListDecoder().decode(Array<NoteModel>.self, from: date)
                return list ?? []
            } else {
                return []
            }
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "listModels")
            UserDefaults.standard.synchronize()
        }
    }
    private var addButton = UIButton()
    private var table = UITableView()
    private var rightBarButton = UIBarButtonItem()
    private var constrintAddButton: NSLayoutConstraint! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        table.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        navigationItem.title = "Заметка"
        setupRightBarButton()
        table.register(CustomCell.self, forCellReuseIdentifier: "Cell")
        table.delegate = self
        table.dataSource = self

        setupUI()
        setupAddButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = false
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 80).isActive = true
        DispatchQueue.main.asyncAfter(deadline: .now()) {
                UIView.animate(
                withDuration: 2.5,
                delay: 0,
                usingSpringWithDamping: 0.1,
                initialSpringVelocity: 1,
                options: [],
                animations: { [self] in
                    constrintAddButton.constant = -69
                    self.view.layoutIfNeeded()
                }
            )
        }
    }

    func createCell(noteModel: NoteModel) {
        listModels.append(noteModel)
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
        newNote.completion = { [weak self] noteModel in
            self?.listModels[indexPath.row] = noteModel
            self?.table.reloadData()
        }
        self.navigationController?.pushViewController(newNote, animated: true)
    }

    private func setupRightBarButton() {
        rightBarButton.title = "Выбрать"
        rightBarButton.target = self
        //rightBarButton.action = #selector(addButtonAnim(_:))
        navigationItem.rightBarButtonItem = rightBarButton
    }


    private func setupAddButton() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(UIImage(named: "button"), for: .normal)
        addButton.addTarget(self, action: #selector(didAddButtonTap(_:)), for: .touchUpInside)
        view.addSubview(addButton)
        constrintAddButton = NSLayoutConstraint(item: addButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 69)
        self.view.addConstraint(constrintAddButton)
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19).isActive = true
        //addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 80).isActive = true
    }

    @objc private func didAddButtonTap(_ sender: Any) {
        addButtonAnim()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        let newNote = NoteViewController()
        newNote.listDelegate = self
        self.navigationController?.pushViewController(newNote, animated: true)
        }
    }

    @objc private func addKeyFrames() {
        UIView.addKeyframe(
            withRelativeStartTime: 0,
            relativeDuration: 0.5
        ) {
            self.addButton.center.y -= 50
        }
        UIView.addKeyframe(
            withRelativeStartTime: 0.5,
            relativeDuration: 0.5
        ) {
            self.addButton.center.y += 200
            self.constrintAddButton.constant = 69
        }
    }

    @objc private func addButtonAnim() {

//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            //self.constrintAddButton.constant = 69
//        }
        UIView.animateKeyframes(
            withDuration: 1.5,
            delay: 0,
            options: [.repeat],
            animations: {
                self.addKeyFrames()
            },
            completion: nil
        )
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
