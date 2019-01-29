//
//  NetworkManager.swift
//  NapoleonTest
//
//  Created by Роман Тищенко on 16/12/2018.
//  Copyright © 2018 Роман Тищенко. All rights reserved.
//

import Foundation

class NetworkManager: NetworkManagerProtocol {
    
    func getImageData(entityDataList: [ImageEntityProtocol]) -> [Data?] {
        var imageDataList : [Data?] = []
        DispatchQueue.global().sync {
            for entityData in entityDataList {
                guard let urlString = entityData.image else { imageDataList.append(nil); break}
                let url = URL(string: urlString)
                if let imageData = try? Data(contentsOf: url!) {
                    imageDataList.append(imageData)
                } else {
                    imageDataList.append(nil)
                }
            }
        }
        return imageDataList
    }
    
    func getBanners(completionHandler: @escaping ((APIResult<[Banner]>) -> Void)) {
        let request = APIRequest.Banners.request
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                guard let data = data else { return }
                let banners = try JSONDecoder().decode([Banner].self, from: data)
                completionHandler(APIResult.SuccessGetBannersRequest(banners))                
            } catch {
                do {
                    guard let data = data else { return }
                    let hostError = try JSONDecoder().decode(HostError.self, from: data)
                    completionHandler(APIResult.ServerSideFailureRequest(hostError))
                } catch {
                    completionHandler(APIResult.LocalSideFailure("Во время загрузки данных, что-то пошло не так!"))
                }
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
    }
    
    func getOffers(completionHandler: @escaping ((APIResult<Offer>) -> Void)) {
        let request = APIRequest.Offers.request
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                guard let data = data else { return }
                let offers = try JSONDecoder().decode([Offer].self, from: data)
                completionHandler(APIResult.SuccessGetOffersRequest(offers))
            } catch {
                do {
                    guard let data = data else { return }
                    let hostError = try JSONDecoder().decode(HostError.self, from: data)
                    completionHandler(APIResult.ServerSideFailureRequest(hostError))
                } catch {
                    completionHandler(APIResult.LocalSideFailure("Во время загрузки данных, что-то пошло не так!"))
                }
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
    }
}

enum APIRequest {
    private var baseURL: URL {
        return URL(string: "https://s3.eu-central-1.amazonaws.com/sl.files/")!
    }
    
    private var path: String {
        switch  self {
        case .Banners:
            return "banners.json"
        case .Offers:
            return "offers.json"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
    
    case Banners
    case Offers
}
