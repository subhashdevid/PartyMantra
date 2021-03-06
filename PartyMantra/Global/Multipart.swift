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
   
    var hud: MBProgressHUD = MBProgressHUD()
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
    
    
    func formDataAPICall(mainView : UIView,urlString : String,parameter:[String:Any]! ,handler:@escaping((Any,Bool)-> Void)) -> Void {
        
        let baseurl = "\(urlString)"
        let headers : HTTPHeaders =
            ["Authorization" : "Bearer \(accessUserToken)"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in parameter {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value  as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
            }
        }, to:baseurl,
           method:.post,
           headers: headers,
           encodingCompletion: { encodingResult in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
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
                print(encodingError)
            }
        })
    }

    func UploadImageUsingMultipart(mainView : UIView,urlString : String, image:UIImage,handler:@escaping((Any,Bool)-> Void)) -> Void {
        
        hud.show(animated: true)
        hud.mode = MBProgressHUDMode.annularDeterminate
        self.hud.label.text = "Loading"
        mainView.addSubview(hud)
        
        
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
                    
                    self.hud.progress = Float(progress.fractionCompleted)
                    self.hud.label.text = "Completed(\(Int((progress.fractionCompleted)*100))%)"
                    //  print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.response { response in
                    debugPrint(response)
                   self.hud.hide(animated: true)
                    do {
                        let responseObject = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        let responceDic = responseObject as! NSDictionary
                        if (responceDic["status"] as? Int ?? 0) == 200{
                            handler(responceDic,true)
                            Utility().AddAlert("Image Upload", "\(responceDic["message"] as? String ?? "")")
                          
                            DispatchQueue.main.async {
                                self.hud.hide(animated: true)
                            }
                        }else{
                           
                            Utility().AddAlert("Image Upload", "\(responceDic["message"] as? String ?? "")")
                            
                            handler(responceDic,false)
                        }
                    } catch let error as NSError {
                        print("error: \(error.localizedDescription)")
                    }
                }
            case .failure(let encodingError):
                //progress bar
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    
                }
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
                       
                         Utility().AddAlert("Image Upload", "\(responceDic["message"] as? String ?? "")")
                        
                      
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

