//
//  MultipartApiClass.swift
//  NetworkManager
//
//  Created by Creative Kids on 03/02/22.
//

import Foundation
import UIKit

extension NetworkManager {
    
    func callMultipartApi(url: String, param: [String: Any], method: HTTPMethod, isLoading:Bool = true, complation: @escaping (_ result: Any?) -> ()) {
        startLoading(isLoading: isLoading)
        
        print("url is===>\(url)")
        print("Parameter -----> \(param)")
        
        if  Reachability.isConnectedToNetwork() {
            let serviceUrl = getServiceUrl(string: url)
            guard let url = URL(string: serviceUrl) else {return}
            
            let boundary = generateBoundary()
            
            let accessToken = UserDefaults.standard.getLoggedInAccessToken()
            
            var request = URLRequest(url: url)
            
            request.httpMethod = method.rawValue
            request.setValue(accessToken, forHTTPHeaderField: kAccessToken)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let dataBody = try? createBody(parameters: param, boundary: boundary, mimeType: "image/jpeg/png/jpg/docx/doc/pdf/mp4/mov/movie")
            request.httpBody = dataBody
            
            URLSession.shared.dataTask(with: request){(data , response , error) in
                print("Details: \(String(describing: data)) --- ResponseIs: \(String(describing: response)) --- ErrorIs \(String(describing: error))")
                startLoading(isLoading: false)
                
                guard error == nil else {
                    let returnMessage = "RequestFailed :->  \(String(describing: error!.localizedDescription))"
                    DispatchQueue.main.async { showAlertMessage.alert(message: returnMessage)}
                    return
                }
                
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    guard  let httpsresponse = response as? HTTPURLResponse else {return}
                    let statusCode = httpsresponse.statusCode
                    let response = getDataAnyFormData(data: data)
                    guard let returnData = response.responseData?["returnData"] as? [String: Any] else {return}
                    print(returnData)
                    switch statusCode{
                    case 200 :
                        complation(returnData)
                    case 400:
                        DispatchQueue.main.sync {showAlertMessage.alert(message: returnData["message"] as? String ?? "")}
                    case 401:
                        DispatchQueue.main.async {showAlertMessage.alert(message: returnData["detail"] as? String ?? "")}
                    default:
                        DispatchQueue.main.async { showAlertMessage.alert(message: error?.localizedDescription ?? "")}
                    }
                }
                
            }.resume()
        } else {
            DispatchQueue.main.async {showAlertMessage.alert(message: "No Network Available")}
        }
    }
    
    //MARK: For Generate Boundary
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    //MARK: Create Body
    func createBody(parameters: [String: Any], boundary: String, mimeType: String) throws -> Data {
        var body = Data()
        let filename = arc4random()
        let lineBreak = "\r\n"
        for (key, value) in parameters {
            if(value is String || value is NSString) {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value)\(lineBreak)")
            } else if let imagValue = value as? UIImage {
                let data: Data = imagValue.jpegData(compressionQuality: 0.5)!
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\(lineBreak)")
                body.append("Content-Type: \(mimeType + lineBreak + lineBreak)")
                body.append(data)
                body.append("\(lineBreak)")
                
            }else if value is [String: String] {
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                for (keyy, valuee) in (value as? [String: String])! {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(keyy)\"\(lineBreak + lineBreak)")
                    body.append("\(valuee + lineBreak)")
                }
                
            } else if let images = value as? [UIImage] {
                
                for image in images {
                    let data: Data = image.jpegData(compressionQuality: 0.5)!
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\(lineBreak)")
                    body.append("Content-Type: \(mimeType + lineBreak + lineBreak)")
                    body.append(data)
                    body.append("\(lineBreak)")
                    
                }
            } else if let videoData = value as? Data { //MARK:  it is Used for Video and pdf send to the server
                let data : Data = videoData
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\(lineBreak)")
                body.append("Content-Type: \(mimeType + lineBreak + lineBreak)")
                body.append(data)
                body.append("\r\n")
            } else if let multipleData = value as? [Data] { //MARK:  It is used for Multiple Data to api
                for filedata in multipleData {
                    let data: Data = filedata
                    body.append("--\(boundary)\r\n")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                    body.append("Content-Type: \(mimeType)\r\n\r\n")
                    body.append(data)
                    body.append("\r\n")
                    
                }
            }
        }
        body.append("--\(boundary)--\r\n")
        return body
    }
}
