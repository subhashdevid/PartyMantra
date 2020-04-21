//
//  PaymentViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 30/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Razorpay

class PaymentViewController: UIViewController {
    
    var razorpayObj: RazorpayCheckout!
    let defaultHeight : CGFloat = 40
    let defaultWidth : CGFloat = 120
    let razorpayKey = "rzp_test_zAvfify4pZWTAH"
    
    var orderId : String?
    var prev_screen : String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addMoneyToPay( amount : String, payOrderid :String, screen : String?)  {
        let pay_amount = Int(amount)
        orderId = payOrderid
        prev_screen = screen
        self.openRazorpayCheckout(amount: pay_amount)
    }
    

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
        
        func setupCheckoutButton() {
            let buyButton = UIButton(type: .custom)
            buyButton.setTitle("Checkout", for: .normal)
            buyButton.setTitleColor(.blue, for: .normal)
            self.view.addSubview(buyButton)
            buyButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                buyButton.heightAnchor.constraint(equalToConstant: self.defaultHeight),
                buyButton.widthAnchor.constraint(equalToConstant: self.defaultWidth),
                buyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
                buyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            buyButton.addTarget(self, action: #selector(openCheckoutAction(_:)), for: .touchUpInside)
        }
        
    @IBAction func openCheckoutAction(_ sender: UIButton) {
//        self.openRazorpayCheckout(amount:amount)
        }
        
    public func openRazorpayCheckout(amount: Int?) {
            // 1. Initialize razorpay object with provided key. Also depending on your requirement you can assign delegate to self. It can be one of the protocol from RazorpayPaymentCompletionProtocolWithData, RazorpayPaymentCompletionProtocol.
//            razorpayObj = Razorpay.initWithKey(razorpayKey, andDelegate: self)
            razorpayObj = RazorpayCheckout.initWithKey(razorpayKey, andDelegate: self)

        
            let options: [AnyHashable:Any] = [
                "prefill": [
                    "contact": "1234567890",
                    "email": "a@a.com"
                    //                "method":"wallet",
                    //                "wallet":"amazonpay"
                ],
                "image": "http://www.freepngimg.com/download/light/2-2-light-free-download-png.png",
                "amount" : amount!,
                "timeout":1000,
                "theme": [
                    "color": "#F37254"
                ]//            "order_id": "order_B2i2MSq6STNKZV"
                // and all other options
            ]
            if let rzp = self.razorpayObj {
                rzp.open(options)
            } else {
                print("Unable to initialize")
            }
        }
    }

    // RazorpayPaymentCompletionProtocol - This will execute two methods 1.Error and 2. Success case. On payment failure you will get a code and description. In payment success you will get the payment id.
    extension PaymentViewController : RazorpayPaymentCompletionProtocol {
        
        func onPaymentError(_ code: Int32, description str: String) {
            print("error: ", code, str)
            self.presentAlert(withTitle: "Alert", message: str)
        }
        
        func onPaymentSuccess(_ payment_id: String) {
            print("success: ", payment_id)
            self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
            
            if prev_screen == "wallet"{
                self.verifyWalletMoneyToServer(razorpay_payment_id: payment_id, razorpay_order_id: self.orderId ?? "" )
            }
            else   if prev_screen == "cart"{
            self.verifyCartMoneyToServer(razorpay_payment_id: payment_id, razorpay_order_id: self.orderId ?? "" )

            }
            else   if prev_screen == "paytpm"{
            self.verifyPayTPMMoneyToServer(razorpay_payment_id: payment_id, razorpay_order_id: self.orderId ?? "" )

            }
            
            
        }
        
        
        
        func verifyWalletMoneyToServer( razorpay_payment_id : String?, razorpay_order_id : String)  {
                   
            let param: [String: String] = [
                "razorpay_payment_id" : razorpay_payment_id ?? "",
                "razorpay_order_id" : razorpay_order_id,
                "Razorpay_signature" : "PartyMantra"
            ]

            Multipart().saveDataUsingMultipart(mainView: self.view, urlString: Server.shared.verifyMoneyUrl, parameter: param, handler: { (response, isSuccess) in

                if isSuccess{
                   let response = response as! Dictionary<String,Any>
                    print(response)
                    NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
                }
            })
        }
        
        
        
        func verifyCartMoneyToServer( razorpay_payment_id : String?, razorpay_order_id : String)  {
                   let param: [String: String] = [
                       "razorpay_payment_id" : razorpay_payment_id ?? "",
                       "razorpay_order_id" : razorpay_order_id,
                       "Razorpay_signature" : "PartyMantra"
                   ]

                   Multipart().saveDataUsingMultipart(mainView: self.view, urlString: Server.shared.verifyCartMoneyUrl, parameter: param , handler: { (response, isSuccess) in

                       if isSuccess{
                          let response = response as! Dictionary<String,Any>
                           print(response)
                           NotificationCenter.default.post(name: Notification.Name("CartNotificationIdentifier"), object: nil)
                       }
                   })
               }
        
        func verifyPayTPMMoneyToServer( razorpay_payment_id : String?, razorpay_order_id : String)  {
                   let param: [String: String] = [
                       "razorpay_payment_id" : razorpay_payment_id ?? "",
                       "razorpay_order_id" : razorpay_order_id,
                       "Razorpay_signature" : "PartyMantra"
                   ]

                   Multipart().saveDataUsingMultipart(mainView: self.view, urlString: Server.shared.verifyBillMoneyUrl, parameter: param , handler: { (response, isSuccess) in

                       if isSuccess{
                          let response = response as! Dictionary<String,Any>
                           print(response)
                           NotificationCenter.default.post(name: Notification.Name("PayTPMNotificationIdentifier"), object: nil)
                       }
                   })
               }
        
    }

    // RazorpayPaymentCompletionProtocolWithData - This will returns you the data in both error and success case. On payment failure you will get a code and description. In payment success you will get the payment id.
    extension PaymentViewController: RazorpayPaymentCompletionProtocolWithData {
        
        func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
            print("error: ", code)
            self.presentAlert(withTitle: "Alert", message: str)
        }
        
        func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
            print("success: ", payment_id)
            self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
        }
    }


extension PaymentViewController {
    func presentAlert(withTitle title: String?, message : String?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Okay", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
 
