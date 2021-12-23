//
//  ffirstViewController.swift
//  dangdangbot
//
//  Created by 오국원 on 2021/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON

class ffirstViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pswText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loginBtnClicked(_ sender: Any) {
        var id = emailText.text ?? ""
        var pw = pswText.text ?? ""
        var lock = 0 //서버열렸냐?
        var jsonmessage = 3 //서버에서 뭐래?
        
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
            //AFrequest시작
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
              
            }
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
