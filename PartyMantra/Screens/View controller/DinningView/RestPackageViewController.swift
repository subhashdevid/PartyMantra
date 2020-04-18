//
//  RestPackageViewController.swift
//  PartyMantra
//
//  Created by Vibhash Kumar on 15/04/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class RestPackageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, GetRestComboHeightOfProtocol {
   
    
    @IBOutlet weak var okeyBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    var restModal : RestaurantInfoModel?
    var heightindex = 0
    var heightOfCell = 0

    @IBOutlet weak var restPackageTblVw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        closeBtn.addTarget(self, action: #selector(dismissPopUpView), for: .touchUpInside)
        okeyBtn.addTarget(self, action: #selector(submitPopUpView), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissPopUpView(){
        
        for item in (self.restModal?.packages ?? []) {
          let itemModal = item as EventPackagesDetailModal
            itemModal.packageCount = 0
         }
        
        self.dismiss(animated: true, completion: nil)
    }
    @objc func submitPopUpView(){
        
        self.restModal?.packages
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getComboHeightFromArr(height: Int, restCellHeight: Int, isViewMoreBtnClicked: Bool, indexInt: Int) {
        self.heightindex = indexInt
        if (self.restModal?.packages ?? []).count>0{
            let cellModal = (self.restModal?.packages ?? []) as [EventPackagesDetailModal]
            if isViewMoreBtnClicked {
                self.heightOfCell = Int(125+height)
                print(self.heightOfCell)
                self.restPackageTblVw.reloadData()
            }else{
                self.heightOfCell = Int(((cellModal.count)*(140))+40)
                self.restPackageTblVw.reloadData()
            }
        }
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              var cell: RestPackagesTableViewCell! = restPackageTblVw.dequeueReusableCell(withIdentifier: "RestPackagesTableViewCell") as? RestPackagesTableViewCell
               if cell == nil {
                   restPackageTblVw.register(UINib(nibName: "RestPackagesTableViewCell", bundle: nil), forCellReuseIdentifier: "RestPackagesTableViewCell")
                   cell = restPackageTblVw.dequeueReusableCell(withIdentifier: "RestPackagesTableViewCell") as? RestPackagesTableViewCell
               }
             cell.comboDelegate = self
             cell.backgroundColor = .groupTableViewBackground
        if (self.restModal?.packages ?? []).count > 0 {
            let cellModal = (self.restModal?.packages ?? [])
                   print(cellModal)
                   cell.configureRestPackageCell(modal:self.restModal)
               }
              return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
            if (self.restModal?.packages ?? []).count > 0 {
                
                           if (self.restModal?.packages ?? []).count > 0 && self.heightOfCell>0 && self.heightindex == indexPath.row{
                               print(self.heightOfCell)
                               return CGFloat(self.heightOfCell)
                               
                           }else if (self.restModal?.packages ?? []).count > 0 && self.heightOfCell>0 && self.heightindex == 1{
                               print(self.heightOfCell)
                                              return CGFloat(self.heightOfCell)
                           }else{
                               if (self.restModal?.packages ?? []).count > 0{
                               let cellModal = (self.restModal?.packages ?? []) as [EventPackagesDetailModal]
                               let height = Int(((cellModal.count)*(140))+40)
                                  
                                   return CGFloat(height)
                               }
                           }
            }else{
                return 0
            }
       
        return 0
    }

}
