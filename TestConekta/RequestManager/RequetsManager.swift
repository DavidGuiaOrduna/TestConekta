//
//  RequetsManager.swift
//  TestConekta
//
//  Created by David Guia on 05/04/21.
// 

import UIKit
import Alamofire

protocol RequestManagerDelegate: class {
    func didGetResponseModel(response : [ResultModel] )
}

final class RequetsManager {
    private var baseUrl = "https://jsonplaceholder.typicode.com/posts"
    weak var delegate: RequestManagerDelegate?
    typealias testCallBack = (_ testData: [ResultModel]?, _ status: Bool, _ message:String) -> Void
    var callBack: testCallBack?
    
    func getAllTestData() {
        AF.request(self.baseUrl, method: .get, parameters: nil, encoding: URLEncoding.default,
                   headers: nil, interceptor: nil).response { (responseData) in
                    guard let data = responseData.data else {
                        self.callBack?(nil, false, "")
                        return }
                    do {
                        let testData = try JSONDecoder().decode([ResultModel].self, from: data)
                        print("testData = \(testData)")
                        self.callBack?(testData, true,"")
                        self.delegate?.didGetResponseModel(response: testData)
                    } catch {
                        self.callBack?(nil, false, error.localizedDescription)
                        print("error = \(error)")
                    }
                   }
    }
    
    func completionHandler(callBack: @escaping testCallBack) {
        self.callBack = callBack
    }
}
