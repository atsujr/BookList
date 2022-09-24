//
//  BookLog.swift
//  BookList
//
//  Created by Atsuhiro Muroyama on 2022/09/19.
//

import Foundation
import RealmSwift

class BookLog: Object {
    @objc dynamic var bookName: String?
    @objc dynamic var auther: String?
    @objc dynamic var readTime: String?
    @objc dynamic var oneOfThreeWords: String?
    @objc dynamic var twoOfThreeWords: String?
    @objc dynamic var threeOfThreeWords: String?
    @objc dynamic var bookPoint: Int = 0
    @objc dynamic var memo: String?
    @objc dynamic var bookImageFileName: String?
    
    
    
    
}
