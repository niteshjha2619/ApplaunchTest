//
//  DataTypeFile.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation
import UIKit

var getResponce = "returnData"
typealias Dict = [String:Any]

func getResponseDataArrayFromData(data: Data) -> (responseData: [Any]?, error: NSError?){
    do {
        let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any]
        print("Success with JSON: \(String(describing: responseData))")
        return (responseData, nil)
    } catch let error as NSError {
        print_debug(items: "json error: \(error.localizedDescription)")
        return (nil, error)
    }
}

func getResponseDataDictionaryFromData(data: Data) -> (responseData: Dictionary<String, Any>?, error: Error?){
    do {
        let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, Any>
        print("Success with JSON: \(String(describing: responseData))")
        return (responseData, nil)
    } catch let error {
        print_debug(items: "json error: \(error.localizedDescription)")
        return (nil, error)
    }
}

func getResponseDataStringFromData(data: Data) -> (responseData: Any?, error: Error?){
    do{
        let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? String
        print("Success with JSON: \(String(describing: responseData))")
        return (responseData, nil)
    }catch let error {
        print_debug(items: "json error: \(error.localizedDescription)")
        return (nil, error)
    }
}

func getDataAnyFormData(data :Data) -> (responseData: Dictionary<String,Any>?, error:Error?){
    let responceInDict = getResponseDataDictionaryFromData(data: data)
    if responceInDict.responseData != nil{
        let returnResponce:Dict = [getResponce:responceInDict.responseData!]
        return(returnResponce,responceInDict.error)
    }else{
        let responceInArrayDict = getResponseDataArrayFromData(data: data)
        if responceInArrayDict.responseData != nil{
            let returnResponce:Dict = [getResponce:responceInArrayDict.responseData!]
            return(returnResponce,responceInArrayDict.error)
        }else{
            let responceInString = getResponseDataStringFromData(data: data)
            if responceInString.responseData != nil{
                let returnResponce:Dict = [getResponce:responceInString.responseData!]
                return(returnResponce,responceInArrayDict.error)
            }else{
                let error = responceInArrayDict.error
                return(nil,error)
            }
        }
    }
}
