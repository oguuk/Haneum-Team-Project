//
//  CamViewController.swift
//  dangdangbot
//
//  Created by 오국원 on 2021/08/08.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class CamViewController: UIViewController,UITextFieldDelegate {
    var url: String = ""
    var control: String?
    var audio: String?
    var stream: String?
    var reset: String?
    var restoreFrameValue: CGFloat = 0.0
    
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    @IBOutlet weak var captureBtn: UIButton!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var textInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stream = url + "/stream"
        control = url + "/control"
        audio = url + "/audio"
        reset = url + "/controlagain"
        
        textInput.delegate = self
        loadWebPage(self.stream!+"ing")
        
        let myColor : UIColor = UIColor.black
        textInput.layer.borderColor = myColor.cgColor
        
        textInput.layer.borderWidth = 0.2
        
        textInput.attributedPlaceholder = NSAttributedString(string: "텍스트를 입력해주세요.",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
        
    }

    
    
    
    
    @IBAction func shareBtnTapped(_ sender: UIButton) {
        guard let screenshot = self.view.screenShot() else { return }
        shareImage(screenshot: screenshot)
    }
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        let parameter1 = [
            "num": "0"
        ]
        let parameter2 = [
            "exit": "0"
        ]
        AF.request(self.stream!, method: .post, parameters: parameter1,encoding: JSONEncoding.default).responseJSON{ (response) in}
        
        AF.request(self.reset!, method: .post, parameters: parameter2,encoding: JSONEncoding.default).responseJSON{ (response) in
            switch response.result {
            case .success:
                self.dismiss(animated: true, completion: nil)
            
            case .failure:
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }    
    
    
    @IBAction func rightBtnClicked(_ sender: Any) {
        let parameter = [
            "motor":1
        ]
        
        AF.request(self.control!, method: .post, parameters: parameter,encoding: JSONEncoding.default).responseJSON{ (response) in
        }
    }
    
    @IBAction func leftBtnClicked(_ sender: Any) {
        let parameter = [
            "motor":0
        ]
        
        AF.request(self.control!, method: .post, parameters: parameter,encoding: JSONEncoding.default).responseJSON{ (response) in
        }
    }
    
    // 노티피케이션을 추가하는 메서드
    func addKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil) }
    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil) }
    
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y -= keyboardHeight } }
    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y += keyboardHeight } }

    
    
    func shareImage(screenshot: UIImage){
        // Save or share
        DispatchQueue.main.async{
            let shareSheet = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
            
            self.present(shareSheet, animated: true, completion: nil)
            
        }
    }
    
    
    //GoNaver 페이지 이동 함수
    func loadWebPage(_ url: String){
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        webView.load(myRequest)
    }
    
    // UITextFieldDelegate Return key 이벤트 함수
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.textInput {
            
            var message = textInput.text ?? ""

            let parameter = [
                "number": message
            ]
            
            AF.request(self.audio!, method: .post, parameters: parameter,encoding: JSONEncoding.default).responseJSON{ (response) in
                switch response.result {
                
                case .success: self.textInput.text = ""
                    
                case .failure:
                    var alert = UIAlertController(title: "전송 오류", message: "서버가 연결되어있지 않습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        return true
    }
    
    /*
     func textFieldShouldReturn(textField: UITextField) -> Bool {   // UITextFieldDelegate 추가하므로써 함수를 호출 할 수 있음
     textField.resignFirstResponder()  // 엔터(return)을 누르면 키보드가 내려가게 됨
     return true
     }
     */
    
    //백그라운드를 클릭했을 때 키보드가 내려간다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        textInput.endEditing(true) // textInput는 textFiled 오브젝트 outlet 연동할때의 이름.
        
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

extension UIView{
    
    func screenShot() -> UIImage? {
        let scale = UIScreen.main.scale
        let bounds = self.bounds
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale)
        if let _ = UIGraphicsGetCurrentContext(){
            self.drawHierarchy(in: bounds, afterScreenUpdates: true)
            
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return screenshot
        }
        return nil
    }
}


