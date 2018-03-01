//
//  customCell.swift
//  UBox
//
//  Created by Liam He on 2/26/18.
//  Copyright © 2018 Liam He. All rights reserved.
//

import UIKit

class customCell: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var dish: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
}

private typealias ScrollView = customCell

extension ScrollView{
    func scrollViewDidScroll (_ scrollView: UIScrollView) {
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        self.pageControll.currentPage = Int(currentPage)
    }
}

