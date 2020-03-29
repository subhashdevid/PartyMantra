//
//  CustomPickerViewController.swift
//  datePicker
//
//  Created by UTIITSL on 22/03/18.
//  Copyright © 2018 Vibhash. All rights reserved.
//

import UIKit
protocol PickerDelegate {
    func datePickerData(date: String,selectionTag:Int, sender : UIButton)
}

class CustomPickerViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var toolbar: UIToolbar!
    var isFutureDateEnabled : Bool = false
    var isFuturewithCurrentEnabled : Bool = false
    @IBOutlet weak var pickerView: UIView!
    var selectionTag = 0
    var senderPrev : UIButton?
    // var datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker(futureDateEnabled: isFutureDateEnabled, currentToFuture: isFuturewithCurrentEnabled)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func showDatePicker(futureDateEnabled:Bool,currentToFuture:Bool){
        //Formate Date
        let separatorLineView = UIView()
        
        separatorLineView.backgroundColor = UIColor.groupTableViewBackground
        pickerView.addSubview(separatorLineView)
        
        
        let date : Date = datePicker.date
        datePicker.datePickerMode = .date
        if currentToFuture == false{
            self.datePicker.minimumDate = date.minDate(isFutureDateEnabled: futureDateEnabled)
            self.datePicker.maximumDate = date.maxDate(isFutureDateEnabled: futureDateEnabled)
        }else{
            self.datePicker.minimumDate = date.minDate(isFuturewithCurrentDateEnabled: futureDateEnabled)
            self.datePicker.maximumDate = date.maxDate(isFutureDateEnabled: futureDateEnabled)
            
        }
        datePicker.setValue(UIColor.black, forKeyPath: "textColor")
        
        datePicker.layer.borderWidth = 1
        datePicker.layer.cornerRadius = 5
        pickerView.addSubview(datePicker)
        
        
        
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        
        
    }
    @objc func donedatePicker(){
        
        let date : Date = datePicker.date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let newDate = formatter.string(from: datePicker.date) //pass Date here
        
        sendData(sender: date.convertDateFormatter(date: newDate) as AnyObject)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    
    var delegate: PickerDelegate?
    
    @IBAction func sendData(sender: AnyObject) {
        
        if sender.text != ""{
            self.presentingViewController!.dismiss(animated: true, completion: nil)
           
            self.delegate?.datePickerData(date: sender as! String, selectionTag: selectionTag, sender: self.senderPrev!)}
    }
    
}
