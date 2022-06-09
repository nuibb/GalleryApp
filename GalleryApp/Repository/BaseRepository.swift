//
//  BaseRepository.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/8/22.
//

import Foundation

protocol BaseRepository {

    associatedtype T

    func add(entity: T)
    func getAll() -> [T]
    func get(byIdentifier id: String) -> T? 
    //func update(record: T) -> Bool
    //func delete(byIdentifier id: T) -> Bool
}
