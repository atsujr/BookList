//
//  DetailViewController.swift
//  BookList
//
//  Created by Atsuhiro Muroyama on 2022/09/19.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var bookScoreLabel: UILabel!
    @IBOutlet weak var bookScoreProgressView: UIProgressView!
    
    
    @IBOutlet weak var oneOfThreeMatomeLabel: UILabel!
    @IBOutlet weak var twoOfThreeMatomeLabel: UILabel!
    @IBOutlet weak var threeOfThreeMatomeLabel: UILabel!
    
    
    @IBOutlet weak var memoLabel: UILabel!
    
    var selectedrowNum: Int!
    
    var booklogs = [BookLog]()
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        booklogs = Array(realm.objects(BookLog.self)).reversed()
        
        bookTitleLabel.text = booklogs[selectedrowNum].bookName
        autherLabel.text = booklogs[selectedrowNum].auther
        
        bookScoreLabel.text = String(booklogs[selectedrowNum].bookPoint)
        bookScoreProgressView.setProgress(Float(booklogs[selectedrowNum].bookPoint) / 100, animated: true)
        
        
        oneOfThreeMatomeLabel.text = booklogs[selectedrowNum].oneOfThreeWords
        twoOfThreeMatomeLabel.text = booklogs[selectedrowNum].twoOfThreeWords
        threeOfThreeMatomeLabel.text = booklogs[selectedrowNum].threeOfThreeWords
        
        memoLabel.text = booklogs[selectedrowNum].memo
        
        if let imageFileName = booklogs[selectedrowNum].bookImageFileName {
            let path = getImageURL(fileName: imageFileName).path // 画像のパスを取得
            if FileManager.default.fileExists(atPath: path) { // pathにファイルが存在しているかチェック
                if let imageData = UIImage(contentsOfFile: path) { // pathに保存されている画像を取得
                    bookImageView.image = imageData
                } else {
                    print("Failed to load the image. path = ", path)
                }
            } else {
                print("Image file not found. path = ", path)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditVIewController" {
            let nextVC = segue.destination as! EditViewController
            nextVC.selectedNum = selectedrowNum
        }
    }
    
    
    func getImageURL(fileName: String) -> URL {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.appendingPathComponent(fileName)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
