//
//  EventSearchViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 22/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class EventSearchViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    var searchedString : String?
    var eventData : [EventlistModel] = []

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.tableFooterView = UIView()
        self.tblView.backgroundColor  = .groupTableViewBackground
        
        self.fetchSearchedEventDetail()
        
    }
        
    func fetchSearchedEventDetail() {
        Loader.showHud()
        var request = URLRequest(url: URL(string: "\(Server.shared.searchUrl)?search=\(searchedString ?? "")")!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                Loader.dismissHud()
                guard let responseData = data else {
                  print("Error: did not receive data")
                  return
                }
                guard let dataArray = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? Array<Dictionary<String, Any>> else {
                        print("error trying to convert data to JSON")
                        return
                }
                print(dataArray)
                
                for dict in dataArray {
                    let model = EventlistModel(response: dict)
                    self.eventData.append(model)
                }
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
                
            } catch {
                Loader.dismissHud()
                print("JSON Serialization error")
            }
        }).resume()
    }
}



extension EventSearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.eventData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "custom") as? CustomTableViewCell
        let model = self.eventData[indexPath.row]
        cell?.titleLbl.text = model.title
        cell?.subtitleLbl.text = model.venue_name
        cell?.addressLbl.text = model.venue_adderss
        cell?.priceLbl.text = model.per_person_text
        cell?.dateLbl.text = model.startdate
        
        let url = URL(string: model.small_image ?? "")
        cell?.bannerimgView.contentMode = .scaleAspectFill
        cell?.bannerimgView.kf.setImage(with: url, placeholder: nil)
        
        return cell!
    }
}
