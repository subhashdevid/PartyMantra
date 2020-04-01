//
//  NetworkManager.swift
//  PartyMantra
//
//  Created by Apple on 23/10/19.
//  Copyright © 2019 abc. All rights reserved.
//

import Foundation
import UIKit

public enum RequestMethod: String {
//    case head = "HEAD"
    case post = "POST"
//    case put = "PUT"
    case get = "GET"
//    case delete = "DELETE"
//    case patch = "PATCH"
}

public enum RequestContentType {
    case json
    case urlEncoded
    case multipart
}

struct APIResource {
    /// Full URL string
    let urlString: String
    let method: RequestMethod
    let contentType: RequestContentType
    let parameter: [String: Any]?
    let customHeader: [String: String]?
    /// By default for every API response json will be parsed from root level. If we need to parse response from any child items we can specify here.
    let responseKeyPath: String?
    let formData: FormData?
//    /// If session gets expired, it will be handled in base level. If we require it in completion block, set this flag. Currently being used for touch/face ID login.
//    var shouldReturnSessionExpiry: Bool = false
    
    /**
     API Resource constructor.
     - parameter url: Complete URL string.
     - parameter method: request method of type RequestMethod. By default method will be .get
     - parameter parameters: request parameters. For get method this be passes as URL parameters, for post & put this will be passed as body paramaters. Default is nil.
     - parameter headers: Any specific headers required for the API. **No need to pass common headers.**.
     - parameter contentType: content type of type RequestContentType. This value will be set for the header field **Content-Type**. Default value is .urlEncoded
     - parameter formData: body parameters for multipart request.
     - parameter responseKey: Key path in the response json to be considered for parsing. By default response json will be parsed from root level.
     
     */
    init(URLString url: String, method: RequestMethod = .get,
         parameters: [String: Any]? = nil, headers: [String: String]? = nil,
         contentType: RequestContentType = .urlEncoded, responseKey: String? = nil, formData: FormData? = nil) {
        self.urlString = url
        self.method = method
        self.contentType = contentType
        self.parameter = parameters
        self.customHeader = headers
        self.responseKeyPath = responseKey
        self.formData = formData
    }
    
    /// Form data structure
    struct FormData {
        let data: Data?
        let keyName: String
        let fileName: String?
        let mimeType: String?
    }

}

public typealias JSONDictionary = [String: Any]

public struct APIResponse<Value> {
    let statusCode: Int?
    let data: Value?
    let message: String?
    let timeInterval: TimeInterval?
    let type: String?
    let responseHeaders: [AnyHashable: Any]?
    
    init(statusCode: Int?, data: Value?, responseHeaders: [AnyHashable: Any]? = nil, message: String?, timeInterval: TimeInterval?, type: String? = nil) {
        self.statusCode = statusCode
        self.data = data
        self.responseHeaders = responseHeaders
        self.message = message
        self.timeInterval = timeInterval
        self.type = type
    }
    

}

public enum APIError: Error {
    case noInternetConnection
    case invalidAccessToken
    case sessionExpired
    case invalidRequest
    case invalidResponse
    case parsingError
    case somethingWentWrong
    case needRetry
    case generalError(code: Int?, message: String?)
    case accountBlocked(message:String?)
    
    func localizedDescription() -> String {
        switch self {
        case .noInternetConnection:
            return "Sorry we are unable to connect to internet now. please check your network connection"
        case .invalidRequest:
            return "Problem with network request. please try later"
        case .parsingError:
            return "Unable to parse the server response. please try later"
        case .somethingWentWrong:
            return "Something went wrong. please try later"
        case .generalError(_, let message):
            return message ?? "Something went wrong. please try later"
        case .accountBlocked(let message):
            return message ?? "Something went wrong. please try later"
        default:
            return "Something went wrong. please try later"
        }
    }
    
    func localizedCode() -> Int {
        switch self {
        case .noInternetConnection:
            return 0
        case .invalidRequest:
            return 0
        case .parsingError:
            return 0
        case .somethingWentWrong:
            return 0
        case .generalError(let code, _):
            return code ?? 0
        case .accountBlocked( _):
            return 0
        default:
            return 0
        }
    }
    
}

public enum SSLError: Int {
    case secureConnectionFailed = -1200
    case certificateHasBadDate = -1201
    case certificateUntrusted = -1202
    case certificateWithUnkownRoot = -1203
    case cerificateNotYetValid = -1204
    case certificateRejected = -1205
    case certificateRequired = -1206
    case unableToLoadFromNetwork = -2000
}


public enum DataResult<D> {
    case success(APIResponse<D>)
    case failure(APIError)
    
    /// Gives the response if result is success. else returns nil
    public var response: APIResponse<D>? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
}

enum APIStatusCode: Int {
    case success = 200
    case invalidRequest = 501
    case invalidAccessToken = 401
    case sessionExpired = 3462
}

public typealias APICompletion<D: Decodable> = ((DataResult<D>) -> Void)

class NetworkManager {
    
    class func LoginUser(parameters: [String: Any]?, handler: (APICompletion<CODE>)? = nil) {
        postRequest(url: Server.shared.LoginUrl, parameters: parameters, handler: handler)
    }
    
    class func verifyOTP(parameters: [String: Any]?, handler: (APICompletion<VerifyModel>)? = nil) {
        postRequest(url: Server.shared.VerifyUrl, parameters: parameters, handler: handler)
    }

    class func updateProfile(parameters: [String: Any]?, handler: (APICompletion<AddressModel>)? = nil) {
        postRequest(url: Server.shared.UpdateProfile, parameters: parameters, handler: handler)
    
    
    }
  
    class func getHomeListing(parameters: [String: Any]?, handler: (APICompletion<HomeModel>)? = nil) {
        getRequest(url: Server.shared.HomeUrl
            , parameters: parameters, handler: handler)
    }
    
    class func getProfile(parameters: [String: Any]?, handler: (APICompletion<ProfileModel>)? = nil) {
        getRequest(url: Server.shared.ProfileUrl
            , parameters: parameters, handler: handler)
    }
    class func getCollectionListing(parameters: [String: Any]?, handler: (APICompletion<CollectionListModel>)? = nil) {
        getRequest(url: Server.shared.collectionUrl, parameters: parameters, handler: handler)
    }
    
    class func getCollectionEventListing(url: String, parameters: [String: Any]?, handler: (APICompletion<EventListModel>)? = nil) {
        getRequest(url: url, parameters: parameters, handler: handler)
    }
    
    class func getOrderDetails(url: String, parameters: [String: Any]?, handler: (APICompletion<OrderCheckoutModel>)? = nil) {
           getRequest(url: url, parameters: parameters, handler: handler)
       }
    
    class func getCollectionClubDetailListing(url: String, parameters: [String: Any]?, handler: (APICompletion<CollectionClubListModel>)? = nil) {
        getRequest(url: url, parameters: parameters, handler: handler)
    }
    
    class func getEventDetailListing(url: String, parameters: [String: Any]?, handler: (APICompletion<EventDetailsModal>)? = nil) {
        getRequest(url: url, parameters: parameters, handler: handler)
    }
    class func getCollectionDiningDetailListing(url: String, parameters: [String: Any]?, handler: (APICompletion<CollectionDiningListModel>)? = nil) {
        getRequest(url: url, parameters: parameters, handler: handler)
    }
    
    class func getCollectionPartiesDetailListing(url: String, parameters: [String: Any]?, handler: (APICompletion<CollectionPartiesListModel>)? = nil) {
        getRequest(url: url, parameters: parameters, handler: handler)
    }
    
    
    
    class func getOrderList(parameters: [String: Any]?, handler: (APICompletion<OrderlistModel>)? = nil) {
        getRequest(url: Server.shared.getOrderUrl
            , parameters: parameters, handler: handler)
    }
    
    
    
    class func getWalletBalace(parameters: [String: Any]?, handler: (APICompletion<WalletBalance>)? = nil) {
        getRequest(url: Server.shared.getWalletBalanceUrl
            , parameters: parameters, handler: handler)
    }
    
    class func getWalletHistory(parameters: [String: Any]?, handler: (APICompletion<WalletHistoryModel>)? = nil) {
        getRequest(url: Server.shared.getWalletHistoryUrl
            , parameters: parameters, handler: handler)
    }
    
    class func getAddMoney(parameters: [String: Any]?, handler: (APICompletion<AddMoneyModel>)? = nil) {
        getRequest(url: Server.shared.addMoneyUrl
            , parameters: parameters, handler: handler)
    }
    
    class func getNotification(parameters: [String: Any]?, handler: (APICompletion<[notificationModel]>)? = nil) {
        getRequest(url: Server.shared.NotificationUrl, parameters: parameters, handler: handler)
    }
    
    
    

//
//    class func ForgotPassword(parameters: [String: Any]?, handler: (APICompletion<registerUser>)? = nil) {
//        let param = addAdditinalData(parameters: parameters)
//        postRequest(url: Server.shared.ForgotUrl, parameters: param, handler: handler)
//    }
//
//    class func getHomePageListing(parameters: [String: Any]?, handler: (APICompletion<[HomeCategory]>)? = nil) {
//        let param = addAdditinalData(parameters: parameters)
//        postRequest(url: Server.shared.HomepageUrl, parameters: param, handler: handler)
//    }
//
//    class func getMobileListing(parameters: [String: Any]?, handler: (APICompletion<[homeAllMobile]>)? = nil) {
//        let param = addAdditinalData(parameters: parameters)
//        postRequest(url: Server.shared.MobileProductUrl, parameters: param, handler: handler)
//    }
//
//    class func getTabListing(parameters: [String: Any]?, handler: (APICompletion<[homeAllMobile]>)? = nil) {
//        let param = addAdditinalData(parameters: parameters)
//        postRequest(url: Server.shared.TabProductUrl, parameters: param, handler: handler)
//    }
//
//    class func getPriceBasedMobileListing(parameters: [String: Any]?, handler: (APICompletion<[homeAllMobile]>)? = nil) {
//        let param = addAdditinalData(parameters: parameters)
//        postRequest(url: Server.shared.PriceBasedUrl, parameters: param, handler: handler)
//    }
//
//    class func getProductImages(parameters: [String: Any]?, handler: (APICompletion<[ImageData]>)? = nil) {
//        let param = addAdditinalData(parameters: parameters)
//        postRequest(url: Server.shared.ProductImageUrl, parameters: param, handler: handler)
//    }
//
//    class func getProfile(parameters: [String: Any]?, handler: (APICompletion<UserProfile>)? = nil) {
//        let param = addAdditinalData(parameters: parameters)
//        postRequest(url: Server.shared.getProfileUrl, parameters: param, handler: handler)
//    }
//
//    class func updateProfile(parameters: [String: Any]?, image: UIImage, handler: (APICompletion<[ImageData]>)? = nil) {
//        let param = addAdditinalData(parameters: parameters)
//        multipartRequest(url: Server.shared.updateProfileUrl, image: image, parameters: param, handler: handler)
//    }
//
//    class func RepairRequire(parameters: [String: Any]?, handler: (APICompletion<[ImageData]>)? = nil) {
//        let param = addAdditinalData(parameters: parameters)
//        postRequest(url: Server.shared.updateProfileUrl, parameters: param, handler: handler)
//    }
//
//
//    class func resendOTP(parameters: [String: Any]?, handler: (APICompletion<[homeAllMobile]>)? = nil) {
//        postRequest(url: Server.shared.resendOTP, parameters: parameters, handler: handler)
//    }
//
//
//    class func addAdditinalData(parameters: [String: Any]? = nil) -> [String: Any]? {
//        var data = [String: Any]()
//        if var params = parameters {
//            params["key"] = "5642vcb546gfnbvb7r6ewc211365vhh34"
//            data = params
//        } else {
//            data["key"] = "5642vcb546gfnbvb7r6ewc211365vhh34"
//        }
//        return data
//    }
    
    class func postRequest<T: Decodable>(url: String?, parameters: [String: Any]? = nil, responseKey: String? = nil, handler: (APICompletion<T>)? = nil) {
        // print(url as Any)
        request(url: url, method: .post ,parameters: parameters, responseKey: responseKey, handler: handler)
    }
    
    class func getRequest<T: Decodable>(url: String?, parameters: [String: Any]? = nil, responseKey: String? = nil, handler: (APICompletion<T>)? = nil) {
        // print(url as Any)
        var output: String = ""
        if let param = parameters {
        for (key,value) in param {
            output +=  "\(key)=\(value)&"
        }
        }
        output = String(output.dropLast())
        
        var urlString = url
        if output.count>0 {
            urlString = urlString! + "?\(output)"
        }
        request(url: urlString, method: .get, parameters: parameters, responseKey: responseKey, handler: handler)
    }
    
    class func multipartRequest<T: Decodable>(url: String?,image: UIImage, parameters: [String: Any]? = nil, responseKey: String? = nil, handler: (APICompletion<T>)? = nil) {
        // print(url as Any)
        multiPartRequestCreation(url: url,image: image, contentType: .multipart, method: .post, parameters: parameters, responseKey: responseKey, handler: handler)
    }
    
    class func request<T: Decodable>(url: String?, contentType: RequestContentType = .json, method: RequestMethod, parameters: [String: Any]? = nil, responseKey: String? = nil, handler: (APICompletion<T>)? = nil) {
        guard let url = url else {
            handler?(DataResult.failure(APIError.invalidRequest))
            return
        }
//        if !NetworkSessionManager.shared.isServerReachable {
//            handler?(DataResult.failure(APIError.noInternetConnection))
//            return
//        }
        
//        let dataReq = DataResource<T>(loadFromServer: { (completion) -> DataRequestID in
            var responseKeyvalue = "data"
//            if let res = responseKey?.replacingFirstOccurrenceOfString(target: "data.", withString: "") {
//                responseKeyvalue += ".\(res)"
//            }
            var params = parameters
            var urlString = url
            if parameters != nil, method == .get {
                params?["_format"] = "json"
            } else {
                urlString = urlString.contains("?") ? (urlString + "&_format=json") : (urlString + "?_format=json")
            }
        
            let resource = APIResource(URLString: urlString, method: method, parameters: params, contentType: contentType, responseKey: responseKeyvalue)
            return Network(resource: resource).sendRequest(completion: handler)
    }
    
    
    class func multiPartRequestCreation<T: Decodable>(url: String?,image: UIImage? , contentType: RequestContentType = .json, method: RequestMethod, parameters: [String: Any]? = nil, responseKey: String? = nil, handler: (APICompletion<T>)? = nil) {
            guard let url = url else {
                handler?(DataResult.failure(APIError.invalidRequest))
                return
            }
    //        if !NetworkSessionManager.shared.isServerReachable {
    //            handler?(DataResult.failure(APIError.noInternetConnection))
    //            return
    //        }
            
    //        let dataReq = DataResource<T>(loadFromServer: { (completion) -> DataRequestID in
                var responseKeyvalue = "data"
    //            if let res = responseKey?.replacingFirstOccurrenceOfString(target: "data.", withString: "") {
    //                responseKeyvalue += ".\(res)"
    //            }
                var params = parameters
                var urlString = url
                if parameters != nil, method == .get {
                    params?["_format"] = "json"
                } else {
                    urlString = urlString.contains("?") ? (urlString + "&_format=json") : (urlString + "?_format=json")
                }
            
                let resource = APIResource(URLString: urlString, method: method, parameters: params, contentType: contentType, responseKey: responseKeyvalue)
                return Network(resource: resource).sendRequest(completion: handler)
        }
   
    
}
