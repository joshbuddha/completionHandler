//
//  InfiniteDrive.swift
//  CompletionHandler
//
//  Created by Josh Kneedler on 12/26/18.
//  Copyright © 2018 Josh Kneedler. All rights reserved.
//

import Foundation

//1. Use a typealias to define the structure of the closure. This takes 1 input paramter which is the HeartOfGold enum. The return value is void.
typealias HeartCompletion = (HeartOfGold)->()

//2. Define the HeartOfGold enum. It defines the ship destinations and 2 nested enums that define inventory and anxiety level.
enum HeartOfGold {
    
    case Earth(ArthurItem, PanicLevel)
    case VogonHold(ArthurItem, PanicLevel)
    case RestaurantAtEndOfUniverse(ArthurItem, PanicLevel)

    enum ArthurItem: String {
        case Towel
        case BabelFish
        case Peanuts
    }
    
    enum PanicLevel: String {
        case Panic = "Panic!"
        case DontPanic = "Don't Panic!"
    }
    
    var description: String {
        switch self {
            
        case .Earth(.Peanuts, .DontPanic):
            return "On earth with \(ArthurItem.Peanuts.rawValue). \(PanicLevel.DontPanic.rawValue)"
        case .RestaurantAtEndOfUniverse(.BabelFish,.DontPanic):
            return "At the restaurant talking to new friends with \(ArthurItem.BabelFish.rawValue). \(PanicLevel.DontPanic.rawValue)"
        case .VogonHold(.Towel,.Panic):
            return "In the vogon hold with trusty \(ArthurItem.Towel.rawValue). \(PanicLevel.Panic.rawValue)"
        default:
            return ""
        }
        
    }

}

//3. The InfiniteDrive class will let us decide where to travel to.
class InfiniteDrive {
    //define class var to hold enum data
    var heartOfGold: HeartOfGold?
    
    func startDrive() {
        
        //choose your destination. 0: Earth, 1: Vogon Hold, 2: Restaurant
        //pass the the closure so that the data will be available after the work is complete
        travelTheGalaxy(location: 0) { [unowned self] (heart: HeartOfGold) -> () in

            self.heartOfGold = heart
            
            guard let heartData = self.heartOfGold else {
                return
            }
            
            print("Welcome Arthur: ", heartData)
            print("You are: ", heartData.description)
        }
    }
    
    //accept the location argument to choose destination.
    //set the @escaping attribute because the HeartCompletion closure is invoked AFTER the function returns.
    //the HeartCompletion closure structure is defined by the type alias above: typealias HeartCompletion = (HeartOfGold)->()
    func travelTheGalaxy(location: Int, completion: @escaping HeartCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
            // It takes 2 seconds to travel the galaxy.
            // Now that time has passed you can now call the completion handler to let the original caller know the work is complete.
            print("Infinite Improbability Drive is fired up. Time to go.")
            switch location {
            case 0:
               self.heartOfGold = HeartOfGold.Earth(.Peanuts, .DontPanic)
            case 1:
                self.heartOfGold = HeartOfGold.VogonHold(.Towel, .Panic)
            case 2:
                self.heartOfGold = HeartOfGold.RestaurantAtEndOfUniverse(.BabelFish, .DontPanic)
            default:
                print("")
            }
            
            guard let heartData = self.heartOfGold else {
                return
            }
            
            completion(heartData)
        }
    }
    
}
