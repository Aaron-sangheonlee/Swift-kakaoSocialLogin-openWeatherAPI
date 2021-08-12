//
//  APIStruct.swift
//  APITest
//
//  Created by 이상헌 on 2021/08/08.
//

import Foundation

struct weatherResponse : Decodable {
    
    var coord: coord
    var weather: [weather]
    var main: main
    var wind: wind
    var clouds: clouds
    var sys: sys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    var dt: Int
    var visibility: Int
    var base: String
}

struct coord : Decodable {
    var lon: Float
    var lat: Float
    }

struct weather : Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct main : Decodable {
    var temp: Float
 var feels_like: Float
 var temp_min: Float
 var temp_max: Float
 var pressure: Float
 var humidity: Float
    }

struct wind : Decodable {
    var speed: Float
    var deg: Float
}

struct clouds : Decodable{
    var all: Int
    }

struct sys : Decodable{
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int
    }
