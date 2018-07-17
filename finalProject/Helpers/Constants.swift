//
//  Constants.swift
//  finalProject
//
//  Created by Andrew Jenson on 4/13/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import Foundation

struct Constants {

    struct Now {
        static let selectedIconDisplay = "X"
    }

    struct Segue {
        static let subscribeSegue = "subscribeSegue"
    }

    // MARK: UserDefaults
    
    struct UserDefaults {
        static let currentUser = "currentUser"
        static let uid = "uid"
        static let email = "email"
    }

    // MARK: NotificationKeys

    struct NotificationKeys {
        static let SignedIn = "onSignInCompleted"
    }

    // Journal

    struct SelectedMood {
        static let Button0 = "Sad"
        static let Button1 = "Depressed"
        static let Button2 = "Bored"
        static let Button3 = "Good"
        static let Button4 = "Grateful"

        static let Button5 = "Mad!"
        static let Button6 = "Stressed"
        static let Button7 = "Anxious"
        static let Button8 = "Shy"
        static let Button9 = "Happy!"

        static let Button10 = "Lost"
        static let Button11 = "Lonely"
        static let Button12 = "Jealous"
        static let Button13 = "Proud"
        static let Button14 = "Loved!"
    }

    struct JournalImages {
        static let morning = "morning"
        static let day = "day"
        static let afternoon = "afternoon"
        static let sunset = "sunset"
        static let night = "night"

        static let morning1 = "morning1"
        static let morning2 = "morning2"
        static let morning3 = "morning3"
        static let morning4 = "morning4"
        static let morning5 = "morning5"
        static let morning6 = "morning6"
        static let morning7 = "morning7"

        static let day1 = "day1"
        static let day2 = "day2"
        static let day3 = "day3"
        static let day4 = "day4"
        static let day5 = "day5"
        static let day6 = "day6"
        static let day7 = "day7"

        static let afternoon1 = "afternoon1"
        static let afternoon2 = "afternoon2"
        static let afternoon3 = "afternoon3"
        static let afternoon4 = "afternoon4"
        static let afternoon5 = "afternoon5"
        static let afternoon6 = "afternoon6"
        static let afternoon7 = "afternoon7"

        static let sunset1 = "sunset1"
        static let sunset2 = "sunset2"
        static let sunset3 = "sunset3"
        static let sunset4 = "sunset4"
        static let sunset5 = "sunset5"
        static let sunset6 = "sunset6"
        static let sunset7 = "sunset7"

        static let night1 = "night1"
        static let night2 = "night2"
        static let night3 = "night3"
        static let night4 = "night4"
        static let night5 = "night5"
        static let night6 = "night6"
        static let night7 = "night7"

    }

}
