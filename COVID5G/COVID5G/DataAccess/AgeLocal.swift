//
//  AgeLocal.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxSwift
import Foundation

class AgeLocal: Repository {
    static func get(disposeBag: DisposeBag,
                    handler: @escaping RepositoryResponse<[AgeGroup]>) {

        guard let path = Bundle.main.path(forResource: "ageGroup", ofType: "json") else {
            handler(nil, RepositoryError.fileNotFoundError)
            return
        }

        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            handler(try JSONDecoder().decode([AgeGroup].self, from: jsonData), nil)
        } catch {
            handler(nil, RepositoryError.decodingError)
        }
    }
}
