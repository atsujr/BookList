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
    
    @IBOutlet weak var bigBookTitleLabel: UILabel!
    @IBOutlet weak var bigAutherNameLabel: UILabel!
    @IBOutlet weak var bigBookImageLabel: UILabel!
    @IBOutlet weak var bigBookScoreLabekl: UILabel!
    @IBOutlet weak var bigBookMatomeLabel: UILabel!
    @IBOutlet weak var bigMemoLabel: UILabel!
    
    @IBOutlet weak var gobutton: UIBarButtonItem!
//    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    var selectedrowNum: Int!
    
    var booklogs = [BookLog]()
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preparefont()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        booklogs = Array(realm.objects(BookLog.self)).reversed()
        
        bookTitleLabel.text = booklogs[selectedrowNum].bookName
        autherLabel.text = booklogs[selectedrowNum].auther
        
        bookScoreLabel.text = String(booklogs[selectedrowNum].bookPoint)
        bookScoreProgressView.setProgress(Float(booklogs[selectedrowNum].bookPoint) / 100, animated: false)
        
        
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
        preparefont()
    }
    func preparefont() {
        bookTitleLabel.font = .smartfont(ofSize: 17)
        autherLabel.font = .smartfont(ofSize: 17)
        bookScoreLabel.font = .smartfont(ofSize: 17)
        
        oneOfThreeMatomeLabel.font = .smartfont(ofSize: 17)
        twoOfThreeMatomeLabel.font = .smartfont(ofSize: 17)
        threeOfThreeMatomeLabel.font = .smartfont(ofSize: 17)
        memoLabel.font = .smartfont(ofSize: 17)
        
        bigBookTitleLabel.font  = UIFont.boldSystemFont(ofSize: 17)
        bigAutherNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        bigBookImageLabel.font = UIFont.boldSystemFont(ofSize: 17)
        bigBookScoreLabekl.font = UIFont.boldSystemFont(ofSize: 17)
        bigBookMatomeLabel.font = UIFont.boldSystemFont(ofSize: 17)
        bigMemoLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 218/255, green: 247/255, blue: 255/255, alpha: 1.0)
        
        gobutton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "03SmartFontUI", size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.black],
            for: .normal)
        backButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "03SmartFontUI", size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.black],
            for: .normal)
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
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
