//
//  AddViewController.swift
//  BookList
//
//  Created by Atsuhiro Muroyama on 2022/09/19.
//

import Foundation
import UIKit
import RealmSwift

class AddViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var autherTextField: UITextField!
    @IBOutlet weak var oneOfThreeWords: UITextField!
    @IBOutlet weak var twoOfThreeWords: UITextField!
    @IBOutlet weak var threeOfThreeWords: UITextField!
    
    @IBOutlet weak var bookPointLabel: UILabel!
    
    let realm = try! Realm()
    
    @IBOutlet weak var bookmemoTextField: UITextField!
    
    var sliderNum: Int = 50
    
    // 編集中のtextFieldを保持する変数
    private var _activeTextField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTitleTextField.delegate = self
        autherTextField.delegate = self
        oneOfThreeWords.delegate = self
        twoOfThreeWords.delegate = self
        threeOfThreeWords.delegate = self
        bookmemoTextField.delegate = self
        
        
        // Do any additional setup after loading the view.
        bookPointLabel.text = String(sliderNum)
    }
    //キーボードをreturnで閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //キーボードを画面タップで閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // キーボード開閉のタイミングを取得
//        let notification = NotificationCenter.default
//        notification.addObserver(self, selector: #selector(self.keyboardWillShow(_:)),
//                                 name: UIResponder.keyboardWillShowNotification,
//                                 object: nil)
//        notification.addObserver(self, selector: #selector(self.keyboardWillHide(_:)),
//                                 name: UIResponder.keyboardWillHideNotification,
//                                 object: nil)
    }
//     /キーボード表示通知の際の処理
//    @objc func keyboardWillShow(_ notification: Notification) {
//        // 編集中のtextFieldを取得
//        guard let textField = _activeTextField else { return }
//        // キーボード、画面全体、textFieldのsizeを取得
//        let rect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
//        guard let keyboardHeight = rect?.size.height else { return }
//        let mainBoundsSize = UIScreen.main.bounds.size
//        let textFieldHeight = textField.frame.height
//
//        let textFieldPositionY = textField.frame.origin.y + textFieldHeight + 10.0
//        let keyboardPositionY = mainBoundsSize.height - keyboardHeight
//
//        if keyboardPositionY <= textFieldPositionY {
//            let duration: TimeInterval? =
//                notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
//            UIView.animate(withDuration: duration!) {
//                self.view.transform = CGAffineTransform(translationX: 0, y: keyboardPositionY - textFieldPositionY)
//            }
//        }
//    }
//
//    // キーボード非表示通知の際の処理
//    @objc func keyboardWillHide(_ notification: Notification) {
//        let duration: TimeInterval? = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
//        UIView.animate(withDuration: duration!) {
//            self.view.transform = CGAffineTransform.identity
//        }
//    }
    @IBAction func takePhoto(_ sender: Any) {
        presentPickerController(sourceType: .camera)
    }
    @IBAction func save(_ sender: Any) {
        saveTweet()
        self.dismiss(animated: true)
    }
    
    @IBAction func sliderchancge(_ sender: UISlider) {
        //sliderNum = String(format: "%.0f", sender.value * 100)
        bookPointLabel.text = String(format: "%.0f", sender.value * 100)
        sliderNum = Int(sender.value * 100)
    }
    func saveTweet() {
        guard let bookTitle = bookTitleTextField.text else { return }
        guard let authertf = autherTextField.text else { return }
        
        guard let oneOfThree = oneOfThreeWords.text else { return }
        guard let twoOfThree = twoOfThreeWords.text else { return }
        guard let threeOfThree = threeOfThreeWords.text else { return }
        
        
        guard let bookmemo = bookmemoTextField.text else { return }
        
        let booklog = BookLog()
        
        booklog.bookName = bookTitle
        booklog.auther = authertf
        //読んだ日時を取得
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        booklog.readTime = formatter.string(from: date)
        
        booklog.bookPoint = sliderNum
        
        booklog.oneOfThreeWords = oneOfThree
        booklog.twoOfThreeWords = twoOfThree
        booklog.threeOfThreeWords = threeOfThree
        booklog.memo = bookmemo
        
        if let settingbookimage = bookImage.image{
            let bookimageurl = saveImage(image: settingbookimage)
            
            booklog.bookImageFileName = bookimageurl
        }
        try! realm.write({
            realm.add(booklog) // レコードを追加している
        })
        
        
        
    }
    // 画像を保存するメソッド
    func saveImage(image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return nil }
        
        do {
            let fileName = UUID().uuidString + ".jpeg" // ファイル名を決定(UUIDは、ユニークなID)
            let imageURL = getImageURL(fileName: fileName) // 保存先のURLをゲット
            try imageData.write(to: imageURL) // imageURLに画像を書き込む
            return fileName
        } catch {
            print("Failed to save the image:", error)
            return nil
        }
    }
    
    // URLを取得するメソッド
    func getImageURL(fileName: String) -> URL {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.appendingPathComponent(fileName)
    }
    
    
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            //上のif文章は、カメラが使用可能か調べている。
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]){
        self.dismiss(animated: true, completion: nil)
        bookImage.image = info[.originalImage] as? UIImage
    }
    
    
}
