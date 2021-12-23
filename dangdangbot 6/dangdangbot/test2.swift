//
//  test2.swift
//  dangdangbot
//
//  Created by 오국원 on 2021/11/06.
//

import UIKit

class test2: UIViewController {
    @IBOutlet weak var label1: UILabel!
    var url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let plz1 = test1()
        let plz = plz1.url
        print(plz)
        print("hello")

        // Do any additional setup after loading the view.
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
