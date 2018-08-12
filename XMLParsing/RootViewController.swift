//
//  RootViewController.swift
//  XMLParsing
//
//  Created by NoDack on 12/08/2018.
//  Copyright © 2018 zuzero. All rights reserved.
//

import UIKit
import Alamofire

class RootViewController: UITableViewController {
    
    // MARK: 프로퍼티
    
    // 태그 안의 문자열을 저장할 변수
    private var elementValue: String?
    // 하나의 Book 을 저장할 변수
    private var book: Book?
    // Book 전체를 저장할 변수
    private var books: [Book] = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        sleep(10)
        // 문자열을 비동기 적으로 다운로드 받기 - Alamofire 테스트
        let request = Alamofire.request("https://www.daum.net", method: .get, parameters: nil)
        
        request.responseString {
            print($0.result.value)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
        print("hello")
        
        
        
        
        
        
        
        
        // title 은 네비게이션 바 중앙의 문자열이되고 탭 바의 경우네는 탭 바 아이템의 문자열이 됩니다.
        self.title = "Books"
        
        
        if let url = URL(string: "http://sites.google.com/site/iphonesdktutorials/xml/Books.xml") {
            // XMLParser 객체생성
            let xmlParser = XMLParser(contentsOf: url)!
            // delegate 설정
            xmlParser.delegate = self
            // 파싱을 시작하고 delegate 메소드 호출
            xmlParser.parse()
        } else {
            let alert = UIAlertController(title: "서버 오류", message: "서버와 통신중 장애가 발생하였습니다.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert, animated: true)
            
        }
        
       

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = self.books[indexPath.row].title
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
            
        detailVC.book = self.books[indexPath.row]
            
        self.navigationController?.pushViewController(detailVC, animated: true)
            

        
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: XMLParserDelegate 구현

extension RootViewController: XMLParserDelegate {
    
    /**
     - 태그의 시작 부분을 만났을 때 호출되는 메소드
     - elementName: 태그이름
     - attributeDict: 속성과 값을 저장하고 있는 딕셔너리
     */
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        
        if elementName == "Book" {
            self.book = Book()
            let dic = attributeDict as Dictionary
            self.book?.bookId = dic["id"]
        }
    }
    
    // 태그 안의 내용을 만났을 때 호출되는 메소드
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // 패킷단위로 데이터를 가져오기때문에 긴 문장일 경우 한번에 가져오질 못합니다 따라서 계속해서 이어 붙여주어야합니다.
        if self.elementValue == nil {
            self.elementValue = string
        } else {
            self.elementValue = "\(elementValue)\(string)"
        }
    }
    
    /**
     태그의 종료 부분을 만났을 때 호출되는 메소드
     - elementName 가 태그이름
     -
     
     
     */
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
//        if elementName == "Books" {
//            return
//        } else if elementName == "Book" {
//            self.books?.append(self.book!)
//        } else if elementName == "title" {
//            self.book?.title = self.elementValue
//        } else if elementName == "author" {
//            self.book?.author = self.elementValue
//        } else if elementName == "summary" {
//            self.book?.summary = self.elementValue
//        }
//
//        self.elementValue = nil
        
        switch elementName {
        case "Books":
            return
        case "Book":
            self.books.append(self.book!)
        case "title":
            self.book?.title = self.elementValue
        case "author":
            self.book?.author = self.elementValue
        case "summary":
            self.book?.summary = self.elementValue
        default:
            return
        }
        
        self.elementValue = nil
        
        
    }
    
    
    
}












