//
//  PublicResource.swift
//  CCSwift
//
//  Created by 渡部郷太 on 6/6/17.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import SwiftyJSON
import Alamofire


internal class PublicResource : Resource {
    
    func ticker(callback: @escaping CCCallback) {
        let url = Resource.endPointUrl + "/ticker"
        self.get(url, callback: callback)
    }
    
    func trades(offset: Int, callback: @escaping CCCallback) {
        let url = Resource.endPointUrl + "/trades"
        self.get(url, params: ["offset": offset.description], callback: callback)
    }
    
}
