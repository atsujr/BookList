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
    
    var slider = UISlider()
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var autherTextField: UITextField!
    
    @IBOutlet weak var bookImageViewInEdit: UIImageView!
    @IBOutlet weak var bookScoreLabel: UILabel!
    
    @IBOutlet weak var bookScoreSlider: UISlider!
    
    @IBOutlet weak var oneOfThreeTextField: UITextField!
    @IBOutlet weak var twoOfThreeTextField: UITextField!
    @IBOutlet weak var threeOfThreeTextField: UITextField!
    
    @IBOutlet weak var bigBookTitleLabel: UILabel!
    @IBOutlet weak var bigAutherNameLabel: UILabel!
    @IBOutlet weak var bigBookImageLabel: UILabel!
    @IBOutlet weak var bigBookScoreLabekl: UILabel!
    @IBOutlet weak var bigBookMatomeLabel: UILabel!
    @IBOutlet weak var bigMemoLabel: UILabel!
    @IBOutlet weak var takePhotoButoon: UIButton!
    
    @IBOutlet weak var bookMemo: UITextField!
    
    @IBOutlet weak var savebutton: UIBarButtonItem!
//    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    var sliderNum: Int = 0
    
    @IBOutlet weak var memoTextField: UITextField!
    var booklogsInEdit = [BookLog]()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareview()
        bookTitleTextField.delegate = self
        autherTextField.delegate = self
        oneOfThreeTextField.delegate = self
        twoOfThreeTextField.delegate = self
        threeOfThreeTextField.delegate = self
        
        bookMemo.delegate = self
        // Do any additional setup after loading the view.
        preparefont()
        
    }
    func preparefont() {
        bigBookTitleLabel.font  = .smartfont(ofSize: 17)
        bigAutherNameLabel.font = .smartfont(ofSize: 17)
        bigBookImageLabel.font = .smartfont(ofSize: 17)
        bigBookScoreLabekl.font = .smartfont(ofSize: 17)
        bigBookMatomeLabel.font = .smartfont(ofSize: 17)
        bigMemoLabel.font = .smartfont(ofSize: 17)
        takePhotoButoon.titleLabel?.font = UIFont(name: "03SmartFontUI", size: 17)
        
        savebutton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "03SmartFontUI", size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.black],
            for: .normal)
        backButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "03SmartFontUI", size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.black],
            for: .normal)
    }
    //?????????????????????????????????????????????
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func sliderchancge(_ sender: UISlider) {
        //sliderNum = String(format: "%.0f", sender.value * 100)
        bookScoreLabel.text = String(format: "%.0f", sender.value * 100)
        sliderNum = Int(sender.value * 100)
    }

    
    @IBAction func saveInEdit(_ sender: Any) {
        
        guard let bookTitle = bookTitleTextField.text else { return }
        guard let authername = autherTextField.text else { return }

        guard let oneOfThree = oneOfThreeTextField.text else { return }
        guard let twoOfThree = twoOfThreeTextField.text else { return }
        guard let threeOfThree = threeOfThreeTextField.text else { return }
        
        
        guard let bookmemo = bookMemo.text else { return }
        try! realm.write{
            booklogsInEdit[selectedNum].bookName = bookTitle
            booklogsInEdit[selectedNum].auther = authername
            
            booklogsInEdit[selectedNum].oneOfThreeWords = oneOfThree
            booklogsInEdit[selectedNum].twoOfThreeWords = twoOfThree
            booklogsInEdit[selectedNum].threeOfThreeWords = threeOfThree
            
            booklogsInEdit[selectedNum].bookPoint = sliderNum
            
            booklogsInEdit[selectedNum].memo = bookmemo
            if let settingbookimage = bookImageViewInEdit.image{
                let bookimageurl = saveImage(image: settingbookimage)
                
                booklogsInEdit[selectedNum].bookImageFileName = bookimageurl
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // ?????????????????????????????????
    func saveImage(image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return nil }
        
        do {
            let fileName = UUID().uuidString + ".jpeg" // ????????????????????????(UUID?????????????????????ID)
            let imageURL = getImageURL(fileName: fileName) // ????????????URL????????????
            try imageData.write(to: imageURL) // imageURL????????????????????????
            return fileName
        } catch {
            print("Failed to save the image:", error)
            return nil
        }
    }
    @IBAction func takeBookPhotoButton(_ sender: Any) {
        presentPickerController(sourceType: .camera)
    }
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            //??????if?????????????????????????????????????????????????????????
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
    
    //?????????????????????????????????????????????????????????????????????
    
    func prepareview(){
        booklogsInEdit = Array(realm.objects(BookLog.self)).reversed()
        
        bookTitleTextField.text = booklogsInEdit[selectedNum].bookName
        autherTextField.text = booklogsInEdit[selectedNum].auther
        
        bookScoreLabel.text = String(booklogsInEdit[selectedNum].bookPoint)
        bookScoreSlider.value = Float(booklogsInEdit[selectedNum].bookPoint)
        sliderNum = Int(booklogsInEdit[selectedNum].bookPoint)
        
        oneOfThreeTextField.text = booklogsInEdit[selectedNum].oneOfThreeWords
        twoOfThreeTextField.text = booklogsInEdit[selectedNum].twoOfThreeWords
        threeOfThreeTextField.text = booklogsInEdit[selectedNum].threeOfThreeWords
        
        memoTextField.text = booklogsInEdit[selectedNum].memo
        
        if let imageFileName = booklogsInEdit[selectedNum].bookImageFileName {
            let path = getImageURL(fileName: imageFileName).path // ????????????????????????
            if FileManager.default.fileExists(atPath: path) { // path???????????????????????????????????????????????????
                if let imageData = UIImage(contentsOfFile: path) { // path???????????????????????????????????????
                    bookImageViewInEdit.image = imageData
                } else {
                    print("Failed to load the image. path = ", path)
                }
            } else {
                print("Image file not found. path = ", path)
            }
        }
        bookScoreSlider.setValue(Float(Float(booklogsInEdit[selectedNum].bookPoint) / 100), animated: false)
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
extension EditViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


