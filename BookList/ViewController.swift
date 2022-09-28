//
//  ViewController.swift
//  BookList
//
//  Created by Atsuhiro Muroyama on 2022/09/19.
//

import UIKit
import RealmSwift

class BookListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    let realm = try! Realm()
    
    var booklogs = [BookLog]()
    //画面遷移用の変数を用意しておく
    var nextnum: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableview.dataSource = self
        tableview.delegate = self
        getbooklistData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getbooklistData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenRect = UIScreen.main.bounds
        tableview.frame = CGRect(x: 0, y: 0, width: screenRect.width, height: screenRect.height)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailViewController" {
            let nextVC = segue.destination as! DetailViewController
            nextVC.selectedrowNum = nextnum
        }
    }
    func getbooklistData() {
        booklogs = Array(realm.objects(BookLog.self)).reversed()
        tableview.reloadData()
    }
    
//ここから下はtabkleview周り
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booklogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! BookTableViewCell
        
        cell.bookImage.image = nil
        
        let booklog = booklogs[indexPath.row]
        cell.booknameLabel.text = booklog.bookName
        cell.writerLabel.text = booklog.auther
        cell.readingDayLabel.text = booklog.readTime
        cell.oneOfThreeWordsLabel.text = booklog.oneOfThreeWords
        cell.twoOfThreeWordsLabel.text = booklog.twoOfThreeWords
        cell.threeOfWordsLabel.text = booklog.threeOfThreeWords
        
        if let imageFileName = booklog.bookImageFileName {
            let path = getImageURL(fileName: imageFileName).path // 画像のパスを取得
            print("✊")
            print(booklog.bookName)
            print(path)
            if FileManager.default.fileExists(atPath: path) { // pathにファイルが存在しているかチェック
                if let imageData = UIImage(contentsOfFile: path) { // pathに保存されている画像を取得
                    cell.bookImage.image = imageData
                   // print(path)
                } else {
                    print("Failed to load the image. path = ", path)
                }
            } else {
                print("Image file not found. path = ", path)
            }
        }
        
        return cell
    }
    //urlを取得
    func getImageURL(fileName: String) -> URL {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.appendingPathComponent(fileName)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        nextnum = indexPath.row
        // 別の画面に遷移
        performSegue(withIdentifier: "toDetailViewController", sender: nil)
    }

    
}
