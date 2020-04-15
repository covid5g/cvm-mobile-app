//
//  Repository.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxSwift
import Foundation

typealias RepositoryResponse<Model: Codable> = (_ model: Model?, _ error: Error?) -> Void

enum RepositoryError: Error {
    case networkError
    case fileNotFoundError
    case decodingError
}

protocol Repository {
    associatedtype Model: Codable
    static func get(disposeBag: DisposeBag,
                    handler: @escaping RepositoryResponse<Model>)
}

