//
//  SymptomsManager.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import Foundation

class SymptomsManager {
    
    static let shared = SymptomsManager()
    let preferences = UserDefaults.standard
    
    func postRecordedSymptom(with symptom: Symptom) {
        let recordedSymptom = RecordedSymptom(date: getTime(), displayName: symptom.displayName)
        if let data = preferences.value(forKey: "recordedSymptoms") as? Data {
            guard var recordedSymptoms = try? PropertyListDecoder().decode(Array<RecordedSymptom>.self, from: data) else { return }
            recordedSymptoms.append(recordedSymptom)
            preferences.set(try? PropertyListEncoder().encode(recordedSymptoms), forKey: "recordedSymptoms")
        } else {
            preferences.set(try? PropertyListEncoder().encode([recordedSymptom]), forKey: "recordedSymptoms")
        }
    }
    
    func getRecordedSymptoms(completion: @escaping ([RecordedSymptom]) -> Void) {
        if let data = preferences.value(forKey: "recordedSymptoms") as? Data {
            guard let symptoms = try? PropertyListDecoder().decode(Array<RecordedSymptom>.self, from: data) else { return }
            completion(symptoms)
        }
    }
    
}

extension SymptomsManager {
    func getTime() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: Date())
    }
}
