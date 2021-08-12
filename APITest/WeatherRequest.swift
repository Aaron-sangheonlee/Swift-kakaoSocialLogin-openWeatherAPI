//
//  weatherRequest.swift
//  APITest
//
//  Created by 이상헌 on 2021/08/09.
//

import Foundation
import Alamofire

class WeatherRequest {
    
    func getWeatherData(_ viewController : ViewController){
        
        let url = "https://api.openweathermap.org/data/2.5/weather?q=seoul&APPID=0ca0aa68190970cc2a2937e2ddfb9679"
        
        let params: Parameters = [
            "q" : "seoul",
        "APPID" : "0ca0aa68190970cc2a2937e2ddfb9679"
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   headers: nil)
            .responseDecodable(of: weatherResponse.self) { response in
            
            switch response.result {
            
            case .success(let response):
                //print("DEBUG>> Open WeatherResponse \(response) ")
                viewController.didSuccess(response)
                
            case .failure(let error):
                print("DEBUG>> OpenWeather Get Error : \(error.localizedDescription)")
            }
        }
    }
}
