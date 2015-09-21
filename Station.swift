//
//  Station.swift
//  TryCycle-Swift2
//
//  Created by tho dang on 2015-09-20.
//  Copyright © 2015 Tho Dang. All rights reserved.
//

import Foundation
import MapKit

struct Station {
    
    var mapPins:NSMutableArray = []
    // initializer
    init(json:NSDictionary) {
        
        if let bikeShareStations = json["stationBeanList"] as? NSArray {
            
            let bikeShareDepots = bikeShareStations
            
            for var i = 0; i < bikeShareDepots.count; i++ {
                
                var availableBikes:Int?
                var availableDocks:Int?
                var latitude:Float?
                var longitude:Float?
                var stationName:String?
                
                let bikeShareData = bikeShareDepots[i] as? NSDictionary
                
                if let bikeShare = bikeShareData {
                    if let bike = bikeShare["availableBikes"] as? Int {
                        availableBikes = bike as Int
                    }
                    if let dock = bikeShare["availableDocks"] as? Int {
                        availableDocks = dock as Int
                    }
                    if let lat = bikeShare["latitude"] as? Float {
                        latitude = lat as Float
                    }
                    if let long = bikeShare["longitude"] as? Float {
                        longitude = long
                    }
                    if let station = bikeShare["stationName"] as? String {
                        stationName = station
                    }
                    let pin = MapPin(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude!), longitude: CLLocationDegrees(longitude!)), title:stationName!, subtitle: "Available Bikes: \(availableBikes!) & Available Docks: \(availableDocks!) ")
                    mapPins.addObject(pin)
                }
            }
        }
    }
}
