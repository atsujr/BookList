//
//  AddViewController.swift
//  BookList
//
//  Created by Atsuhiro Muroyama on 2022/09/19.
//

import UIKit

class AddViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var bookImageButton: UIButton!
    // @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var autherTextField: UITextField!
    @IBOutlet weak var oneOfThreeWords: UITextField!
    @IBOutlet weak var twoOfThreeWords: UITextField!
    @IBOutlet weak var threeOfThreeWords: UITextField!
    
    @IBOutlet weak var bookmemo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
//    @IBAction func takePhoto(_ sender: Any) {
//        presentPickerController(sourceType: .camera)
//    }
    @IBAction func save(_ sender: Any) {
    }
    @IBAction func tapimagebutton(_ sender: Any) {
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
        
        //self.dismiss(animated: true, completion: nil)
        let pickerImage = info[.originalImage] as? UIImage
        bookImageButton.setBackgroundImage(pickerImage, for: .normal)
        picker.dismiss(animated: true)
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
