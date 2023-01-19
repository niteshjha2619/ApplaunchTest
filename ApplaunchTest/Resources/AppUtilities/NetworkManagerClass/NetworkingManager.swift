
import UIKit
import SystemConfiguration

var NewtworkManagerInstance = NetworkManager.sharedInstance

public enum HTTPMethod : String {
    case GET     = "GET"
    case POST    = "POST"
    case PUT     = "PUT"
    case PATCH   = "PATCH"
    case DELETE  = "DELETE"
}

class NetworkManager: NSObject {
    
    static let sharedInstance = NetworkManager()
    
    func callApiService(serviceUrl:String,parameters:[String:Any],method: HTTPMethod, isLoading:Bool = true, complation: @escaping (_ result: Any?, _ data: Data) -> (Void)) -> Void {
        
        print("url is===>\(serviceUrl)")
        print("Patameter -----> \(parameters)")
        startLoading(isLoading: isLoading)
        if Reachability.isConnectedToNetwork() {
            let serviceUrl = getServiceUrl(string: serviceUrl)
            let request = NSMutableURLRequest(url: URL(string: serviceUrl)!)
            request.timeoutInterval = Double.infinity
            let session = URLSession.shared
            
            let accessToken = UserDefaults.standard.getLoggedInAccessToken()
            request.addValue(accessToken, forHTTPHeaderField: kAccessToken)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            switch method {
            case .POST:
                request.httpMethod = "POST"
                //Note : Add the corresponding "Content-Type" and "Accept" header. In this example I had used the application/json.
                request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
                
            case .GET:
                request.httpMethod = "GET"
            case .PUT:
                request.httpMethod = "PUT"
                request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            case .PATCH:
                request.httpMethod = "PATCH"
                request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            case .DELETE:
                request.httpMethod = "DELETE"
                request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            }
            
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
                startLoading(isLoading: false)
                guard data != nil else {return}
                guard let httpResponse = response as? HTTPURLResponse else {return}
                let response = getDataAnyFormData(data: data!)
                guard let returnData = response.responseData?["returnData"] as? [String: Any] else {return}
                switch httpResponse.statusCode {
                case 200...399:
                    complation(returnData, data!)
                case 400:
                    DispatchQueue.main.async {showAlertMessage.alert(message: returnData["message"] as? String ?? "")}
                case 401:
                    DispatchQueue.main.async {showAlertMessage.alert(message: returnData["detail"] as? String ?? "")}
                default:
                    DispatchQueue.main.async {showAlertMessage.alert(message: error?.localizedDescription ?? "")}
                }
            }
            task.resume()
        } else {
            startLoading(isLoading: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {showAlertMessage.alert(message: "No Network Available")}
        }
    }
    public func getServiceUrl(string: String) -> String {
        if string.contains("http") {
            return string
        }
        else {
            return kBaseUrl + string
        }
    }
}
//MARK: - Extension for Downlode Image Using URl Sessions
extension UIImageView {
    
    //MARK:- Func for downlode image
    func downlodeImage(serviceurl:String?, placeHolder: UIImage?) {
        
        self.image = placeHolder
        let urlString = serviceurl!
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }
        
        //MARK:- Check image Store in Cache or not
        if let cachedImage = iimageCache.object(forKey: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as NSString) {
            if  let image = cachedImage as? UIImage {
                self.image = image
                print("Find image on Cache : For Key" , urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
                return
            }
        }
        
        print("Conecting to Host with Url:-> \(url)")
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                DispatchQueue.main.async {
                    self.image = placeHolder
                    return
                }
            }
            if data == nil {
                DispatchQueue.main.async {
                    self.image = placeHolder
                }
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    self.image = image
                    iimageCache.setObject(image, forKey: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as NSString)
                }
            }
        }).resume()
    }
}

//MARK: - Extension of Data For Apped String
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
