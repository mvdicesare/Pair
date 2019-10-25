//
//  PairTableViewCell.swift
//  Pair
//
//  Created by Michael Di Cesare on 10/25/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import UIKit

class PairTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
        
    func updateViews(){
        PairController.shared.pairs.shuffle()
        
    }
}

extension PairTableViewCell {
    func update(withPress name: Pair) {
        nameLabel.text = name.name
    }
}

