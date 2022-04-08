//
//  NoteModel.swift
//  IOS
//
//  Created by termyter on 07.04.2022.
//

import Foundation

struct NoteModel {
    private var headerText: String
    private var mainText: String?
    private var datePicker: String
    private var isEmpty: Bool {
        return self.headerText.isEmpty
    }

    init() {
        self.headerText = ""
        self.mainText = nil
        self.datePicker = ""
    }

    mutating func setHeaderText(headerText: String) {
        self.headerText = headerText
    }

    mutating func setMainText(mainText: String?) {
        self.mainText = mainText
    }

    mutating func setDatePicker(datePicker: String) {
        self.datePicker = datePicker
    }
}
