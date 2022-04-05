//
//  NoteModel.swift
//  IOS
//
//  Created by termyter on 05.04.2022.
//

import Foundation

struct Note {
    private var headerText: String
    private var mainText: String
    private var datePicker: String
    private var isEmpty: Bool!

    init(headerText: String, mainText: String, datePicker: String) {
        self.headerText = headerText
        self.mainText = mainText
        self.datePicker = datePicker
    }
}
