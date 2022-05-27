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

protocol WorkerDelegate: AnyObject {
    func getListModels(noteModels: [NoteModel])
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ListDelegate, WorkerDelegate {
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
    private var constraintAddButton: NSLayoutConstraint?
    private var isEdit = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let worker = Worker()
        worker.workerDelegate = self
        worker.fetch()
        table.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        navigationItem.title = "Заметка"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
                withDuration: 1,
                delay: 0,
                usingSpringWithDamping: 0.1,
                initialSpringVelocity: 0.8,
                options: [],
                animations: { [weak self] in
                    self?.constraintAddButton?.constant = -69
                    self?.view.layoutIfNeeded()
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
        cell.selectionStyle = .none

        cell.changeModeEnding(isEdit)

        cell.model = listModels[indexPath.row]
        cell.layer.cornerRadius = 14
        cell.layer.shadowRadius = 14

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = listModels[indexPath.row]

        if isEdit {
            listModels[indexPath.row].isSelected = !model.isSelected
            table.reloadData()
        } else {
            let newNote = NoteViewController()
            newNote.applyModel(model: model)
            newNote.completion = { [weak self] noteModel in
                self?.listModels[indexPath.row] = noteModel
                self?.table.reloadData()
            }
            self.navigationController?.pushViewController(newNote, animated: true)
        }
    }

    func getListModels(noteModels: [NoteModel]) {
        listModels += noteModels
        listModels = listModels.uniqueElements()
        table.reloadData()
    }

    private func deSelect() {
        for (index, var object) in listModels.enumerated() where object.isSelected {
            object.isSelected = !object.isSelected
            listModels[index] = object
        }
        table.reloadData()
    }

    private func showAlert() {
        let alert = UIAlertController(
            title: "Внимание",
            message: "Вы не выбрали ни одной заметки",
            preferredStyle: .alert
        )
        let buttonAlert = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(buttonAlert)

        present(alert, animated: true, completion: nil)
    }

    private func deleteSelectedNote() {
        let deleteList = listModels.filter { !$0.isSelected }
        if deleteList.count == listModels.count {
            showAlert()
        } else {
            listModels = deleteList
        }
        table.reloadData()
    }

    private func setupRightBarButton() {
        rightBarButton.title = "Выбрать"
        rightBarButton.target = self
        rightBarButton.action = #selector(didRightBarButtonTap(_:))
        navigationItem.rightBarButtonItem = rightBarButton
    }

    @objc private func didRightBarButtonTap(_ sender: Any) {
        table.reloadData()
        if isEdit {
            UIView.transition(
                with: addButton,
                duration: 1,
                options: [.transitionFlipFromLeft],
                animations: {
                    self.addButton.setImage(UIImage(named: "addButton"), for: .normal)
                }
            )
            deSelect()
            rightBarButton.title = "Выбрать"
            isEdit = false
        } else {
            rightBarButton.title = "Готово"
            UIView.transition(
                with: addButton,
                duration: 1,
                options: [.transitionFlipFromLeft],
                animations: {
                    self.addButton.setImage(UIImage(named: "deleteButton"), for: .normal)
                }
            )
            isEdit = true
        }
    }

    private func setupAddButton() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(UIImage(named: "addButton"), for: .normal)
        addButton.addTarget(self, action: #selector(didAddButtonTap(_:)), for: .touchUpInside)
        view.addSubview(addButton)
        constraintAddButton = NSLayoutConstraint(
            item: addButton,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .bottom,
            multiplier: 1,
            constant: 69
        )
        guard let constraintAddButton = constraintAddButton else {
            return
        }
        self.view.addConstraint(constraintAddButton)

        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19).isActive = true
    }

    @objc private func didAddButtonTap(_ sender: Any) {
        if isEdit {
            deleteSelectedNote()
        } else {
            addButtonAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let newNote = NoteViewController()
                newNote.listDelegate = self
                self.navigationController?.pushViewController(newNote, animated: true)
            }
        }
    }

    @objc private func addKeyFrames() {
        UIView.addKeyframe(
            withRelativeStartTime: 0,
            relativeDuration: 0.5
        ) {
            self.constraintAddButton?.constant -= 60
            self.view.layoutIfNeeded()
        }
        UIView.addKeyframe(
            withRelativeStartTime: 0.5,
            relativeDuration: 0.5
        ) {
            self.constraintAddButton?.constant = 69
            self.view.layoutIfNeeded()
        }
    }

    @objc private func addButtonAnimation() {
        UIView.animateKeyframes(
            withDuration: 1.5,
            delay: 0,
            options: [.repeat],
            animations: { [weak self] in
                self?.addKeyFrames()
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

class Worker {
    let session: URLSession
    weak var workerDelegate: WorkerDelegate?

    func fetch() {
        var listModels: [NoteModel] = []
        session.dataTask(with: createURLComponents()!) {data, response, _ in
            guard let data = data,
                  let response = try? JSONDecoder().decode(BackEndNoteModels.self, from: data)
            else { return }
            _ = String(data: data, encoding: .utf8)
            for object in response {
                let timeInterval = TimeInterval(object.date)

                let myNSDate = Date(timeIntervalSince1970: timeInterval)

                let dateFormatter = DateFormatter()

                dateFormatter.string(from: myNSDate)
                dateFormatter.dateFormat = "YY.MM.dd"

                listModels.append(NoteModel(
                    headerText: object.header,
                    mainText: object.text,
                    date: dateFormatter.string(from: myNSDate)
                    )
                )
                print(dateFormatter.string(from: myNSDate))
            }
            DispatchQueue.main.async {
                self.workerDelegate?.getListModels(noteModels: listModels)
            }
        }.resume()
    }

    init(
        session: URLSession = URLSession(configuration: .default)
    ) {
        self.session = session
    }

    private func createURLComponents() -> URL? {
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "firebasestorage.googleapis.com"
        urlComponents.path = "/v0/b/ios-test-ce687.appspot.com/o/Empty.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "alt", value: "media"),
            URLQueryItem(name: "token", value: "d07f7d4a-141e-4ac5-a2d2-cc936d4e6f18")
        ]
        return urlComponents.url!
    }

    private func createURLRequest() -> URLRequest {
        var request = URLRequest(url: createURLComponents()!)
        request.httpMethod = "GET"
        return request
    }
}

struct BackEndNoteModel: Decodable {
    let header, text: String
    let date: Int
}

typealias BackEndNoteModels = [BackEndNoteModel]

extension Array where Element: Hashable {
  func uniqueElements() -> [Element] {
    var seen = Set<Element>()

    return self.compactMap { element in
      guard !seen.contains(element)
        else { return nil }

      seen.insert(element)
      return element
    }
  }
}
