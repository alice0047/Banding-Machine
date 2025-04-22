//
//  project2App.swift
//  project2
//
//  Created by Youbin on 4/15/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct project2App: App {
    init() {
        FirebaseApp.configure()
        
        // ✅ 앱 실행 시 익명 로그인 시도
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    print("❌ 익명 로그인 실패: \(error.localizedDescription)")
                } else {
                    print("✅ 익명 로그인 성공 → UID: \(result?.user.uid ?? "")")
                }
            }
        }
        
        //TODO: userDefault 테스트용!
        // ✅ 앱 실행 시 바로 nickname 설정
//        UserDefaults.standard.set("Bin", forKey: "nickname")
//        UserDefaults.standard.set("https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzA5MDhfMTI4%2FMDAxNjk0MTA0MDY5Nzc2.9UpHY0G77atOylgGcG6oiU1pYT7N8zevGSWF5jI2kiUg.5iXs6wa8CjqqoyjVqmBYBLya_prfPlxHMSBHmB2VGhQg.JPEG.adnerwin%2FIMG_1087.JPG&type=a340", forKey: "profileImageURL")
    }
    
    var body: some Scene {
        WindowGroup {
            EditProfileView()
        }
    }
}
