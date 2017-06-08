//
//  PublicApi.swift
//  CCSwift
//
//  Created by 渡部郷太 on 6/6/17.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import SwiftyJSON


public typealias CCCallback = ((_ err: CCError?, _ data: JSON?) -> Void)

public class PublicApi {
    
    static public func ticker(callback: @escaping CCCallback) {
        PublicResource().ticker(callback: callback)
    }
    
    static public func trades(offset: Int=0, callback: @escaping CCCallback) {
        PublicResource().trades(offset: offset, callback: callback)
    }

}
