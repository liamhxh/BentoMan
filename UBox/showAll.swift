//
//  ShowAllTableTableViewController.swift
//  UBox
//
//  Created by Liam He on 2/26/18.
//  Copyright © 2018 Liam He. All rights reserved.
//

import UIKit

class showAll: UITableViewController {

    var jsonArray = [NSDictionary]()
    let imgLink = "http://192.168.1.113:8000/media/Lunchbox/Emily/Pork/Roasted-Pork-Shoulder_exps85295_HCA2081250C02_28_4bC_RMS.jpg"


    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://192.168.1.113:8000/api/lunchbox/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in

            do {
                if let d = data {
                    let json = try JSONSerialization.jsonObject(with: d)
                    self.jsonArray = json as! [NSDictionary]
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error deserializing JSON: \(error)")
            }

        })
        task.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell

        cell.dish.text = jsonArray[indexPath.row]["title"] as? String

        return cell
    }















}
