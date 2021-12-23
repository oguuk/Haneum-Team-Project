//
//  test1.swift
//  dangdangbot
//
//  Created by 오국원 on 2021/11/06.
//

import UIKit

class test1: UIViewController,UITextFieldDelegate {
    
    var url: String = "ss"
    
    @IBOutlet weak var txtF: UITextField!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtF.delegate = self

        // Do any additional setup after loading the view.
    }
    @IBAction func btnActive(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "test2") as? test2 else {
            return
        }
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.url = self.url
        self.present(nextVC, animated: true, completion: nil)
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.url = txtF.text!
        print(self.url + "$$")
        return true
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
