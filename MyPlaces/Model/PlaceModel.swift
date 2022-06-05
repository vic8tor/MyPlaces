//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Victor on 07.05.2022.
//

import UIKit

struct Place {
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var restaurantImage: String?
    
    static let restaurantNames = [
        "Хищник Стейкs & Burgers", "Сабор де ла Вида", "Джумбус", "АНТОНИО",
        "Болоньетта", "Брянский Бык", "Дольче Гриль", "Кофемания",
        "Йоркшир", "Russian pub", "Ткемали", "O2 Lounge",
        "AQ Kitchen", "Брукс", "Стейк'S"
    ]
    
    static func getPlaces() -> [Place] {
        var places = [Place]()
        restaurantNames.forEach{ places.append(Place(name: $0, location: "Москва", type: "Ресторан", image: nil, restaurantImage: $0)) }
        return places
    }
    
}

