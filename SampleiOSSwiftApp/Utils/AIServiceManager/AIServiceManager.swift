//
//  AIServiceManager.swift
//
//  Created by iMac on 09/07/24.
//

import Alamofire
import UIKit
import SwiftyJSON

class AIServiceManager: NSObject {
    
    static let sharedManager : AIServiceManager = {
        let instance = AIServiceManager()
        return instance
    }()
    
    let manager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        configuration.timeoutIntervalForRequest = 500
        configuration.timeoutIntervalForResource = 500
        return Session(configuration: configuration, delegate: SessionDelegate())
//        return SessionManager(configuration: configuration, delegate: SessionDelegate())
    }()
    // MARK: - ERROR HANDLING
    func handleError(_ errorToHandle : NSError){
        
        if(errorToHandle.domain == CUSTOM_ERROR_DOMAIN)    {
            //let dict = errorToHandle.userInfo as NSDictionary
            displayAlertWithTitle(APP_NAME, andMessage:DEFAULT_ERROR, buttons: ["Dismiss"], completion: nil)
            
        }else if(errorToHandle.code == -1009){
            displayAlertWithTitle(APP_NAME, andMessage: INTERNET_ERROR, buttons: ["Dismiss"], completion: nil)
        }
        else{
            if(errorToHandle.code == -999){
                return
            }
            displayAlertWithTitle(APP_NAME, andMessage:errorToHandle.localizedDescription, buttons: ["Dismiss"], completion:nil)
        }
    }
    
    func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    /*
     // MARK: - ************* COMMON API METHOD **************
     
     */
    
    func makeRequestForXMLParse(url:String,success: @escaping (_ response: Data) -> Void)  {
        let finalUrl = url.URLEncode()
        AF.request(finalUrl, method: .get, parameters: nil).response { (res) in
            if let data = res.data {
                success(data)
            }
        }
        
    }
    
    func makeRequest(with url: String, method: Alamofire.HTTPMethod, parameter: [String:Any]?, success: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: String) -> Void, connectionFailed: @escaping (_ error: String) -> Void) {
        
        if !isConnectedToInternet()
        {
            SHOW_INTERNET_ALERT()
            connectionFailed(INTERNET_ERROR)
            return
        }
        
        let header : HTTPHeaders = ["Content-Type":"application/json"]
        
        AF.request(url, method: method,parameters: parameter,encoding: JSONEncoding.default,headers: header).responseDecodable(of: JSON.self) { res in
            HIDE_CUSTOM_LOADER()
            print("Result \(res.result)")
            switch res.result {
            case .success(let value):
                if let dictData = value.dictionary {
                    if let force_logout = dictData["force_logout"]?.intValue, force_logout == 1 {
                        
                    } else {
                        success(value)
                    }
                } else {
                    success(value)
                }
                break
            case .failure(let error):
                failure(error.localizedDescription)
                break
            }
        }
    }
    
    
    func callAPI(url:String,parameter: [String : AnyObject]?,isShowLoader:Bool = true, httpMethod : HTTPMethod = .post,parseToClass : String = "",
                 success: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: String) -> Void, connectionFailed: @escaping (_ error: String) -> Void)
    {
        
        if !isConnectedToInternet()
        {
            SHOW_INTERNET_ALERT()
            connectionFailed(INTERNET_ERROR)
            return
        }
        
        if  isShowLoader
        {
            SHOW_CUSTOM_LOADER()
        }
        
        let url = url.URLEncode()
        print("url>> \(url)")
        
        print(parameter ?? "")
        
        let header : HTTPHeaders = ["Content-Type":"application/json"]
        
        AF.request(url, method: httpMethod,parameters: parameter,encoding: URLEncoding.default,headers: header).responseDecodable(of: JSON.self) { res in
            
            print("HTML Response : \(String(data: res.data ?? Data(), encoding: .utf8) ?? "N/A")")
            
            if  isShowLoader
            {
                HIDE_CUSTOM_LOADER()
            }
            print("Result \(res.result)")
            switch res.result {
            case .success(let value):
                if let dictData = value.dictionary{
                    if let force_logout = dictData["force_logout"]?.intValue, force_logout == 1 {
                    } else {
                        success(value)
                    }
                } else {
                    success(value)
                }
                break
            case .failure(let error):
                let alamoCode = error._code
                if alamoCode == -1001 {
                    failure(res.error?.localizedDescription ?? "")
                }else if alamoCode == -1005 || alamoCode == 13{
                    HIDE_CUSTOM_LOADER()
                    print("Fail Error : \(res.error?.localizedDescription ?? "")")
                }else{
                    failure(res.error?.localizedDescription ?? "")
                }
                break
            }
        }
    }
    
    
    func cancelAllAPIRequest() {
        manager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
    
    func cancelAllRequest(for path: String) {
        guard let url = URL(string: path) else { return }
        manager.session.getAllTasks { (tasks) in
            tasks.forEach{
                if $0.originalRequest?.url?.lastPathComponent == url.lastPathComponent {
                    $0.cancel()
                }
            }
        }
    }
}

