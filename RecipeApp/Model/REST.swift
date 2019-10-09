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
    func didGetNutrients()
}

class REST_Request{
    weak var delegate: REST_Delegate?
    private var nutrients:[Nutrient] = []
    private let session = URLSession.shared
    private let baseURL:String = "https://api.edamam.com/api/nutrition-details?app_id=0a4f449e&app_key=114c5eaa049af50df15413d088e2168e"
    private let param_ingr:String = "ingr="
    
    func getNutrients(ings:[String], yield:String) -> [Nutrient]{
        //let url = baseURL + param_ingr + ingrStr
        let url = baseURL
        guard let escapedURL = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return []
        }
        
        
        if let url = URL(string: escapedURL){
//            var request = URLRequest(url:url)
//            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "yield": yield,
                "ingr": ings//[
//                    "1 fresh ham, about 18 pounds, prepared by your butcher (See Step 1)",
//                    "7 cloves garlic, minced",
//                    "1 tablespoon caraway seeds, crushed",
//                    "4 teaspoons salt",
//                    "Freshly ground pepper to taste",
//                    "1 teaspoon olive oil",
//                    "1 medium onion, peeled and chopped",
//                    "3 cups sourdough rye bread, cut into 1/2-inch cubes",
//                    "1 1/4 cups coarsely chopped pitted prunes",
//                    "1 1/4 cups coarsely chopped dried apricots",
//                    "1 large tart apple, peeled, cored and cut into 1/2-inch cubes",
//                    "2 teaspoons chopped fresh rosemary",
//                    "1 egg, lightly beaten",
//                    "1 cup chicken broth, homemade or low-sodium canned"
                //]
            ]
        
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON { response in
                    print(response)
                    
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        print(JSON)
                        
                        let totalNutr = JSON["totalNutrients"] as! NSDictionary
                        var newNutrients = [Nutrient]()
//
                        //iterate over wanted nutrients and keys base on API to create nutrient objects based on data
                        for n in nutrientsKey {
                            var nutr = totalNutr[n.key] as! [String:Any]
                            let name = nutr["label"] as! String
                            let rawUnit = nutr["unit"] as! String

                            //using NS number becuase value set by JSON decoder
                            if let amt = nutr["quantity"] as? NSNumber {
                                let amount = amt.floatValue
                                let newNutrient = Nutrient(name: name, amount: amount, unitName: Unit(rawValue: rawUnit)!)
                                newNutrients.append(newNutrient)
                                print(newNutrient.presentationForm())
                                self.nutrients = newNutrients
                            }
                        }
                    }
                  
                }
            //getData(request: request, element: "totalNutrients")
        }
        return nutrients
    }
    
    private func getData(request: URLRequest, element:String){
        
        let task = session.dataTask(with: request,
            completionHandler: {
                data, response, downloadError in
                
                if let error = downloadError {
                    //if error print to console
                    print(error)
                }else{
                    //will get back dataobject that will contain response
                    //deserialise the JSON
                    var parsedResult: Any! = nil
                    do {
                        parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    }catch{print()}
                    
                    let result = parsedResult as! [String:Any]
                    
                    //all nutrients returned from the API
                    let allNutrients = result[element] as! [String:Any]
                   
                    //to hold created Nutrients object from API data
                    var newNutrients = [Nutrient]()
                    
                    //iterate over wanted nutrients and keys base on API to create nutrient objects based on data
                    for n in nutrientsKey {
                        var nutr = allNutrients[n.key] as! [String:Any]
                        let name = nutr["label"] as! String
                        let rawUnit = nutr["unit"] as! String
                        
                        //using NS number becuase value set by JSON decoder
                        if let amt = nutr["quantity"] as? NSNumber {
                            let amount = amt.floatValue
                            let newNutrient = Nutrient(name: name, amount: amount, unitName: Unit(rawValue: rawUnit)!)
                            newNutrients.append(newNutrient)
                            print(newNutrient.presentationForm())
                            self.nutrients = newNutrients
                        }
                    }
                   
                }
        })
        task.resume()
    }
}


var nutrientsKey:[String:String] = [
    "CHOCDF": "Carbs",
    "ENERC_KCAL": "Energy",
    "FAT": "Fat",
    "FASAT": "Saturated Fat",
    "FAMS": "Monounsaturated Fat",
    "FAPU": "Polyunsaturated Fat",
    "SUGAR": "Sugar",
    "PROCNT": "Protien",
    "NA": "Sodium"
]

struct APIObject : Codable {
    let label : String?
    let quantity : Double?
    let unit : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
        case quantity = "quantity"
        case unit = "unit"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        quantity = try values.decodeIfPresent(Double.self, forKey: .quantity)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
    }
    
}
