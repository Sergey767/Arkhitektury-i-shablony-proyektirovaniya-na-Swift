//
//  NetworkServiceAdapter.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 06.01.2021.
//  Copyright © 2021 appleS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit

class NetworkServiceAdapter {
    
    private let baseUrl = "https://api.vk.com"
    private let versionAPI = "5.102"
    
    static let session: Session = {
        let configuration = URLSessionConfiguration.default
        let session = Session(configuration: configuration)
        return session
    }()
    
    func getPromiseFriends(token: String) -> Promise<[User]> {
        let path = "/method/friends.get"

        let params: Parameters = [
            "access_token": Singleton.instance.token,
            "fields": "nickname, photo_50, photo_100, photo_200_orig",
            "v": versionAPI
        ]

        return Promise { resolver in
            NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let friendJSONs = json["response"]["items"].arrayValue

                    let friends = friendJSONs.map { User($0, token: token) }
                    resolver.fulfill(friends)

                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    func loadGroups(token: String, completion: @escaping ([Group]) -> Void) {

        let path = "/method/groups.get"

        let params: Parameters = [
            "access_token": Singleton.instance.token,
            "extended": 1,
            "v": versionAPI
        ]

        ParseData.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let groupJSONs = json["response"]["items"].arrayValue
                let groups = groupJSONs.map { Group($0, token: token) }
                completion(groups)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func fetchPhotos(for userId: Int, completion: @escaping ([Photo]) -> Void) {
        let path = "/method/photos.getAll"

        let params: Parameters = [
            "access_token": Singleton.instance.token,
            "owner_id": String(userId),
            "extended": 1,
            "count": 100,
            "v": versionAPI
        ]

        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON {
            response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let photoJSONs = json["response"]["items"].arrayValue
                let photos = photoJSONs.map { Photo($0, userId: userId) }
                completion(photos)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func loadSearchGroups(searchQuery: String, completion: @escaping ([SearchGroup]) -> Void) {
        let path = "/method/groups.search"

        let params: Parameters = [
            "access_token": Singleton.instance.token,
            "q": searchQuery,
            "v": versionAPI
        ]

        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let searchGroupsJSONs = json["response"]["items"].arrayValue
                let searchGroups = searchGroupsJSONs.map { SearchGroup($0, searchQuery: searchQuery) }
                completion(searchGroups)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
}


