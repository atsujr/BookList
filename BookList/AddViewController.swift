//
//  AddViewController.swift
//  BookList
//
//  Created by Atsuhiro Muroyama on 2022/09/19.
//

import Foundation
import UIKit
import RealmSwift

class AddViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBookTitleToolButton()
        makeAutherToolButton()
        makeOneOfThreeToolButton()
        maketwoOfThreeToolButton()
        makethreeOfThreeToolButton()
        // Do any additional setup after loading the view.
        bookPointLabel.text = String(sliderNum)
    }
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
    
    func makeBookTitleToolButton(){
        let toolbar = UIToolbar()
        
        //完了ボタンを右寄せにする為に、左側を埋めるスペース作成
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        //完了ボタンを作成
        let done = UIBarButtonItem(title: "完了",
                                   style: .done,
                                   target: self,
                                   action: #selector(didTapBookTitleDoneButton))
        toolbar.items = [space, done]
        toolbar.sizeToFit()
        
        bookTitleTextField.inputAccessoryView = toolbar
    }
    @objc func didTapBookTitleDoneButton() {
        bookTitleTextField.resignFirstResponder()
    }
    func makeAutherToolButton(){
        let toolbar = UIToolbar()
        
        //完了ボタンを右寄せにする為に、左側を埋めるスペース作成
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        //完了ボタンを作成
        let done = UIBarButtonItem(title: "完了",
                                   style: .done,
                                   target: self,
                                   action: #selector(didTapAutherDoneButton))
        toolbar.items = [space, done]
        toolbar.sizeToFit()
        
        autherTextField.inputAccessoryView = toolbar
    }
    @objc func didTapAutherDoneButton() {
        autherTextField.resignFirstResponder()
    }
    func makeOneOfThreeToolButton(){
        let toolbar = UIToolbar()
        
        //完了ボタンを右寄せにする為に、左側を埋めるスペース作成
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        //完了ボタンを作成
        let done = UIBarButtonItem(title: "完了",
                                   style: .done,
                                   target: self,
                                   action: #selector(didTapOneOfThreeDoneButton))
        toolbar.items = [space, done]
        toolbar.sizeToFit()
        
        oneOfThreeWords.inputAccessoryView = toolbar
    }
    @objc func didTapOneOfThreeDoneButton() {
        oneOfThreeWords.resignFirstResponder()
    }
    func maketwoOfThreeToolButton(){
        let toolbar = UIToolbar()
        
        //完了ボタンを右寄せにする為に、左側を埋めるスペース作成
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        //完了ボタンを作成
        let done = UIBarButtonItem(title: "完了",
                                   style: .done,
                                   target: self,
                                   action: #selector(didTaptwoOfThreeDoneButton))
        toolbar.items = [space, done]
        toolbar.sizeToFit()
        
        twoOfThreeWords.inputAccessoryView = toolbar
    }
    @objc func didTaptwoOfThreeDoneButton() {
        twoOfThreeWords.resignFirstResponder()
    }
    func makethreeOfThreeToolButton(){
        let toolbar = UIToolbar()
        
        //完了ボタンを右寄せにする為に、左側を埋めるスペース作成
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        //完了ボタンを作成
        let done = UIBarButtonItem(title: "完了",
                                   style: .done,
                                   target: self,
                                   action: #selector(didTapthreeOfThreeDoneButton))
        toolbar.items = [space, done]
        toolbar.sizeToFit()
        
        oneOfThreeWords.inputAccessoryView = toolbar
    }
    @objc func didTapthreeOfThreeDoneButton() {
        threeOfThreeWords.resignFirstResponder()
    }
    
    

    
    
    func saveTweet() {
        guard let bookTitle = bookTitleTextField.text else { return }
        guard let authertf = autherTextField.text else { return }
        
        guard let oneOfThree = oneOfThreeWords.text else { return }
        guard let twoOfThree = twoOfThreeWords.text else { return }
        guard let threeOfThree = threeOfThreeWords.text else { return }
        
        //guard let bookreviewpoint = sliderNum else { return }
        
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
