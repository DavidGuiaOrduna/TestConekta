//
//  InfoDataViewController.swift
//  TestConekta
//
//  Created by David Guia on 05/04/21.
//

import UIKit
import RxCocoa
import RxSwift
import WebKit

final class InfoDataViewController: UIViewController {
    
    @IBOutlet private weak var tblTest: UITableView!
    @IBOutlet private weak var wKWebView: WKWebView!
    
    var arr_info: [ResultModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension InfoDataViewController: RequestManagerDelegate {
    func bind() {
        tblTest.dataSource = self
        tblTest.delegate = self
        tblTest.backgroundColor = UIColor.clear
        view.backgroundColor = UIColor(red: 244.0 / 255.0, green: 243.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
        callService()
        loadWebView()
    }
    
    func callService() {
        let service = RequetsManager()
        service.delegate = self
        service.getAllTestData()
    }
    
    func didGetResponseModel(response: [ResultModel]) {
        arr_info = response
        DispatchQueue.main.async {
            self.tblTest.reloadData()
        }
    }
}

extension InfoDataViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDataViewCell") as? InfoDataViewCell
        cell?.backgroundColor = UIColor(red: 244.0 / 255.0, green: 243.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
        let test = arr_info?[indexPath.row]
        let idLabel:String = String(test?.id ?? 0)
        cell?.iDLabel.text = idLabel
        cell?.infoLabel.text = test?.body ?? ""
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
   }
}

extension InfoDataViewController: WKNavigationDelegate {
    
    func loadWebView() {
        wKWebView.navigationDelegate = self
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/") else { return }
        wKWebView.load(URLRequest(url: url))
        wKWebView.allowsBackForwardNavigationGestures = true
    }
}
