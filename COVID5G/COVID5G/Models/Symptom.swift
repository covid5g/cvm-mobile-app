//
//  Symptom.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import Foundation

struct Symptom: Codable, Hashable {
    var displayName: String
    var value: Bool
    var points: Int
}

struct RecordedSymptom: Codable, Hashable {
    var date: String
    var displayName: String
}
