//
//  PairController.swift
//  Pair
//
//  Created by Michael Di Cesare on 10/25/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import Foundation

class PairController {
    // singleton
static let shared = PairController()
    // source of truth
    var pairs: [Pair] = []
    
    func addName(name: String) {
        let newName = Pair(name: name)
        pairs.append(newName)
        saveToPersistentStore()
    }
    func removeName(name: Pair) {
        guard let nameIndex = pairs.firstIndex(of: name) else {return}
        pairs.remove(at: nameIndex)
        saveToPersistentStore()
    }
    func updateNames(name: Pair, with title: String) {
        name.name = title
        saveToPersistentStore()
    }
    // MARK: - Persistence
    func createFileForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Pair.json")
        return fileURL
    }
    func saveToPersistentStore(){
        let jsonEncoder = JSONEncoder()
        do {
            let json = try jsonEncoder.encode(pairs)
            try json.write(to: createFileForPersistence())
        } catch let encodeingError {
            print("There was an error saving the data!!!!!! \(encodeingError.localizedDescription)")
        }
    }
    func loadFromPersistantStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let jsonData = try Data(contentsOf: createFileForPersistence())
            let decodedEntryArray = try jsonDecoder.decode([Pair].self, from: jsonData)
            pairs = decodedEntryArray
        } catch let encodeingError {
            print("There was an error loading the data !!!!\(encodeingError.localizedDescription)")
        }
    }
}
