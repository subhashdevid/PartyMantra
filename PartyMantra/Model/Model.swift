//  Model.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 19/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import Foundation

struct VerifyModel: Codable {
    let message: String?
    let token: String?
    let type: String?
}

struct notificationModel : Codable {
    let id: Int?
    let title: String?
    let description: String?
    let image: String?
    let user_id: Int?
    let receiver_type: String?
    let created_at: String?
    let deleted_at: String?
    let updated_at: String?
    let is_sent: Int?
    let date: String?
}

struct orderModel : Codable {
    let id: Int?
    let refid: String?
    let updated_at: String?
    let total: Int?
    let payment_status: String?
    let entry_marked: Int?
    let order_id: String?
    let payment_id: String?
    let email: String?
    let mobile: String?
    let date: String?
    let time: String?
    let name: String?
    let men: Int?
    let women: Int?
    let couple: Int?
    let fromwallet: Int?
    let usingwallet: Int?
    let instant_discount: Int?
    let discount_type: String?
    let cashback_discount: Int?
    let order_date: String?
    
    let title: String?
    let ordertype: String?
    let image: String?
}

struct orderDetailModel : Codable {
    let id: Int?
    let order_id: Int?
    let entity_type: String?
    let entity_id: Int?
    let optional_type: String?
    let other_type: String?
    let other_id: Int?
    let partner_id: Int?
    let men: Int?
    let women: Int?
    let couple:Int?
    let created_at: String?
    let updated_at: String?
    let deleted_at: String?
    let no_of_pass: Int?
    let price: Int?
}

struct orderEntityModel : Codable {
    let id: Int?
    let name: String?
    let description: String
    let address: String?
    let short_address: String?
    let lat: Int?
    let lang: Int?
    let contact_no: String?
    let header_image: String?
    let small_image: String?
    let type: String?
    let per_person_text: String?
    let isactive: Int?
    let open: String
    let close: String?
    let allow_party: Int?
    let priority: Int?
    let timings: String?
    let party_timings: String?
    let tnc: String?
    let discounts: String
    let away: Int
}

struct WalletBalance: Codable {
    let balance: Int?
}

struct WalletHistoryModel: Codable {
    let history: [WalletHistory]?
    let balance: Int?
}

struct WalletHistory: Codable {
    let id: Int?
    let user_id: Int?
    let refid: String?
    let type: String?
    let amount: Int?
    let description: String?
    let order_id: String?
    //    let order_id_response: String?
    let payment_id: String?
    //    let payment_id_response: String?
    let icon: String?
    let date: String?
}

struct HomeModel: Codable {
    let banners: [HomeBanners]?
    let collections: [HomeCollection]?
    let others: [HomeOthers]?
    let nearby: [NearByPlace]?
    //    let otherbanners: [OtherBanners]?
}

struct HomeBanners: Codable {
    let id: Int?
    let image: String?
    let entity_type: String?
    let entity_id: Int?
    let isactive: Int?
    let priority: Int?
    let placeholder: Int?
}

struct HomeCollection: Codable {
    let id: Int?
    let name: String?
    let cover_image: String?
    let small_image: String?
    let istop: Int?
    let about: String?
    let type: String?
}
struct NearByPlace: Codable {
//    let id: Int?
//    let name: String?
//    let cover_image: String?
//    let small_image: String?
//    let istop: Int?
//    let about: String?
//    let type: String?
//    let event: [eventModel]?
    
    let id: Int?
       let creator_id: Int?
       let title: String?
       let startdate: String?
       let enddate: String?
       let description: String?
       let venue_name: String?
       let venue_adderss: String?
       let lat: String?
       let lang: String?
       let header_image: String?
       let small_image: String?
       let tnc: String?
       let priority: Int?
       let rating: Int?
       let per_person_text: String?
       let time_to_start: String?
       let away: Int?
       let avgreviews: [avgreviewsModel]?
    
}
struct HomeOthers: Codable {
    let id: Int?
    let name: String?
    let cover_image: String?
    let small_image: String?
    let istop: Int?
    let about: String?
    let type: String?
    
    let event: [eventModel]?
    let banners: [HomeBanners]?
    
    let restaurant: [restaurantModel]?
    let party: [PartyModel]?
}

struct eventModel: Codable {
    let id: Int?
    let creator_id: Int?
    let title: String?
    let startdate: String?
    let enddate: String?
    let description: String?
    let venue_name: String?
    let venue_adderss: String?
    let lat: String?
    let lang: String?
    let header_image: String?
    let small_image: String?
    let tnc: String?
    let priority: Int?
    let rating: Int?
    let per_person_text: String?
    let time_to_start: String?
    let away: Int?
    let avgreviews: [avgreviewsModel]?
    
}


struct avgreviewsModel: Codable {
    let rating: String?
    let reviews: Int?
}



struct restaurantModel: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let address: String?
    let short_address: String?
    let lat: Double?
    let lang: Double?
    let contact_no: String?
    let header_image: String?
    let small_image: String?
    let type: String?
    let per_person_text: String?
    let isactive: Int?
    let open: String?
    let close: String?
    let allow_party: Int?
    let priority: Int?
    let timings: String?
    let party_timings: String?
    let tnc: String?
    let raing: Int?
    let discounts: String?
    let away:Int?
    //        "pivot": {
    //            "collection_id": 31,
    //            "restaurant_id": 8
    //        },
    let avgreviews: [avgreviewsModel]?
    
}

struct PartyModel: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let address: String?
    let short_address: String?
    let lat: Double?
    let lang: Double?
    let contact_no: String?
    let header_image: String?
    let small_image: String?
    let type: String?
    let per_person_text: String?
    let isactive: Int?
    let open: String?
    let close: String?
    let allow_party: Int?
    let priority: Int?
    let timings: String?
    let party_timings: String?
    let tnc: String?
    let raing: Int?
    let discounts: String?
    let away:Int?
    let avgreviews: [avgreviewsModel]?
    
    //        "pivot": {
    //            "collection_id": 31,
    //            "restaurant_id": 8
    //        },
    //        "avgreviews": []
}

struct CollectionListModel: Codable {
    let collections: [HomeCollection]?
}


struct CollectionClubListModel: Codable {
    let image: String?
    let events: [eventModel]?
}

struct CollectionDiningListModel: Codable {
    let image: String?
    let events: [restaurantModel]?
}

struct CollectionPartiesListModel: Codable {
    let image: String?
    let events: [PartyModel]?
}

struct ProfileModel: Codable {
    var name: String?
    var dob: String?
    var email: String?
    var mobile: String?
    var address: String?
    var gender: String?
    let image: String?


}





