//
//  File.swift
//  RecipeApp
//
//  Created by Avital Miskella on 1/10/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import Foundation
import Alamofire

protocol REST_Delegate: class {
    func didGetNutrients(recipe:RecipeMO)
}

//Had to use extension to AlamoFire because by default it sends cached data that was messing with the API interaction (Etag)
/** Credit: https://stackoverflow.com/questions/32199494/how-to-disable-caching-in-alamofire **/
extension Alamofire.SessionManager{
    @discardableResult
    open func requestWithoutCache(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)// also you can add URLRequest.CachePolicy here as parameter
        -> DataRequest
    {
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
            urlRequest.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            // TODO: find a better way to handle error
            print(error)
            return request(URLRequest(url: URL(string: "http://example.com/wrong_request")!))
        }
    }
}

class REST_Request{
    weak var delegate: REST_Delegate?
    private var nutrients:[NutrientMO] = []
    private var recipe:RecipeMO? = nil
    private let baseURL:String = "https://api.edamam.com/api/nutrition-details?app_id=0a4f449e&app_key=114c5eaa049af50df15413d088e2168e"

    /** Make POST request to 'edamam' API with recipe info passed in.
        Will call delegate to return processed response data **/
    func addNutrients(recipe:RecipeMO) {
        self.recipe = recipe
        let url = baseURL
        guard let escapedURL = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        //create string array to post to API
        var strIngs: [String] = []
        for i in recipe.ingredients{
            strIngs.append(i.ingString())
        }
        
        //set yield (Servings) and ingredients for API call
        if let url = URL(string: escapedURL){
            let parameters: [String: Any] = [
                "yield": recipe.serves,
                "ingr": strIngs
            ]
            
            //make API request using AlamoFire and the declared parts of the request
            Alamofire.SessionManager.default.requestWithoutCache(url,
                              method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default,
                              headers: nil)
                .validate(statusCode: 200..<300) //check valid response
                .responseJSON { response in
                    //capture JSON response
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        
                        //only care about the nutrients part of the response
                        let totalNutr = JSON["totalNutrients"] as! NSDictionary
                        var newNutrients = [NutrientMO]()
                        
                        //iterate over wanted nutrients and keys base on API to create nutrient objects based on data
                        for n in nutrientsKey {
                            var nutr = totalNutr[n.key] as! [String:Any]
                            let name = nutr["label"] as! String
                            let rawUnit = nutr["unit"] as! String

                            //using NS number becuase value set by JSON decoder
                            if let amt = nutr["quantity"] as? NSNumber {
                                var amount = amt.floatValue
                                amount =  (amount * 10).rounded()/10
                                let newNutrient = NutrientMO(name: name, amount: amount, unitName: Unit(rawValue: rawUnit)!)
                                newNutrients.append(newNutrient)
                                print(newNutrient.presentationForm())
                                self.recipe?.setNutrients(nutrients: newNutrients)
                            }
                        }
                        self.connectBack()
                    }
                  
                }
            }
    }
    
    func connectBack(){
        //will call the function in Recipe manager to send back the data
        delegate?.didGetNutrients(recipe: self.recipe!)
    }
    
}


var nutrientsKey:[String:String] = [
    "CHOCDF": "Carbs",
    "ENERC_KCAL": "Energy",
    "FAT": "Fat",
//    "FASAT": "Saturated Fat",
//    "FAMS": "Monounsaturated Fat",
//    "FAPU": "Polyunsaturated Fat",
    "SUGAR": "Sugar",
    "PROCNT": "Protien",
    "NA": "Sodium"
]
