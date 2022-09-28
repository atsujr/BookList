//
//  BookTableViewCell.swift
//  BookList
//
//  Created by Atsuhiro Muroyama on 2022/09/19.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var booknameLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var readingDayLabel: UILabel!
    @IBOutlet weak var oneOfThreeWordsLabel: UILabel!
    @IBOutlet weak var twoOfThreeWordsLabel: UILabel!
    @IBOutlet weak var threeOfWordsLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
