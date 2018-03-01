//
//  ShowAllTableTableViewController.swift
//  UBox
//
//  Created by Liam He on 2/26/18.
//  Copyright © 2018 Liam He. All rights reserved.
//

import UIKit

class showAll: UITableViewController{

    var jsonArray = [NSDictionary]()
    var swipeIDX = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        //getting API calls
        let apiURL = URL(string: "http://192.168.1.113:8000/api/lunchbox/")
        let task = URLSession.shared.dataTask(with: apiURL!, completionHandler: {
            data, response, error in
            do {
                let json = try JSONSerialization.jsonObject(with: data!)
                self.jsonArray = json as! [NSDictionary]
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch{
                print("ERROR", error)
            }
        })
        task.resume()
    }//view did load


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonArray.count
    }//# of rows in section


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell


        cell.scrollView.delegate = cell

        let imgArray = jsonArray[indexPath.row]["images"] as? [NSDictionary]
        cell.dish.text = jsonArray[indexPath.row]["title"] as? String

        let scrollViewWidth:CGFloat = cell.scrollView.frame.width
        let scrollViewHeight:CGFloat = cell.scrollView.frame.height
        
        var startX :CGFloat = 0

        cell.pageControll.currentPage = 0
        cell.pageControll.numberOfPages = imgArray!.count
        cell.scrollView.contentSize = CGSize(width: scrollViewWidth * CGFloat(imgArray!.count), height:scrollViewHeight)

        cell.scrollView.subviews.forEach({ $0.removeFromSuperview() })

        for index in 0 ..< imgArray!.count {

            let img = UIImageView(frame: CGRect(x:startX, y:0, width: scrollViewWidth, height: scrollViewHeight))

            cell.scrollView.addSubview(img)

            startX += scrollViewWidth

            img.contentMode = .scaleAspectFill
            img.clipsToBounds = true
            let urlStr = "\(imgArray![index]["image"] ?? "No Image Found")"

            img.image = UIImage()

            URLSession.shared.dataTask(with: NSURL(string: urlStr)! as URL, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    img.image = UIImage(data:data!)
                })
            }).resume()
        }


    return cell

}
















}
