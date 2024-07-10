//
//  AIServiceConstants.swift
//
//  Created by iMac on 09/07/24.
//

import Foundation

//MARK: - BASE URL
var URL_BASE =  "https://dummyjson.com/"

var URL_PRODUCTS_LIST   = getFullUrl("products")

//MARK: - FULL URL
func getFullUrl(_ urlEndPoint : String) -> String {
    return "\(URL_BASE)\(urlEndPoint)"
}

