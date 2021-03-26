//
//  NetworkServiceProxy.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 20.02.2021.
//  Copyright © 2021 appleS. All rights reserved.
//

import Foundation
import UIKit
import PromiseKit

protocol NetworkServiceAdapterInterface {
    func getPromiseFriends(token: String) -> Promise<[User]>
    func loadGroups(token: String, completion: @escaping ([Group]) -> Void)
    func fetchPhotos(for userId: Int, completion: @escaping ([Photo]) -> Void)
}

protocol NetworkServiceInterface {
    func loadNews(token: String, completion: @escaping (VKNews?, Error?) -> Void)
}

class NetworkServiceAdapterLoggingProxy: NetworkServiceAdapterInterface {
    
    let networkServiceAdapter: NetworkServiceAdapterInterface
    
    init(networkServiceAdapter: NetworkServiceAdapterInterface) {
        self.networkServiceAdapter = networkServiceAdapter
    }
    
    func getPromiseFriends(token: String) -> Promise<[User]> {
        firstly {
            self.networkServiceAdapter.getPromiseFriends(token: Singleton.instance.token)
        }
            .get { [weak self] friends in
                print("called func getPromiseFriends with friends \(friends)")
            }
    }
    
    func loadGroups(token: String, completion: @escaping ([Group]) -> Void) {
        self.networkServiceAdapter.loadGroups(token: Singleton.instance.token, completion: completion)
            print("called func loadGroups with groups")
    }
    
    func fetchPhotos(for userId: Int, completion: @escaping ([Photo]) -> Void) {
        self.networkServiceAdapter.fetchPhotos(for: userId, completion: completion)
            print("called func fetchPhotos with photos")
    }
}

class NetworkServiceLoggingProxy: NetworkServiceInterface {
    
    let networkService: NetworkServiceInterface
    
    init(networkService: NetworkServiceInterface) {
        self.networkService = networkService
    }
    
    func loadNews(token: String, completion: @escaping (VKNews?, Error?) -> Void) {
        self.networkService.loadNews(token: Singleton.instance.token, completion: completion)
        print("called func loadNews with news")
    }
}
