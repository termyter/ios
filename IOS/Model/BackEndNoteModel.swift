//
//  BackEndNoteModel.swift
//  IOS
//
//  Created by termyter on 27.05.2022.
//

import Foundation

struct BackEndNoteModel: Decodable {
    let header, text: String
    let date: Int
}

typealias BackEndNoteModels = [BackEndNoteModel]
