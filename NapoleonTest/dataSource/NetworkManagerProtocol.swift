//
//  NetworkManagerProtocol.swift
//  NapoleonTest
//
//  Created by Роман Тищенко on 16/12/2018.
//  Copyright © 2018 Роман Тищенко. All rights reserved.
//

import Foundation

enum APIResult<T: Decodable> {
    case SuccessGetBannersRequest([Banner])
    case SuccessGetOffersRequest([Offer])
    case ServerSideFailureRequest(HostError)
    case LocalSideFailure(String)
}

protocol NetworkManagerProtocol {
    
    func getBanners(completionHandler: @escaping ((APIResult<[Banner]>) -> Void))
    
    func getOffers(completionHandler: @escaping ((APIResult<Offer>) -> Void))
    
    func getImageData(entityDataList: [ImageEntityProtocol]) -> [Data?]
}
