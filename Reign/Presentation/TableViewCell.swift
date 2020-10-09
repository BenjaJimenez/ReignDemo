//
//  TableViewCell.swift
//  Reign
//
//  Created by Benjamin on 09-10-20.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ item: Item){
        titleLabel.text = item.title
        authorLabel.text = item.author
        dateLabel.text = item.date
    }

}
