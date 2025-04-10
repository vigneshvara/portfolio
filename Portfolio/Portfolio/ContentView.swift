//
//  ContentView.swift
//  Portfolio
//
//  Created by Sakthikumar on 08/04/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ProjectView()
                .tabItem {
                    Image(systemName: "menucard")
                    Text("Project")
                }
        }
        .tint(.black)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
            UITabBar.appearance().unselectedItemTintColor = .gray
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .white
            navBarAppearance.titleTextAttributes = [.font: UIFont(name: "BalsamiqSans-Bold", size: 20)!, .foregroundColor: UIColor.black]
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }
    }
}
