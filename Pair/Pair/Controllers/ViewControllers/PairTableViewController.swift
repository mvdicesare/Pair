//
//  PairTableViewController.swift
//  Pair
//
//  Created by Michael Di Cesare on 10/25/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import UIKit

class PairTableViewController: UITableViewController  {
    
    var sortedArray: [[Pair]] = []
    var array: [Pair] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add a new name", message: "", preferredStyle: .alert)
        let addItem = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let newItem = alert.textFields?[0].text else {return}
            PairController.shared.addName(name: newItem)
            self.array = PairController.shared.pairs
            self.sortedArray = [self.array]
            self.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addTextField { (_) in
        }
        alert.addAction(addItem)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
    
    @IBAction func randomButtonPressed(_ sender: Any) {
            pairMaker(of: 2, in: PairController.shared.pairs)
        tableView.reloadData()
    }
    
    func viewSetup() {
        PairController.shared.loadFromPersistantStore()
        self.array = PairController.shared.pairs
        self.sortedArray = [self.array]
    }
    
    func pairMaker<T>(of bunchCount: Int, in input: [T]) -> [[T]] {
        var currentPair = [T]()
        var returnValue = [[T]]()
        let inputShuffled = input.shuffled()
        for value in inputShuffled {
            if currentPair.count >= (bunchCount - 1) {
                currentPair.append(value)
                returnValue.append(currentPair)
                currentPair = []
            } else {
                currentPair.append(value)
            }
        }
        if !currentPair.isEmpty {
            returnValue.append(currentPair)
        }
        self.sortedArray = returnValue as! [[Pair]]
        return returnValue
    }
    
    func popOnlyFriendAlertController() {
        let alert = UIAlertController(title: "Sorry Bro you got to resort the pairs! ", message: nil, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Okay", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pair \(section + 1)"
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedArray[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as? PairTableViewCell else { return UITableViewCell()}
        let names = sortedArray[indexPath.section][indexPath.row]
        cell.update(withPress: names)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = self.sortedArray[indexPath.section][indexPath.row]
            PairController.shared.removeName(name: itemToDelete)
            guard let newItemToDelete = array.firstIndex(of: itemToDelete) else {return}
            array.remove(at: newItemToDelete)
            self.sortedArray[indexPath.section].remove(at: indexPath.row)
            DispatchQueue.main.async {
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.viewSetup()
                tableView.reloadData()
                self.popOnlyFriendAlertController()
            }
        }
    }
    
    
    
    //            let nameToDelete = PairController.shared.pairs[indexPath.row]
    //            PairController.shared.removeName(name: nameToDelete)
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //        }
    //    }
}
