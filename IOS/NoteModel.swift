//
//  NoteModel.swift
//  IOS
//
//  Created by termyter on 07.04.2022.
//

import Foundation

struct NoteModel: Codable, Hashable {
    var headerText: String
    var mainText: String?
    var date: String
    var isSelected: Bool = false
    var isEmpty: Bool {
        return self.headerText.isEmpty
    }
    static let empty = NoteModel(headerText: "", mainText: "", date: "", isSelected: false)
}
