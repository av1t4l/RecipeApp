//
//  File.swift
//  RecipeApp
//
//  Created by Avital Miskella on 1/10/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import Foundation

struct REST_Request{
    private var nutrients:[Nutrient] = []
    private let session = URLSession.shared
    private let baseURL:String = "https://api.edamam.com/api/nutrition-data?app_id=0a4f449e&app_key=114c5eaa049af50df15413d088e2168e&"
    private let param_ingr:String = "ingr="
    
    func getNutrient(ingrStr:String){
        let url = baseURL + param_ingr + ingrStr
        guard let escapedURL = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        if let url = URL(string: escapedURL){
            let request = URLRequest(url:url)
            getData(request: request, element: "totalNutrients")
            
        }
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
                    var parsedResult: Any! = nil
                    do {
                        parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    }catch{print()}
                    
                    let result = parsedResult as! [String:Any]
                    print(result)
                    
                    let allNutrients = result[element] as! [String:Any]
                    print(allNutrients)
                    
                    var newNutrients = [Nutrient]()
                    
                    for nutrient in nutrientsKey{
                        //cast the array item of type ANY to the defined struct to access the values
                        let jsonDecoder = JSONDecoder()
                        let selected = try jsonDecoder.decode(APIObject.self, from: allNutrients[nutrient.key]!)
                        
                       // let selected = allNutrients[nutrient.key] as! APIObject
                        //create new nutrient object based on the API response
                        let newNutrient = Nutrient(name: nutrient.value, amount: selected.quantity, unitName: Unit(rawValue: selected.unit)!)
                        print(newNutrient)
                        newNutrients.append(newNutrient)
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
