//
//  Multipart.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 30/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import Foundation
import Alamofire
import MBProgressHUD


class Multipart{
   
   
    let accessUserToken : String =  UserDefaults.standard.string(forKey: "AccessToken") ?? ""

    func saveDataUsingMultipart(mainView : UIView,urlString : String,parameter:[String:String]! ,handler:@escaping((Any,Bool)-> Void)) -> Void {
        
        let baseurl = "\(urlString)"
        let headers : HTTPHeaders =
            ["Authorization" : "Bearer \(accessUserToken)"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            //        if let imageData = image!.jpegData(compressionQuality: 0.2) {
            //            let random = arc4random()
            //            multipartFormData.append(imageData, withName: "file", fileName: "file\(random).png", mimeType: "image/png")
            //        }
            for (key, value) in parameter {
                multipartFormData.append(value.data(using: String.Encoding.utf8)! , withName: key)
            }
        }, to:baseurl,
           method:.post,
           headers: headers,
           encodingCompletion: { encodingResult in
            
            switch encodingResult {
            case .success(let upload, _, _):
                // progress bar
                
                upload.uploadProgress(closure: { (progress) in
                    
                    //                self.hud.progress = Float(progress.fractionCompleted)
                    //                self.hud.label.text = "Completed(\(Int((progress.fractionCompleted)*100))%)"
                    //                  //  print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.response { response in
                    debugPrint(response)
                    
                    do {
                        let responseObject = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        let responceDic = responseObject as! NSDictionary
                        
                        handler(responceDic,true)
                        
                    } catch let error as NSError {
                        print("error: \(error.localizedDescription)")
                    }
                }
            case .failure(let encodingError):
                //progress bar
                
                print(encodingError)
            }
        })
    }
    
    
    func UploadImageUsingMultipart(mainView : UIView,urlString : String, image:UIImage,handler:@escaping((Any,Bool)-> Void)) -> Void {
        
        let baseurl = "\(urlString)"
        let headers : HTTPHeaders =
            ["Authorization" : "Bearer \(accessUserToken)"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let imageData = image.jpegData(compressionQuality: 0.2) {
                        let random = arc4random()
                        multipartFormData.append(imageData, withName: "file", fileName: "PsrtyMatra\(random).png", mimeType: "image/png")
            }
//            for (key, value) in parameter {
//                multipartFormData.append(value.data(using: String.Encoding.utf8)! , withName: key)
//            }
        }, to:baseurl,
           method:.post,
           headers: headers,
           encodingCompletion: { encodingResult in
            
            switch encodingResult {
            case .success(let upload, _, _):
                // progress bar
                
                upload.uploadProgress(closure: { (progress) in
                    
//                self.hud.progress = Float(progress.fractionCompleted)
//                self.hud.label.text = "Completed(\(Int((progress.fractionCompleted)*100))%)"
//                //  print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.response { response in
                    debugPrint(response)
                    
                    do {
                        let responseObject = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        let responceDic = responseObject as! NSDictionary
                        
                        handler(responceDic,true)
                        
                    } catch let error as NSError {
                        print("error: \(error.localizedDescription)")
                    }
                }
            case .failure(let encodingError):
                //progress bar
                
                print(encodingError)
            }
        })
    }
    
    
    
    //image array
    
    
    func uploadDocImageArray(mainView : UIView,urlString : String,parameter:[String:String]!,imageArray:Array<UIImage>,imageTitleArray:Array<String>, handler:@escaping((Any,Bool)-> Void)) -> Void {

         let baseurl = "\(mainUrl)\(urlString)"

        
       
        Alamofire.upload(multipartFormData: { multipartFormData in

            for index in 0...imageArray.count-1 {
                let image = imageArray[index]
                let key = imageTitleArray[index]
                
                if let imageData = image.jpegData(compressionQuality: 0.2) {
                    let random = arc4random()
                    multipartFormData.append(imageData, withName: key, fileName: "file\(random).png", mimeType: "image/png")
                }
            }


            for (key, value) in parameter {
                multipartFormData.append(value.data(using: String.Encoding.utf8)! , withName: key)
            }

        }, to:baseurl,
           method:.post,
           headers: nil,
           encodingCompletion: { encodingResult in

            switch encodingResult {
            case .success(let upload, _, _):
                // progress bar

                upload.uploadProgress(closure: { (progress) in

//                    self.hud.progress = Float(progress.fractionCompleted)
//                    self.hud.label.text = "Completed(\(Int((progress.fractionCompleted)*100))%)"
                    //  print("Upload Progress: \(progress.fractionCompleted)")
                })

                upload.response { response in
                    debugPrint(response)
                    let responseString:String = String(bytes: response.data!, encoding: String.Encoding.utf8)!

                    do {
                        let responseObject = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)

                        let responceDic = responseObject as! NSDictionary

                        handler(responceDic,true)
                       
                          Utility().showSimpleAlert("Image Upload", "\(responceDic["message"] as? String ?? "")")
                        
                      
                    } catch let error as NSError {
                        print("error: \(error.localizedDescription)")
                    }
                }
            case .failure(let encodingError):
                //progress bar
                print(encodingError)
            }
        })
    }
    
    
    
    
}

