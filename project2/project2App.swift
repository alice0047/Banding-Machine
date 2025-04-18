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
    
    //TODO: userDefault 테스트용!
    @AppStorage("nickname") var nickname: String = ""
    
    var body: some Scene {
        WindowGroup {
            MyPageView()
                .onAppear {
                    nickname = "Bin" // ✅ 테스트용 닉네임 설정
                }
        }
    }
}
