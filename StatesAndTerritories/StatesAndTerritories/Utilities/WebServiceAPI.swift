//
//  WebServiceAPI.swift
//  StatesAndTerritories
//
//  Created by Jovito Royeca on 14.11.18.
//  Copyright © 2018 Jovito Royeca. All rights reserved.
//

import UIKit
import PromiseKit

enum EndPoints {
    static let states = "http://services.groupkt.com/state/get/USA/all"
}

/*
 * This class handles loading data from Web Service or local bundled JSON file.
 */
class WebServiceAPI: NSObject {
    /*
     * Fetch states from WebService
     */
    func fetchStates() -> Promise<[[String: Any]]> {
        return Promise { seal  in
            guard let urlString = EndPoints.states.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let url = URL(string: urlString) else {
                return
            }
            
            var rq = URLRequest(url: url)
            rq.httpMethod = "GET"

            firstly {
                URLSession.shared.dataTask(.promise, with: rq)
            }.compactMap {
                try JSONSerialization.jsonObject(with: $0.data) as? [String: Any]
            }.done { json in
                if let restResponse = json["RestResponse"] as? [String: Any],
                    let result = restResponse["result"] as? [[String: Any]] {
                    seal.fulfill(result)
                } else {
                    let error = NSError(domain: "Error", code: 401, userInfo: [NSLocalizedDescriptionKey: "result key not found"])
                    seal.reject(error)
                }
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
