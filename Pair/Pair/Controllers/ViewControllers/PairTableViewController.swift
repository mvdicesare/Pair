//
//  PairTableViewController.swift
//  Pair
//
//  Created by Michael Di Cesare on 10/25/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import UIKit

class PairTableViewController: UITableViewController  {

    var value: [Pair] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PairController.shared.loadFromPersistantStore()
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add a new name", message: "", preferredStyle: .alert)
        let addItem = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let newItem = alert.textFields?[0].text else {return}
            PairController.shared.addName(name: newItem)
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
        shuffle()
        tableView.reloadData()
    }
    
    func shuffle () {
        let names = value
        let namesShuffled = names.shuffled()
        let nameArray = Array(namesShuffled)
        let twoManGroups = nameArray.
    }

    // MARK: - Table view data source
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return }
//          //  PairController.shared.pairs.
//    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return PairController.shared.pairs.firs t &&
//            PairController.shared.pairs.
//    }
// if .count % 2 == 0 {
// return Int(.count) / 2
// } else {
// return Int(.count) / 2 + 1
//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PairController.shared.pairs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as? PairTableViewCell else { return UITableViewCell()}
        let names = PairController.shared.pairs[indexPath.row]
        cell.update(withPress: names)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let nameToDelete = PairController.shared.pairs[indexPath.row]
            PairController.shared.removeName(name: nameToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
}
