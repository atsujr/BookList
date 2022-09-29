//
//  BookTableViewCell.swift
//  BookList
//
//  Created by Atsuhiro Muroyama on 2022/09/19.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet weak var booknameLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var writerTitleLabel: UILabel!
    
    @IBOutlet weak var readingDayLabel: UILabel!
    @IBOutlet weak var readingDayTitleLabel: UILabel!
    @IBOutlet weak var oneOfThreeWordsLabel: UILabel!
    @IBOutlet weak var twoOfThreeWordsLabel: UILabel!
    @IBOutlet weak var threeOfWordsLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        booknameLabel.font = .smartfont(ofSize: 17)
        writerLabel.font = .smartfont(ofSize: 12)
        writerTitleLabel.font = .smartfont(ofSize: 12)
        readingDayLabel.font = .smartfont(ofSize: 12)
        readingDayTitleLabel.font = .smartfont(ofSize: 12)
        
        oneOfThreeWordsLabel.font = .smartfont(ofSize: 10)
        twoOfThreeWordsLabel.font = .smartfont(ofSize: 10)
        threeOfWordsLabel.font = .smartfont(ofSize: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
extension UIFont {

    static func smartfont(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "03SmartFontUI", size: size)
    }
}
