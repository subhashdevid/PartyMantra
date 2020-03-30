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
        
        hud.show(animated: true)
        hud.mode = MBProgressHUDMode.annularDeterminate
        self.hud.label.text = "Loading"
        
        mainView.addSubview(hud)
        
        let headers : HTTPHeaders =
            ["Authorization" : "Bearer \(accessUserToken)"]
        
        
        
//        let accessUserToken =  UserDefaults.standard.string(forKey: "AccessToken")
//        request.setValue("Bearer \(accessUserToken ?? "")", forHTTPHeaderField: "Authorization")
//

        
        
        
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
               
                self.hud.progress = Float(progress.fractionCompleted)
                self.hud.label.text = "Completed(\(Int((progress.fractionCompleted)*100))%)"
                  //  print("Upload Progress: \(progress.fractionCompleted)")
            })
                
            upload.response { response in
                debugPrint(response)
              //  let responseString:String = String(bytes: response.data!, encoding: String.Encoding.utf8)!
                
                do {
                    let responseObject = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    let responceDic = responseObject as! NSDictionary
                    
                    
                    //    let link = responceDic["data"] as? String ?? ""
                    self.hud.hide(animated: true)
                        handler(responceDic,true)
                        
                    Utility().showSimpleAlert("Alert", "\(responceDic["message"] as? String ?? "")")
                   
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                    self.hud.hide(animated: true)
                    
                } catch let error as NSError {
                    print("error: \(error.localizedDescription)")
                }
            }
            case .failure(let encodingError):
            //progress bar
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.hud.hide(animated: true)
                }
                print(encodingError)
            }
        })
    }
    
    
    //image array
    
    
    func uploadDocImageArray(mainView : UIView,urlString : String,parameter:[String:String]!,imageArray:Array<UIImage>,imageTitleArray:Array<String>, handler:@escaping((Any,Bool)-> Void)) -> Void {

         let baseurl = "\(mainUrl)\(urlString)"

        
        hud.show(animated: true)
        hud.mode = MBProgressHUDMode.annularDeterminate
        self.hud.label.text = "Loading"
        mainView.addSubview(hud)
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

                    self.hud.progress = Float(progress.fractionCompleted)
                    self.hud.label.text = "Completed(\(Int((progress.fractionCompleted)*100))%)"
                    //  print("Upload Progress: \(progress.fractionCompleted)")
                })

                upload.response { response in
                    debugPrint(response)
                    let responseString:String = String(bytes: response.data!, encoding: String.Encoding.utf8)!

                    do {
                        let responseObject = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)

                        let responceDic = responseObject as! NSDictionary


                        //    let link = responceDic["data"] as? String ?? ""
                        self.hud.hide(animated: true)
                        handler(responceDic,true)
                       
                          Utility().showSimpleAlert("Image Upload", "\(responceDic["message"] as? String ?? "")")
                        
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                        self.hud.hide(animated: true)

                    } catch let error as NSError {
                        print("error: \(error.localizedDescription)")
                    }
                }
            case .failure(let encodingError):
                //progress bar
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.hud.hide(animated: true)
                }
                print(encodingError)
            }
        })
    }
    
    
    
    
}

