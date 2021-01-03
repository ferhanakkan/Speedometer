//
//  ApiService.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 3.01.2021.
//

import Alamofire
import PromiseKit
import UIKit

class ApiService {
//    api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    private var baseApiUrl = ""
    private var endPoint: String = ""
    
    private let sessionManager: Session?
    public var request: DataRequest?
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 25
        configuration.timeoutIntervalForResource = 25
        sessionManager = Alamofire.Session(configuration: configuration)
    }
    
    func headers() -> HTTPHeaders {
        let userDefaults = UserDefaults.standard
        let headerLang = userDefaults.value(forKey: "langHeader") as? String ?? "en-US"

        if let token: String = UserDefaults.standard.value(forKey: Constants.Api.token) as? String {
            return  ["Authorization": "Bearer \(token)",
                     "Content-Type" : "application/json",
                     "Accept-Language": headerLang]
        }
        
        return ["Content-Type" : "application/json",
                "Accept-Language": headerLang ]
        
        
    }
    
    func cancelAllRequests() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
    
    func cancelSelectedRequests() {
        request!.cancel()
    }
    
    //MARK: - Request
    
    @discardableResult
    public func request<T:Decodable>(fullUrl url: String,method: HTTPMethod, parameters: Parameters?) -> Promise<T> {

        
        var encodinga: ParameterEncoding? = nil
        if(method != .get) {
            encodinga = JSONEncoding.default
        } else {
            encodinga = URLEncoding.queryString
        }
      
                
        return Promise<T> { seal in
            request = sessionManager!.request(url, method: method, parameters: parameters, encoding: encodinga!, headers: headers())
                .validate(statusCode: 200..<300)
                .responseDecodable { (response: DataResponse<T, AFError>) in
                    if response.data != nil {
                        
                        switch response.result {
                        case .success(let value):
                            seal.fulfill(value)
                        case .failure(let error):
                            guard let data = response.data else {
                                seal.reject(error)
                                return
                            }
                            
                            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else{
                                seal.reject(error)
                                return
                            }
                            
                            
                            if let code = response.response?.statusCode {
                                if let errorString = ApiServiceErrorHandling().getError(json: json, statusCode: code) {
                                    let error = NSError(domain:"", code:code, userInfo:[ NSLocalizedDescriptionKey: errorString]) as Error
                                    seal.reject(error)
                                }
                            }
                            seal.reject(error)
                        }
                    } else {
                        seal.reject(response.error!)
                    }
                }
        }
        
        
    }
    
    //MARK: Multipart
    
    func upload<T:Decodable>(param:[String: Any], imageData: Data) -> Promise<T>  {
        return Promise<T>{ seal in
            let headers: HTTPHeaders
            headers = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)", "Content-Type" : "multipart/form-data"]
            
            AF.upload(multipartFormData: { (multipart) in
                for (key, value) in param {
//                    multipart.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                    multipart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                
                
                multipart.append(imageData, withName: "upload[0]", fileName: "photo.jpg", mimeType: "image/jpeg")
                
            },to: baseApiUrl, usingThreshold: UInt64.init(),
            method: .post,
            headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable { (response: DataResponse<T, AFError>) in
                if response.data != nil {
                    switch response.result {
                    case .success(let value):
                        
                        seal.fulfill(value)
                    case .failure(let error):
                        guard let data = response.data else {
                            seal.reject(error)
                            return
                        }
                        
                        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else{
                            seal.reject(error)
                            return
                        }
                        
                        if let code = response.response?.statusCode {
                            if let errorString = ApiServiceErrorHandling().getError(json: json, statusCode: code) {
                                let error = NSError(domain:"", code:code, userInfo:[ NSLocalizedDescriptionKey: errorString]) as Error
                                seal.reject(error)
                            }
                        }
                        seal.reject(error)
                    }
                } else {
                    seal.reject(response.error!)
                }
            }
        }
    }

    
    
    
    //MARK: - Actions
    
    func getPagination<T:Decodable>(apiType:ApiType, url: String, page: Int = 0, size: Int = 20) -> Promise<T> {
        baseApiUrl = apiType.rawValue
        endPoint = baseApiUrl+url
        return self.request(fullUrl: endPoint, method: .get, parameters: ["page":page, "size": size])
    }
    
    func get<T: Decodable>(apiType:ApiType, url: String, parameters : [String:Any]? = nil) -> Promise<T> {
        baseApiUrl = apiType.rawValue
        endPoint = baseApiUrl+url
        return self.request(fullUrl: endPoint , method: HTTPMethod.get , parameters : parameters)
    }
    
    func post<T: Decodable>(apiType:ApiType, url: String, parameters: Parameters?) -> Promise<T>  {
        baseApiUrl = apiType.rawValue
        endPoint = baseApiUrl+url
        return self.request(fullUrl: endPoint , method: HTTPMethod.post , parameters : parameters)
    }
    
    func put<T: Decodable>(apiType:ApiType, url: String, parameters: Parameters) -> Promise<T> {
        baseApiUrl = apiType.rawValue
        endPoint = baseApiUrl+url
        return self.request(fullUrl: endPoint , method: HTTPMethod.put , parameters : parameters)
    }
    
    func patch<T: Decodable>(apiType:ApiType, url: String, parameters: Parameters) -> Promise<T> {
        baseApiUrl = apiType.rawValue
        endPoint = baseApiUrl+url
        return self.request(fullUrl: endPoint , method: HTTPMethod.patch , parameters : parameters)
    }
    
    func delete<T: Decodable>(apiType:ApiType, url: String, parameters: Parameters? = nil) -> Promise<T> {
        baseApiUrl = apiType.rawValue
        endPoint = baseApiUrl+url
        return self.request(fullUrl: endPoint , method: HTTPMethod.delete , parameters : parameters)
    }
    
}

