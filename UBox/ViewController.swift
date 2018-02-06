//
//  ViewController.swift
//  UBox
//
//  Created by Liam He on 2/2/18.
//  Copyright © 2018 Liam He. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    
    @IBOutlet weak var ttt:UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var psd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logIn(_ sender: Any) {
        let userName = username.text
        let pd = psd.text
        print(userName)
        print(pd)
//        var request = URLRequest(url: URL(string:"http://127.0.0.1:8000/api-token-auth/")!);
//        request.httpMethod = "GET"
//        let postString = " username=\(String(describing: userName)) password=\(String(describing: pd))"
//        request.httpBody = postString.data(using: .utf8)
//        let task = URLSession.shared.dataTask(with: request){ data, response, error in
//            if error != nil{
//                print(error!)
//            }
//            else{
//                print(data as Any)
//            }
//
//        }
        let json = ["username":userName!,"password":pd!] as [String:String]
       
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let url = URL(string: "http://192.168.1.113:8000/api-token-auth/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        
        task.resume()
        
        
    }
    

}

