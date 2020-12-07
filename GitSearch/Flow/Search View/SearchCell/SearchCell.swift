//
//  SearchCell.swift
//  GitSearch
//
//  Created by Mac on 12/6/20.
//

import UIKit

class SearchCell: UITableViewCell, CellIniitalizable {

    // - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!

    func configCell(with repository: RepositoryModel) {
        self.nameLabel.text = repository.name
        self.starsLabel.text = String(repository.starsCount)
    }
}
