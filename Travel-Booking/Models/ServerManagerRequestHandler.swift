//
//  ServerManagerRequestHandler.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 18/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import Foundation
import Alamofire

internal enum ServerRequestRouter: URLRequestConvertible{
    
    
    static var baseURLString:String{
        return "https://maps.googleapis.com/maps/api/place/textsearch/json?query=top+cities+in+"
    }
    
    static var getPhotosString:String{
        return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400"
    }
    
    static var getDestinationsString:String{
        return "https://maps.googleapis.com/maps/api/place/textsearch/json?query=top+10+destinations+in+"
    }
    
    static var getCityDesc:String {
        return "https://en.wikipedia.org/api/rest_v1/page/summary/"
    }
    
    static var getPointOfInterest:String {
        return "https://maps.googleapis.com/maps/api/place/textsearch/json?query=point+of+interest+in+"
    }
    
    static var flightsDataURL:String {
        return "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browsequotes/v1.0/IN/INR/en-IN/"
    }
    
    static var airlineImageURL: String {
        return "https://daisycon.io/images/airline/?width=200&height=200&iata="
    }
    
    static var airportListURL: String {
        return "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/autosuggest/v1.0/IN/INR/en-IN/"
    }
    
    case getCities(String)
    case getImageFromReferenceId(String)
    case getDestinationsString(String)
    case getCityDesc(String)
    case getPointOfInterest(String)
    case flightsDataURLString(String, String, String)
    case airportsListString(String)
        
    var httpMethod:Alamofire.HTTPMethod {
        switch self {
        case .getCities(_):
            return .get
        case .getImageFromReferenceId(_):
            return .get
        case .getDestinationsString(_):
            return .get
        case .getCityDesc(_):
            return .get
        case .getPointOfInterest(_):
            return .get
        case .flightsDataURLString(_, _, _):
            return .get
        case .airportsListString(_):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getCities(let city):
            return "\(ServerRequestRouter.baseURLString)\(city)"
        case .getImageFromReferenceId(let referenceId):
            return "\(ServerRequestRouter.getPhotosString)&photoreference=\(referenceId)&key=\(Constants.API_KEY)"
        case .getDestinationsString(let dest):
            return "\(ServerRequestRouter.getDestinationsString)\(dest)"
        case .getCityDesc(let cityName):
            return "\(ServerRequestRouter.getCityDesc)\(cityName)"
        case .getPointOfInterest(let cityName):
            return "\(ServerRequestRouter.getPointOfInterest)\(cityName)"
        case .flightsDataURLString(let origin, let destination, let date):
            return "\(ServerRequestRouter.flightsDataURL)\(origin)/\(destination)/\(date)"
        case .airportsListString(_):
            return "\(ServerRequestRouter.airportListURL)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let URL = Foundation.URL(string: path)!
        var mutableURLRequest = URLRequest(url: URL)
        mutableURLRequest.httpMethod = httpMethod.rawValue
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        switch  self {
        case .getCities(_):
            do {
                let parameters: Parameters = ["languague": "en", "key": Constants.API_KEY]

                let encoding =  URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with: parameters)
                
            } catch {
                return mutableURLRequest
            }
            
        case .getImageFromReferenceId(_):
            do {
                let encoding =  URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with: nil)
                
            } catch {
                return mutableURLRequest
            }
        case .getDestinationsString(_):
            do {
                let parameters: Parameters = ["languague": "en", "key": Constants.API_KEY]

                let encoding =  URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with: parameters)
                
            } catch {
                return mutableURLRequest
            }
        case .getCityDesc(_):
            do {
                let encoding =  URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with: nil)
            } catch {
                return mutableURLRequest
            }
        case .getPointOfInterest(_):
            do {
                let parameters: Parameters = ["languague": "en", "key": Constants.API_KEY]

                let encoding =  URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with: parameters)
                
            } catch {
                return mutableURLRequest
            }
        case .flightsDataURLString(_, _, _):
            mutableURLRequest.setValue("e9dc41716fmsh809957099687bb8p1e3681jsn3279975abe4a", forHTTPHeaderField: "x-rapidapi-key")
            mutableURLRequest.setValue("skyscanner-skyscanner-flight-search-v1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")

             do {
                   let encoding =  URLEncoding(destination: URLEncoding.Destination.queryString)
                   return try encoding.encode(mutableURLRequest, with: nil)
               } catch {
                   return mutableURLRequest
               }
        case .airportsListString(let city):
            mutableURLRequest.setValue("e9dc41716fmsh809957099687bb8p1e3681jsn3279975abe4a", forHTTPHeaderField: "x-rapidapi-key")
            mutableURLRequest.setValue("skyscanner-skyscanner-flight-search-v1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")

            do {
                let parameters: Parameters = ["query": city]

                let encoding =  URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with: parameters)
                
            } catch {
                return mutableURLRequest
            }
        }
    }
}
