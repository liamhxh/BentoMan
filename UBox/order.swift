//
//  order.swift
//  UBox
//
//  Created by Liam He on 2/26/18.
//  Copyright © 2018 Liam He. All rights reserved.
//

import UIKit

class order: UIViewController {

    @IBOutlet weak var img: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageUrl = URL(string: "https://images.pexels.com/photos/323780/pexels-photo-323780.jpeg?w=1260&h=750&auto=compress&cs=tinysrgb")!
        //create a URL Session, this time a shared one since its a simple app
        let session = URLSession.shared
        //then create a URL data task since we are getting simple data
        let task = session.dataTask(with:imageUrl) { (data, response, error) in
            if error == nil {
                //incase of success, get the data and pass it to the UIImage class
                let downloadedImage = UIImage(data: data!)
                //then we run the UI updating on the main thread.
                DispatchQueue.main.async {
                    self.img.image = downloadedImage
                }
            }
        }
        //then start the task or resume it
        task.resume()
        // Do any additional setup after loading the view.
    }

}
