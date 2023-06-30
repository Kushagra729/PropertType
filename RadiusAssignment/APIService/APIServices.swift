//
//  APIServices.swift
//  RadiusAssignment
//
//  Created by Kushagra Chandra on 29/06/23.
//

import Foundation
import Alamofire
import ObjectMapper


class APIServices: NSObject{
    static let shared = APIServices()
    private let sourcesURL = URL(string: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db")!
    
    func apiToGetPropertyData(completion : @escaping (Property) -> ()){
        
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let propertyData = try! jsonDecoder.decode(Property.self, from: data)
                completion(propertyData)
            }
        }.resume()
    }
}

