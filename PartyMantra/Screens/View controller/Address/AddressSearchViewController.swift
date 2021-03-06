//
//  AddressSearchViewController.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 30/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

protocol AddressChangeDelegate: class {
    func returnChangedAddress(address: String, latitude: String, longitude: String)
}
class AddressSearchViewController: BaseViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var textfieldAddress: UITextField!
    @IBOutlet weak var tableviewSearch: UITableView!
    @IBOutlet weak var constraintSearchIconWidth: NSLayoutConstraint!
    @IBOutlet weak var constraintSearchViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var mapview: MKMapView!
    var profile : ProfileModel?

    var addressString : String?
    var addressLat : String?
    var addressLong : String?
    var selectOption : String?
    var mobileString : String?
    var autocompleteResults :[GApiResponse.Autocomplete] = []
    var locationManager: CLLocationManager!

    var post_screen : String?
    var post_title : String?
    weak var delegateAddress:AddressChangeDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    
        
        if self.post_screen == "home" {
            self.navigationController?.isNavigationBarHidden = false
            self.setUpTabBarAndNavigationTitle(tabBarHidden: true, navigationTitle: self.post_title)
        }else{
            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK:- CLLocationManager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
       {

           let location = locations.last! as CLLocation

           let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
           let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

           self.mapview.setRegion(region, animated: true)
       }
    
    //search button action
    @IBAction func searchButtonPressed(_ sender: Any) {
        textfieldAddress.becomeFirstResponder()
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
            if addressString?.count != 0 {
                self.updateAddress()
            }
            else{
            }
    }
    
    
    func updateAddress() {
        
        if (addressString?.isEmpty ?? false){
            self.showAlert("Please enter your address")
            return
        }else{
            
            UserDetails.shared.set_address(addressString ?? "")
            UserDetails.shared.set_address_lat(addressLat ?? "")
            UserDetails.shared.set_address_long(addressLong ?? "")
            UserDefaults.standard.synchronize()
            
        }
        
           let param: [String: Any] = [
            "address": addressString ?? "",
            "lat": addressLat!,
            "lang": addressLong!
           ]
        
        Loader.showHud()
        Multipart().saveDataUsingMultipart(mainView: self.view, urlString: Server.shared.UpdateAddress, parameter: param as? [String : String], handler: { (response, isSuccess) in
            Loader.dismissHud()
            if isSuccess{
                if self.post_screen == "home" {
                    self.delegateAddress?.returnChangedAddress(address: self.addressString ?? "", latitude: self.addressLat ?? "", longitude: self.addressLong ?? "")
                    self.navigationController?.popViewController(animated: true)
                }else{
                    self.fetchUserProfile()
                }
            }
        })
    }
    
    func fetchUserProfile() {
            let accessUserToken =  UserDefaults.standard.string(forKey: "AccessToken")
            let param: [String: Any] = [
                "token":accessUserToken ?? ""
            ]
            Loader.showHud()
            NetworkManager.getProfile(parameters: param) {[weak self] result in
                Loader.dismissHud()
                switch result {
                case let .success(response):
                    if let userProfile = response.data {
                        self?.profile = userProfile
                        
                        let vc = MyProfileUpdateViewController.instantiate(appStoryboard: .home) as MyProfileUpdateViewController
                        vc.profile = self?.profile
                        vc.screen = "My Profile"
                        self?.navigationController?.pushViewController(vc, animated: true)
                       
                    }
                    
                case .failure: break
                }
            }
        }
    
    
    
    
    
    func showResults(string:String){
        var input = GInput()
        input.keyword = string
        GoogleApi.shared.callApi(input: input) { (response) in
            if response.isValidFor(.autocomplete) {
                DispatchQueue.main.async {
                    self.searchView.isHidden = false
                    self.autocompleteResults = response.data as! [GApiResponse.Autocomplete]
                    self.tableviewSearch.reloadData()
                }
            } else { print(response.error ?? "ERROR") }
        }
    }
    func hideResults(){
//        searchView.isHidden = true
        autocompleteResults.removeAll()
        tableviewSearch.reloadData()
    }
}

//MARK:- UITextFieldDelegate delegate
extension AddressSearchViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        hideResults() ;
        tableviewSearch.reloadData()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text! as NSString
        let fullText = text.replacingCharacters(in: range, with: string)
//        if fullText.count > 2 {
            showResults(string:fullText)
//        }else{
//            hideResults()
//        }
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if self.post_screen == "home" {
            constraintSearchViewTop.constant = -( UIScreen.main.bounds.size.height/2 - 80)
                   constraintSearchIconWidth.constant = 38.0
        }
        else{
            constraintSearchViewTop.constant = -( UIScreen.main.bounds.size.height/2 - 40)
                   constraintSearchIconWidth.constant = 38.0
        }
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        constraintSearchIconWidth.constant = 38.0 ; return true
    }
}


//MARK:- MKMapViewDelegate delegate
extension AddressSearchViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        var input = GInput()
        let destination = GLocation.init(latitude: mapview.region.center.latitude, longitude: mapview.region.center.longitude)
        input.destinationCoordinate = destination
        self.addressLat = "\(destination.latitude ?? 0.0)"
        self.addressLong = "\(destination.longitude ?? 0.0)"
        GoogleApi.shared.callApi(.reverseGeo , input: input) { (response) in
            if let places = response.data as? [GApiResponse.ReverseGio], response.isValidFor(.reverseGeo) {
                DispatchQueue.main.async {
                    
                    if self.selectOption == "auto" {
                        self.textfieldAddress.text = places.first?.formattedAddress
                        self.addressString = self.textfieldAddress.text ?? ""
                    }
                }
            } else { print(response.error ?? "ERROR") }
        }
    }
}


//MARK:- TableView delegate
extension AddressSearchViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autocompleteResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell")
        let label = cell?.viewWithTag(1) as! UILabel
        label.text = autocompleteResults[indexPath.row].formattedAddress
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textfieldAddress.text = autocompleteResults[indexPath.row].formattedAddress
        constraintSearchViewTop.constant = 80
        textfieldAddress.resignFirstResponder()
        addressString = textfieldAddress.text ?? ""
        
        var input = GInput()
        input.keyword = autocompleteResults[indexPath.row].placeId
        GoogleApi.shared.callApi(.placeInformation,input: input) { (response) in
            if let place =  response.data as? GApiResponse.PlaceInfo, response.isValidFor(.placeInformation) {
                DispatchQueue.main.async {
                    self.searchView.isHidden = false
                    self.hideResults()
                    
                    if let lat = place.latitude, let lng = place.longitude{
                        let center  = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                        self.mapview.setRegion(region, animated: true)
                    }
                    self.tableviewSearch.reloadData()
                }
            } else { print(response.error ?? "ERROR") }
        }
    }
}
