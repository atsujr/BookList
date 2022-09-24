//
//  EditViewController.swift
//  BookList
//
//  Created by Atsuhiro Muroyama on 2022/09/19.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var selectedNum: Int!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var autherTextField: UITextField!
    
    @IBOutlet weak var bookImageViewInEdit: UIImageView!
    @IBOutlet weak var bookScoreLabel: UILabel!
    
    @IBOutlet weak var bookScoreSlider: UISlider!
    
    @IBOutlet weak var oneOfThreeTextField: UITextField!
    @IBOutlet weak var twoOfThreeTextField: UITextField!
    @IBOutlet weak var threeOfThreeTextField: UITextField!
    
    @IBOutlet weak var memoTextField: UITextField!
    var booklogsInEdit = [BookLog]()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareview()
        // Do any additional setup after loading the view.
    }
  
    @IBAction func saveInEdit(_ sender: Any) {
        
        guard let bookTitle = bookTitleTextField.text else { return }
        try! realm.write{
            booklogsInEdit[selectedNum].bookName = bookTitle
        }
    }
    @IBAction func takeBookPhotoButton(_ sender: Any) {
        presentPickerController(sourceType: .camera)
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
        bookImageViewInEdit.image = info[.originalImage] as? UIImage
    }
    func prepareview(){
        booklogsInEdit = Array(realm.objects(BookLog.self)).reversed()
        
        bookTitleTextField.text = booklogsInEdit[selectedNum].bookName
        autherTextField.text = booklogsInEdit[selectedNum].auther
        
        bookScoreLabel.text = String(booklogsInEdit[selectedNum].bookPoint)
        bookScoreSlider.value = Float(booklogsInEdit[selectedNum].bookPoint)
        
        oneOfThreeTextField.text = booklogsInEdit[selectedNum].oneOfThreeWords
        twoOfThreeTextField.text = booklogsInEdit[selectedNum].twoOfThreeWords
        threeOfThreeTextField.text = booklogsInEdit[selectedNum].threeOfThreeWords
        
        memoTextField.text = booklogsInEdit[selectedNum].memo
        
        if let imageFileName = booklogsInEdit[selectedNum].bookImageFileName {
            let path = getImageURL(fileName: imageFileName).path // 画像のパスを取得
            if FileManager.default.fileExists(atPath: path) { // pathにファイルが存在しているかチェック
                if let imageData = UIImage(contentsOfFile: path) { // pathに保存されている画像を取得
                    bookImageViewInEdit.image = imageData
                } else {
                    print("Failed to load the image. path = ", path)
                }
            } else {
                print("Image file not found. path = ", path)
            }
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
