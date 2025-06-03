//
//  ViewModel.swift
//  Portfolio
//
//  Created by Sakthikumar on 01/04/25.
//

import SwiftUI

@Observable
class ViewModel {
    var skills = [Skill]()
    var projects = [Project]()
    var education = [Education]()
    var selectedSkill: Skill?
    
    init() {
        loadSkills()
        loadEducation()
        loadProject()
    }
    
    func loadSkills() {
        skills = [Skill(imageName: "swift", name: "Swift", description: "A powerful and intuitive programming language developed by Apple for iOS, macOS, watchOS, and tvOS app development.", version: "6.0", features: [
            "Modern syntax with safety features like optionals and type inference"
            , "Performance optimizations comparable to compiled languages"
            , "Open-source community contributions enhancing its ecosystem"
        ]),
                  Skill(imageName: "swiftui", name: "SwiftUI", description: "A declarative framework by Apple for building user interfaces across all Apple platforms using Swift.​", version: "4.0", features: [
                    "Declarative syntax for intuitive UI development"
                    , "Seamless integration with Combine for reactive programming"
                    , "Live previews in Xcode for real-time UI feedback"
                  ]),
                  Skill(imageName: "uikit", name: "UIKit", description: "A comprehensive framework for constructing and managing iOS applications' graphical, event-driven user interfaces.", version: "16.0", features: [
                    "Extensive library of pre-built UI components"
                    , "Mature and battle-tested framework with extensive documentation"
                    , "Deep integration with Interface Builder for visual design"
                  ])
        ]
    }
    
    func loadEducation() {
        education = [
            Education(qualification: "Bachelor of computer application", place: "Trichy", duration: "June/2019 - April/2022"),
            Education(qualification: "HSC - computer science", place: "Mayiladuthurai", duration: "June/2018 - March/2019")
        ]
    }
    
    func loadProject() {
        projects = [
            Project(description: "Designed and developed an e-commerce application tailored for the Mumbai market, similar to Amazon and Flipkart.", name: "FAIRPICK", applogo: "Fairpick", techUsed: ["UIKit", "AVFoundation", "Firebase", "Razorpay", "Push Notification", "Location Manager", "Google Maps", "Google Places"], images: ["fairpick1", "fairpick2", "fairpick3", "fairpick4", "fairpick5", "fairpick6"], link: []),
            Project(description: "Developed a chat application includes socket for real-time communication.", name: "ECADEMICTUBE: STUDY PARTNER", applogo: "ecademictube", techUsed: ["Socket IO", "AWS S3", "AVFoundation", "Stripe", "Razorpay", "Push Notification", "Notification", "Share Extension"], images: ["fairpick1", "fairpick2", "fairpick3", "fairpick4", "fairpick5", "fairpick6"], link: []),
            Project(description: "Developed an app enabling vehicle owners to manage car rentals, set pricing, schedule availability, and features like rental history, accident policies, and repair tracking to streamline operations and enhance engagement.", name: "VUNDEE: VEHICLE OWNER AND RENTER", applogo: "vundee", techUsed: ["Location Manager", "Google Maps", "Google Places"], images: ["vundee1", "vundee2", "vundee3", "vundee4", "vundee5"], link: []),
            Project(description: "Mac OS application for maintain google calendar events and meeting with enchanced UI and widgets.", name: "GCAL FOR GOOGLE CALENDAR", applogo: "gcal", techUsed: ["Webkit", "WidgetKit", "In-App Purchase"], images: ["gcal1", "gcal2", "gcal3", "gcal4", "gcal5"], link: [])
        ]
    }
}

struct Skill: Identifiable, Hashable {
    
    let id = UUID().uuidString
    let imageName: String
    let name: String
    let description: String
    let version: String
    let features: [String]
    
    init(imageName: String, name: String, description: String, version: String, features: [String]) {
        self.imageName = imageName
        self.name = name
        self.description = description
        self.version = version
        self.features = features
    }
}

struct Education: Identifiable {
    let id = UUID().uuidString
    let qualification: String
    let place: String
    let duration: String
    var isVisible = false
}


struct Project: Identifiable, Hashable {
    let id = UUID().uuidString
    let description: String
    let name: String
    let applogo: String
    let techUsed: [String]
    let images: [String]
    let link: [String]
}
