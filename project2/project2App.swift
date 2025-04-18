//
//  project2App.swift
//  project2
//
//  Created by Youbin on 4/15/25.
//

import SwiftUI
import Firebase

@main
struct project2App: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            EditProfileView()
        }
    }
}
