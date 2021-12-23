//
//  SignUpViewController.swift
//  dangdangbot
//
//  Created by 오국원 on 2021/07/06.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController {
    var url: String = ""
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pswText: UITextField!
    @IBOutlet var submitBtn: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myColor : UIColor = UIColor.black
        nameText.layer.borderColor = myColor.cgColor
        emailText.layer.borderColor = myColor.cgColor
        pswText.layer.borderColor = myColor.cgColor

        nameText.layer.borderWidth = 0.2
        emailText.layer.borderWidth = 0.2
        pswText.layer.borderWidth = 0.2
        
        nameText.attributedPlaceholder = NSAttributedString(string: "이름",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailText.attributedPlaceholder = NSAttributedString(string: "아이디",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        pswText.attributedPlaceholder = NSAttributedString(string: "비밀번호 입력",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }
    
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        var name = nameText.text ?? ""
        var id = emailText.text ?? ""
        var pw = pswText.text ?? ""
        var result = 5 //서버열렸냐?
        
        let parameter = [
            "id": id,
            "name": name,
            "pw": pw
        ]
        
        if id.count == 0 || name.count == 0 || pw.count == 0{
            var alert = UIAlertController(title: "회원가입 오류", message: "모두 입력해주세요!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            
            AF.request(url + "/register", method: .post, parameters: parameter,encoding: JSONEncoding.default).responseJSON{ (response) in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Int]{

                        result = json["state"] as? Int ?? 4
                    if result == 1 {
                        var alert = UIAlertController(title: "회원정보 오류", message: "입력되지 않은 정보가 있습니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    } else if result == 2{
                        var alert = UIAlertController(title: "회원정보 오류", message: "해당 아이디가 이미 존재합니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }else if result == 0{
                        let vcName = self.storyboard?.instantiateViewController(withIdentifier:"FirstView")
                        vcName?.modalPresentationStyle = .fullScreen
                        vcName?.modalTransitionStyle = .coverVertical
                        self.present(vcName!, animated: true, completion: nil)
                    }
                }

                case .failure:
                    var alert = UIAlertController(title: "서버 오류", message: "서버와 연결이 끊어졌습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
                    self.present(alert, animated: true, completion: nil)
                        
                }
            }
            /*
            if lock == 1{
                if jsonmessage == 1{
                    var alert = UIAlertController(title: "회원가입 오류", message: "모두 입력해주세요.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print(" jsonmessage == 1, lock ==",lock)
                }else if jsonmessage == 2{
                    var alert = UIAlertController(title: "회원가입 오류", message: "해당 아이디가 이미 존재합니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print(" jsonmessage == 2, lock ==",lock)
                }
            }
            else{
                var alert = UIAlertController(title: "서버 오류", message: "서버와 연결이 끊어졌습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default,handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(" 서버 연결 안됨 lock ==",lock)

                
            } */
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier:"FirstView")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .coverVertical
        self.present(vcName!, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        nameText.endEditing(true)
        emailText.endEditing(true)
        pswText.endEditing(true)
        
    }
    
}

