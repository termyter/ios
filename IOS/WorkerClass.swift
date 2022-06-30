//
//  WorkerClass.swift
//  IOS
//
//  Created by termyter on 27.05.2022.
//

import Foundation

class Worker {
    let session: URLSession
    weak var workerDelegate: WorkerDelegate?

    func fetch() {
        var listModels: [NoteModel] = []
        if let url = createURLComponents() {
            url.asyncDownload { data, _, error in
                guard let data = data else {
                    print("URLSession dataTask error:", error ?? "nil")
                    return
                }

                do {
                    let jsonObject = try JSONDecoder().decode(BackEndNoteModels.self, from: data)
                    _ = String(data: data, encoding: .utf8)
                    for object in jsonObject {
                        let timeInterval = TimeInterval(object.date)

                        let newDate = Date(timeIntervalSince1970: timeInterval)

                        listModels.append(
                            NoteModel(
                                headerText: object.header,
                                mainText: object.text,
                                date: newDate
                            )
                        )
                    }
                    DispatchQueue.main.async {
                        self.workerDelegate?.getListModels(noteModels: listModels)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
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

extension URL {
    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared
            .dataTask(with: self, completionHandler: completion)
            .resume()
    }
}
