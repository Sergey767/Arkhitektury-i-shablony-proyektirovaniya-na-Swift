//
//  VkResponseParser.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 02.01.2021.
//  Copyright © 2021 appleS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit

class VkResponseParser {
    
    static let instance = VkResponseParser()
    private init(){}

    func parseGroups(token: String, result: AFResult<Any>) -> [Group] {
        var groups = [Group]()
        
        switch result {
        case .success(let value):
            let json = JSON(value)
            let groupJSONs = json["response"]["items"].arrayValue
            let group = groupJSONs.map { Group($0, token: token) }
            groups.append(contentsOf: group)
            
        case .failure(let error):
            print(error)
        }
        
        if groups.count > 0 {
           _ = RealmProvider.instance.saveItems(items: groups)
        } else {
            groups = RealmProvider.instance.getMyGroups()
        }
        return groups
    }
    
    
    func parseFriends(token: String, result: AFResult<Any>) -> [User] {
        var friends = [User]()
        
        switch result {
        case .success(let value):
            let json = JSON(value)
            let friendJSONs = json["response"]["items"].arrayValue
            
            let friend = friendJSONs.map { User($0, token: token) }
            friends.append(contentsOf: friend)
            
        case .failure(let error):
            print(error)
        }
        
        if friends.count > 0 {
            _ = RealmProvider.instance.saveItems(items: friends)
        } else {
            friends = RealmProvider.instance.getMyFriends()
        }
        
        return friends
    }
    
    
    func parsePhotos(for userId: Int, result: AFResult<Any>) -> [Photo] {
        var photos = [Photo]()
        
        switch result {
        case .success(let value):
            let json = JSON(value)
            let photoJSONs = json["response"]["items"].arrayValue
            
            let photo = photoJSONs.map { Photo($0, userId: userId) }
            photos.append(contentsOf: photo)
            
        case .failure(let error):
            print(error)
        }
        
        if photos.count > 0 {
            _ = RealmProvider.instance.saveItems(items: photos)
        }
        
        return photos
    }
    
    func parseSearchGroups(searchQuery: String, result: AFResult<Any>) -> [SearchGroup] {
        var searchGroups = [SearchGroup]()
        
        switch result {
        case .success(let value):
            let json = JSON(value)
            let searchGroupsJSONs = json["response"]["items"].arrayValue
            let searchGroup = searchGroupsJSONs.map { SearchGroup($0, searchQuery: searchQuery)}
            
            searchGroups.append(contentsOf: searchGroup)
            
        case .failure(let error):
            print(error)
        }
        
        return searchGroups
    }
    
//    func parseNews(token: String, result: AFResult<Any>) -> [VKNews] {
//        var vkNews = [VKNews]()
//
//        switch result {
//        case .success(let value):
//            let json = JSON(value)
//
//            var postNews = [ItemsNews]()
//            var postProfilesNews = [ItemsProfiles]()
//            var postGroupsNews = [ItemsGroups]()
//
//            let jsonParseGroup = DispatchGroup()
//
//            DispatchQueue.global().async(group: jsonParseGroup) {
//                let post = json["response"]["items"].arrayValue.map { ItemsNews(json: $0, token: token) }
//                post.forEach { print($0.text) }
//                postNews.append(contentsOf: post)
//            }
//
//            DispatchQueue.global().async(group: jsonParseGroup) {
//                let postGroup = json["response"]["groups"].arrayValue.map { ItemsGroups(json: $0, token: token) }
//                postGroup.forEach { print($0.nameGroup) }
//                postGroupsNews.append(contentsOf: postGroup)
//            }
//
//            DispatchQueue.global().async(group: jsonParseGroup) {
//                let postProfile = json["response"]["profiles"].arrayValue.map { ItemsProfiles(json: $0, token: token) }
//                postProfile.forEach { print($0.firstName + " " + $0.lastName ) }
//                postProfilesNews.append(contentsOf: postProfile)
//            }
//
//            jsonParseGroup.notify(queue: DispatchQueue.main) {
//                let news = VKNews(items: postNews, profiles: postProfilesNews, groups: postGroupsNews)
//                vkNews.append(news)
//            }
//
//        case .failure(let error):
//            print(error)
//        }
//
//        return vkNews
//    }
//
//    func parsePartNews(startFrom: String, token: String, result: AFResult<Any>) -> [VKNews] {
//        var vkNews = [VKNews]()
//
//        switch result {
//        case .success(let value):
//            let json = JSON(value)
//
//            var postNews = [ItemsNews]()
//            var postProfilesNews = [ItemsProfiles]()
//            var postGroupsNews = [ItemsGroups]()
//            var nextFrom = ""
//
//            let jsonParseGroup = DispatchGroup()
//
//            DispatchQueue.global().async(group: jsonParseGroup) {
//                let post = json["response"]["items"].arrayValue.map { ItemsNews(json: $0, token: token) }
//                post.forEach { print($0.text) }
//                postNews.append(contentsOf: post)
//            }
//
//            DispatchQueue.global().async(group: jsonParseGroup) {
//                let postGroup = json["response"]["groups"].arrayValue.map { ItemsGroups(json: $0, token: token) }
//                postGroup.forEach { print($0.nameGroup) }
//                postGroupsNews.append(contentsOf: postGroup)
//            }
//
//            DispatchQueue.global().async(group: jsonParseGroup) {
//                let postProfile = json["response"]["profiles"].arrayValue.map { ItemsProfiles(json: $0, token: token) }
//                postProfile.forEach { print($0.firstName + " " + $0.lastName ) }
//                postProfilesNews.append(contentsOf: postProfile)
//            }
//
//                nextFrom = json["response"]["next_from"].stringValue
//                Singleton.instance.nextFrom = nextFrom
//
//
//            jsonParseGroup.notify(queue: DispatchQueue.main) {
//                let news = VKNews(items: postNews, profiles: postProfilesNews, groups: postGroupsNews)
//                vkNews.append(news)
//            }
//
//        case .failure(let error):
//            print(error)
//        }
//
//        return vkNews
//    }
        
}
