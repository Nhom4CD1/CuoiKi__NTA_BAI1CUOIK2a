//
//  ViewController.swift
//  NTA_CAU2a
//
//  Created by Cntt19 on 7/5/17.
//  Copyright © 2017 Cntt19. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var txtfURL1: UITextField!
    @IBOutlet weak var txtfURL2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //1.Hàm xử lí sự kiện khi nhấn button
    @IBAction func btnLoadImg(_ sender: Any) {
        //kiem tra textfield co rong
        if (txtfURL1.text == "" || txtfURL2.text == "")
        {
            showAlertDialog(message: "Đường dẫn không được rỗng")
        }
        else{
            let thread1 = DispatchQueue(label: "THREAD 1")
            let thread2 = DispatchQueue(label: "THREAD 2")
            //Chạy thread 1,(bất đồng bộ async)
            thread1.async {
                let imageUrl1: URL = URL(string: self.txtfURL1.text!)!
                (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageUrl1, completionHandler: {(imageData, response, error) in
                    if let data = imageData {
                        DispatchQueue.main.async {
                            self.img1.image = UIImage(data: data)
                        }
                    }
                    
                }).resume()
            }
            //Chạy thread 2

            thread2.async {
                let imageUrl2: URL = URL(string: self.txtfURL2.text!)!
                (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageUrl2, completionHandler: {(imageData, response, error) in
                    if let data = imageData {
                        DispatchQueue.main.async {
                            self.img2.image = UIImage(data: data)
                        }
                    }
                    
                }).resume()
            }
        }
    }
    //  //.Hàm xử lí hiện cảnh báo
    //Hiện cảnh báo
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Notification!!!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
}


