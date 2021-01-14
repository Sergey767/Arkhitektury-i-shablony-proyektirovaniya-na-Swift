//
//  NetworkService.swift
//  Vkontakte
//
//  Created by Сергей on 08.11.2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

protocol VkApiFriendsDelegate {
    
    func returnFriends(_ friends: [User])
}

protocol VkApiPhotosDelegate {
    
    func returnPhotos(_ photos: [Photo])
}

protocol VkApiSearchGroupsDelegate {
    
    func returnSearchGroups(_ searchGroups: [SearchGroup])
}

//protocol VkApiNewsDelegate {
//
//    func returnNews(_ news: [VKNews])
//}
//
//protocol VkApiPartNewsDelegate {
//
//    func returnPartNews(_ news: [VKNews])
//}

class NetworkService {
    
    private let baseUrl = "https://api.vk.com"
    private let versionAPI = "5.102"
    
    static let session: Session = {
        let configuration = URLSessionConfiguration.default
        let session = Session(configuration: configuration)
        return session
    }()
    
    func loadFriends(token: String, delegate: VkApiFriendsDelegate) {

        let path = "/method/friends.get"

        let params: Parameters = [
            "access_token": Singleton.instance.token,
            "fields": "nickname, photo_50, photo_100, photo_200_orig",
            "v": versionAPI
        ]

        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON(
            queue: DispatchQueue.global(qos: .userInteractive)) { response in
                let friends = VkResponseParser.instance.parseFriends(token: token, result: response.result)
                DispatchQueue.main.async {
                    delegate.returnFriends(friends)
                }
        }
    }
    
//    func getPromiseFriends(token: String) -> Promise<[User]> {
//        let path = "/method/friends.get"
//
//        let params: Parameters = [
//            "access_token": Singleton.instance.token,
//            "fields": "nickname, photo_50, photo_100, photo_200_orig",
//            "v": versionAPI
//        ]
//
//        return Promise { resolver in
//            NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    let friendJSONs = json["response"]["items"].arrayValue
//
//                    let friends = friendJSONs.map { User($0, token: token) }
//                    resolver.fulfill(friends)
//
//                case .failure(let error):
//                    resolver.reject(error)
//                }
//            }
//        }
//    }
    
    func loadSearchGroups(searchQuery: String, delegate: VkApiSearchGroupsDelegate) {
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": Singleton.instance.token,
            "q": searchQuery,
            "v": versionAPI
        ]

        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON(
            queue: DispatchQueue.global(qos: .userInteractive)) { response in
                let searchGroups = VkResponseParser.instance.parseSearchGroups(searchQuery: searchQuery, result: response.result)
                DispatchQueue.main.async {
                    delegate.returnSearchGroups(searchGroups)
                }
        }
    }
    
//    func loadSearchGroups(searchQuery: String, completion: @escaping ([SearchGroup]) -> Void) {
//        let path = "/method/groups.search"
//
//        let params: Parameters = [
//            "access_token": Singleton.instance.token,
//            "q": searchQuery,
//            "v": versionAPI
//        ]
//
//        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                let searchGroupsJSONs = json["response"]["items"].arrayValue
//                let searchGroups = searchGroupsJSONs.map { SearchGroup($0, searchQuery: searchQuery) }
//                completion(searchGroups)
//            case .failure(let error):
//                print(error)
//                completion([])
//            }
//        }
//    }
    
    func fetchPhotos(for userId: Int, delegate: VkApiPhotosDelegate) {
        let path = "/method/photos.getAll"

        let params: Parameters = [
            "access_token": Singleton.instance.token,
            "owner_id": String(userId),
            "extended": 1,
            "count": 100,
            "v": versionAPI
        ]

        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON(
            queue: DispatchQueue.global(qos: .userInteractive)) { response in
            let photos = VkResponseParser.instance.parsePhotos(for: userId, result: response.result)
                DispatchQueue.main.async {
                    delegate.returnPhotos(photos)
                }
        }
    }
    
//    func loadNews(token: String, delegate: VkApiNewsDelegate) {
//        let path = "/method/newsfeed.get"
//
//        let params: Parameters = [
//            "access_token": Singleton.instance.token,
//            "filters": "post, photo",
//            "count": 20,
//            "v": versionAPI
//        ]
//
//        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON(queue: .global(qos: .utility)) {
//            response in
//
//            let news = VkResponseParser.instance.parseNews(token: token, result: response.result)
//                DispatchQueue.main.async {
//                    delegate.returnNews(news)
//                }
//        }
//    }
//
//    func loadPartNews(startFrom: String, token: String, delegate: VkApiPartNewsDelegate) {
//        let path = "/method/newsfeed.get"
//
//        let params: Parameters = [
//            "access_token": Singleton.instance.token,
//            "start_from": startFrom,
//            "filters": "post, photo",
//            "count": 20,
//            "v": versionAPI
//        ]
//
//        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON(queue: .global(qos: .utility)) {
//            response in
//
//            let news = VkResponseParser.instance.parsePartNews(startFrom: startFrom,token: token, result: response.result)
//                DispatchQueue.main.async {
//                    delegate.returnPartNews(news)
//                }
//        }
//    }
    
//    func fetchPhotos(for userId: Int, completion: @escaping ([Photo]) -> Void) {
//        let path = "/method/photos.getAll"
//
//        let params: Parameters = [
//            "access_token": Singleton.instance.token,
//            "owner_id": String(userId),
//            "extended": 1,
//            "count": 100,
//            "v": versionAPI
//        ]
//
//        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON {
//            response in
//
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                let photoJSONs = json["response"]["items"].arrayValue
//                let photos = photoJSONs.map { Photo($0, userId: userId) }
//                completion(photos)
//            case .failure(let error):
//                print(error)
//                completion([])
//            }
//        }
//    }
    
    func loadNews(token: String, completion: ((VKNews?, Error?) -> Void)? = nil) {
        let path = "/method/newsfeed.get"

        let params: Parameters = [
            "access_token": Singleton.instance.token,
            "filters": "post, photo",
            "count": 20,
            "v": versionAPI
        ]

        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON(queue: .global(qos: .utility)) {
            response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)

                var postNews = [ItemsNews]()
                var postProfilesNews = [ItemsProfiles]()
                var postGroupsNews = [ItemsGroups]()

                let jsonParseGroup = DispatchGroup()

                DispatchQueue.global().async(group: jsonParseGroup) {
                    postNews = json["response"]["items"].arrayValue.map { ItemsNews(json: $0, token: token) }
                    postNews.forEach { print($0.text) }
                }

                DispatchQueue.global().async(group: jsonParseGroup) {
                    postGroupsNews = json["response"]["groups"].arrayValue.map { ItemsGroups(json: $0, token: token) }
                    postGroupsNews.forEach { print($0.nameGroup) }
                }

                DispatchQueue.global().async(group: jsonParseGroup) {
                    postProfilesNews = json["response"]["profiles"].arrayValue.map { ItemsProfiles(json: $0, token: token) }
                    postProfilesNews.forEach { print($0.firstName + " " + $0.lastName ) }
                }

                jsonParseGroup.notify(queue: DispatchQueue.main) {
                    let news = VKNews(items: postNews, profiles: postProfilesNews, groups: postGroupsNews)
                    completion?(news, nil)
                }

            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    func loadPartNews(startFrom: String, token: String, completion: ((VKNews?, Error?, String?) -> Void)? = nil) {
        let path = "/method/newsfeed.get"

        let params: Parameters = [
            "access_token": Singleton.instance.token,
            "start_from": startFrom,
            "filters": "post, photo",
            "count": 20,
            "v": versionAPI
        ]

        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON(queue: .global(qos: .utility)) {
            response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)

                var postNews = [ItemsNews]()
                var postProfilesNews = [ItemsProfiles]()
                var postGroupsNews = [ItemsGroups]()
                var nextFrom = ""

                let jsonParseGroup = DispatchGroup()

                DispatchQueue.global().async(group: jsonParseGroup) {
                    postNews = json["response"]["items"].arrayValue.map { ItemsNews(json: $0, token: token) }
                    postNews.forEach { print($0.text) }
                }

                DispatchQueue.global().async(group: jsonParseGroup) {
                    postGroupsNews = json["response"]["groups"].arrayValue.map { ItemsGroups(json: $0, token: token) }
                    postGroupsNews.forEach { print($0.nameGroup) }
                }

                DispatchQueue.global().async(group: jsonParseGroup) {
                    postProfilesNews = json["response"]["profiles"].arrayValue.map { ItemsProfiles(json: $0, token: token) }
                    postProfilesNews.forEach { print($0.firstName + " " + $0.lastName ) }
                }

                    nextFrom = json["response"]["next_from"].stringValue
                    Singleton.instance.nextFrom = nextFrom


                jsonParseGroup.notify(queue: DispatchQueue.main) {
                    let news = VKNews(items: postNews, profiles: postProfilesNews, groups: postGroupsNews)
                    completion?(news, nil, nextFrom)
                }

            case .failure(let error):
                completion?(nil, error, nil)
            }
        }
    }
}
