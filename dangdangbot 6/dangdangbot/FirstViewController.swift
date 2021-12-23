//
//  FirstViewController.swift
//  dangdangbot
//4
//  Created by 오국원 on 2021/07/06.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController, UITextFieldDelegate {
    var url: String = ""

    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pswText: UITextField!
    @IBOutlet var loginBtn: UIView!
    @IBOutlet weak var urlText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlText.delegate = self
        
        let myColor : UIColor = UIColor.black
        emailText.layer.borderColor = myColor.cgColor
        pswText.layer.borderColor = myColor.cgColor
        urlText.layer.borderColor = myColor.cgColor
        
        emailText.layer.borderWidth = 0.2
        pswText.layer.borderWidth = 0.2
        urlText.layer.borderWidth - 0.2
        emailText.attributedPlaceholder = NSAttributedString(string: "ID",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        pswText.attributedPlaceholder = NSAttributedString(string: "password",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

                // Do any additional setup after loading the view.
    }
    
    @IBAction func urlMove(_ sender: Any) {
        url = urlText.text ?? ""
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        var id = emailText.text ?? ""
        var pw = pswText.text ?? ""
        var result = 3 //서버열렸냐?
        
        let parameter = [
            "id": id,
            "pw": pw
        ]

        if id.count == 0 || pw.count == 0 {
            var alert = UIAlertController(title: "로그인 오류", message: "모두 입력해주세요!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{

            AF.request(self.url + "/login", method: .post, parameters: parameter,encoding: JSONEncoding.default).responseJSON{ (response) in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Int]{

                        result = json["state"] as? Int ?? 4
                    if result == 1 {
                        var alert = UIAlertController(title: "회원정보 오류", message: "아이디가 존재하지 않습니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        print("result:",result,"@")
                    } else if result == 2{
                        var alert = UIAlertController(title: "회원정보 오류", message: "비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        print("result:",result,"@")
                    }else if result == 0{
                        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "camView") as? CamViewController else {
                            return
                        }
                        nextVC.modalPresentationStyle = .fullScreen
                        nextVC.url = self.url
                        self.present(nextVC, animated: true, completion: nil)
                   }
                }

                case .failure:
                    var alert = UIAlertController(title: "서버 오류", message: "서버와 연결이 끊어졌습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
                    self.present(alert, animated: true, completion: nil)
                        print("서버오류")
                }
                    
                

                }
            }
 

  
        }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        urlText.endEditing(true)
        emailText.endEditing(true)
        pswText.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.urlText {
            self.url = urlText.text ?? ""
        }
        return true
    }
    
    @IBAction func Signup(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SignUpView") as? SignUpViewController else {
            return
        }
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.url = self.url
        self.present(nextVC, animated: true, completion: nil)
    }
    
        //AFrequest 끝
    
}
    


/*
 func checkMate(lock: Int, jsonmessage: Int) -> String {
 if lock == 1{ //서버열림
 if  jsonmessage == 1 { //아이디 없음
 var alert = UIAlertController(title: "회원정보 오류", message: "아이디가 존재하지 않습니다.", preferredStyle: .alert)
 alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
 self.present(alert, animated: true, completion: nil)
 print(" jsonmessage == 1, lock ==",lock)
 } else if jsonmessage == 2{ //비밀번호가 일치하지 않음
 var alert = UIAlertController(title: "회원정보 오류", message: "비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
 alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
 self.present(alert, animated: true, completion: nil)
 print(" jsonmessage == 2, lock ==",lock)
 }else if jsonmessage == 0{ //로그인 성공
 print(" jsonmessage == 0, lock ==",lock)
 
 }
 }else if lock == 2 { //서버 닫힘
 var alert = UIAlertController(title: "서버 오류", message: "서버와 연결이 끊어졌습니다.", preferredStyle: .alert)
 alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
 self.present(alert, animated: true, completion: nil)
 print("서버 닫힘 lock == 0")
 }else{
 print("@@@#",jsonmessage,"##",lock,"$$$")
 }
 return "성공"
 }
 */
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

//로그인 시도0
/*
let json = response.result
result = json["state"].intValue
if result == 1 {
    var alert = UIAlertController(title: "회원정보 오류", message: "아이디가 존재하지 않습니다.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
    self.present(alert, animated: true, completion: nil)
    print("result:",result,"@")
} else if result == 2{
    var alert = UIAlertController(title: "회원정보 오류", message: "비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
    self.present(alert, animated: true, completion: nil)
    print("result:",result,"@")
}else if result == 0{
    print("로그인 성공")
    //var username =
}
*/

//alamofire 로그인 시도1
//AFrequest시작
/*
AF.request("http://590f31850631.ngrok.io/login", method: .post, parameters: parameter,encoding: JSONEncoding.default).responseJSON{ [self] (response) in
    var value = response.value
    let json = JSON(value)
    jsonmessage = json["state"].intValue
    
    switch jsonmessage{
    case 0:
        print("로그인 성공")
    case 1:
        var alert = UIAlertController(title: "회원정보 오류", message: "아이디가 존재하지 않습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
        self.present(alert, animated: true, completion: nil)
        print(" jsonmessage == 1, lock ==",lock)
    case 2:
        var alert = UIAlertController(title: "회원정보 오류", message: "비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
        self.present(alert, animated: true, completion: nil)
        print(" jsonmessage == 2, lock ==",lock)
    default:
        var alert = UIAlertController(title: "서버 오류", message: "서버와 연결이 끊어졌습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("서버가 default 닫힘")
        
    }
}
*/

//alamofire 로그인 시도2
/*
if var value = response.value {
    let json = JSON(value)
    result = json["state"].intValue
    print("@AF.request@")
    print(result,"###")
*/
    /*
    //delegate
    if result == 1 {
        var alert = UIAlertController(title: "회원정보 오류", message: "아이디가 존재하지 않습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("result:",result,"@")
    } else if result == 2{
        var alert = UIAlertController(title: "회원정보 오류", message: "비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("result:",result,"@")
    }else if result == 0{
        print("로그인 성공")
        //var username =
    }
    */
   /* else{
    
    var alert = UIAlertController(title: "서버 오류", message: "서버와 연결이 끊어졌습니다.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
    self.present(alert, animated: true, completion: nil)
        print("서버오류")
}*/
