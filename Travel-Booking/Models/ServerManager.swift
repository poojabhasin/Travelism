//
//  ServerManager.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 18/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

public enum ServerErrorCodes: Int{
    case notFound = 404
    case validationError = 422
    case internalServerError = 500
}


public enum ServerErrorMessages: String{
    case notFound = "Not Found"
    case validationError = "Validation Error"
    case internalServerError = "Internal Server Error"
}


public enum ServerError: Error{
    case systemError(Error)
    case customError(String)
    
    public var details:(code:Int ,message:String){
        switch self {
            
        case .customError(let errorMsg):
            switch errorMsg {
            case "Not Found":
                return (ServerErrorCodes.notFound.rawValue,ServerErrorMessages.notFound.rawValue)
            case "Validation Error":
                return (ServerErrorCodes.validationError.rawValue,ServerErrorMessages.validationError.rawValue)
            case "Internal Server Error":
                 return (ServerErrorCodes.internalServerError.rawValue,ServerErrorMessages.internalServerError.rawValue)
            default:
                return (ServerErrorCodes.internalServerError.rawValue,ServerErrorMessages.internalServerError.rawValue)
            }
            
        case .systemError(let errorCode):
            return (errorCode._code,errorCode.localizedDescription)
        }
    }
}

public struct ServerManager{
    
    static var sharedInstance = ServerManager()
    
    // To fetch city data
    func getAllCities(cityVal: String, handler:@escaping (TopCityResponse?,ServerError?) -> Void){
        Alamofire.request(ServerRequestRouter.getCities(cityVal)).validate().responseObject {(response:DataResponse<TopCityResponse>) in
            
            switch response.result {

            case .success:
                if let cities = response.result.value{
                    handler(cities, nil)
                }

            case .failure(let error):
                print(error)
                if error.localizedDescription .contains("404"){
                    handler(nil,ServerError.customError("Not Found"))
                } else if error.localizedDescription.contains("422") {
                    handler(nil,ServerError.customError("Validation Error"))
                } else if error.localizedDescription.contains("500"){
                    handler(nil,ServerError.customError("Internal Server Error"))
                }
                else{
                    handler(nil,ServerError.systemError(error))
                }
            }
        }
    }
    
    //To fetch destination data
    func getAllDestinations(destVal: String, handler:@escaping (DestinationBase?,ServerError?) -> Void){
        Alamofire.request(ServerRequestRouter.getDestinationsString(destVal)).validate().responseObject {(response:DataResponse<DestinationBase>) in
            
            switch response.result {

            case .success:
                if let dest = response.result.value{
                    handler(dest, nil)
                }

            case .failure(let error):
                print(error)
                if error.localizedDescription .contains("404"){
                    handler(nil,ServerError.customError("Not Found"))
                } else if error.localizedDescription.contains("422") {
                    handler(nil,ServerError.customError("Validation Error"))
                } else if error.localizedDescription.contains("500"){
                    handler(nil,ServerError.customError("Internal Server Error"))
                }
                else{
                    handler(nil,ServerError.systemError(error))
                }
            }
        }
    }
    
    //To fetch description data
    func getCityDesc(cityVal: String, handler:@escaping (DescriptionResponseBase?,ServerError?) -> Void){
        Alamofire.request(ServerRequestRouter.getCityDesc(cityVal)).validate().responseObject {(response:DataResponse<DescriptionResponseBase>) in
            
            switch response.result {

            case .success:
                if let desc = response.result.value{
                    handler(desc, nil)
                }

            case .failure(let error):
                print(error)
                if error.localizedDescription .contains("404"){
                    handler(nil,ServerError.customError("Not Found"))
                } else if error.localizedDescription.contains("422") {
                    handler(nil,ServerError.customError("Validation Error"))
                } else if error.localizedDescription.contains("500"){
                    handler(nil,ServerError.customError("Internal Server Error"))
                }
                else{
                    handler(nil,ServerError.systemError(error))
                }
            }
        }
    }
    
    //To fetch point of interest data
    func getPointOfInterestData(cityVal: String, handler:@escaping (DestinationBase?,ServerError?) -> Void){
        Alamofire.request(ServerRequestRouter.getPointOfInterest(cityVal)).validate().responseObject {(response:DataResponse<DestinationBase>) in
            
            switch response.result {

            case .success:
                if let desc = response.result.value{
                    handler(desc, nil)
                }

            case .failure(let error):
                print(error)
                if error.localizedDescription .contains("404"){
                    handler(nil,ServerError.customError("Not Found"))
                } else if error.localizedDescription.contains("422") {
                    handler(nil,ServerError.customError("Validation Error"))
                } else if error.localizedDescription.contains("500"){
                    handler(nil,ServerError.customError("Internal Server Error"))
                }
                else{
                    handler(nil,ServerError.systemError(error))
                }
            }
        }
    }
    
    //To fetch point of interest data
    func getFlightsData(origin: String, dest:String, date:String, handler:@escaping (FlightQuote?,ServerError?) -> Void){
        Alamofire.request(ServerRequestRouter.flightsDataURLString(origin, dest, date)).validate().responseObject {(response:DataResponse<FlightQuote>) in
            
            switch response.result {

            case .success:
                if let desc = response.result.value{
                    handler(desc, nil)
                }

            case .failure(let error):
                print(error)
                if error.localizedDescription .contains("404"){
                    handler(nil,ServerError.customError("Not Found"))
                } else if error.localizedDescription.contains("422") {
                    handler(nil,ServerError.customError("Validation Error"))
                } else if error.localizedDescription.contains("500"){
                    handler(nil,ServerError.customError("Internal Server Error"))
                }
                else{
                    handler(nil,ServerError.systemError(error))
                }
            }
        }
    }
    
    //To fetch Airport data
       func getAirportsData(searchVal: String, handler:@escaping (AirportsTopResponse?,ServerError?) -> Void){
           
           Alamofire.request(ServerRequestRouter.airportsListString(searchVal)).validate().responseObject {(response:DataResponse<AirportsTopResponse>) in
               
               switch response.result {

               case .success:
                   if let val = response.result.value{
                       handler(val, nil)
                   }

               case .failure(let error):
                   print(error)
                   if error.localizedDescription .contains("404"){
                       handler(nil,ServerError.customError("Not Found"))
                   } else if error.localizedDescription.contains("422") {
                       handler(nil,ServerError.customError("Validation Error"))
                   } else if error.localizedDescription.contains("500"){
                       handler(nil,ServerError.customError("Internal Server Error"))
                   }
                   else{
                       handler(nil,ServerError.systemError(error))
                   }
               }
           }
       }
    
    
    
}
