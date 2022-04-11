//
//  NoteModel.swift
//  IOS
//
//  Created by termyter on 07.04.2022.
//

import Foundation

struct NoteModel {
    var headerText: String
    var mainText: String?
    var datePicker: String
    var isEmpty: Bool {
        return self.headerText.isEmpty
    }
}
