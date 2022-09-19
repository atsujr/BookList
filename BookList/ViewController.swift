//
//  ViewController.swift
//  BookList
//
//  Created by Atsuhiro Muroyama on 2022/09/19.
//

import UIKit

class BookListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableview.dataSource = self
        tableview.delegate = self
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenRect = UIScreen.main.bounds
        tableview.frame = CGRect(x: 0, y: 0, width: screenRect.width, height: screenRect.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! BookTableViewCell
        cell.booknameLabel.text = "ばなな"
        cell.bookImage.image = UIImage(systemName: "swift")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
}
