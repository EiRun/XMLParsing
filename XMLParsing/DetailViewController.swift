//
//  DetailViewController.swift
//  XMLParsing
//
//  Created by NoDack on 12/08/2018.
//  Copyright © 2018 zuzero. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    
    // MARK: 프로퍼티
    // RootVC에서 데이터를 넘겨받을 변수 선언
    public var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.book?.title
        self.authorLabel.text = self.book?.author
        self.summaryTextView.text = self.book?.summary

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
