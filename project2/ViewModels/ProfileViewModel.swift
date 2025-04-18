//
//  ProfileViewModel.swift
//  project2
//
//  Created by Youbin on 4/18/25.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var nickname: String = ""
    @Published var selectedImage: UIImage? = nil
    @Published var isProfileSaved: Bool = false
    @Published var userInfo: UserInfo?

    //MARK: - 1. 프로필 저장 함수
    func saveProfile() async {
        guard let image = selectedImage else { return }

        do {
            let imageURL = try await uploadProfileImage(image)

            let user = UserInfo(
                id: nickname,            // ✅ 닉네임을 고유 ID로 사용
                name: nickname,
                image: imageURL,
                userType: .runner
            )
            try await saveUserInfo(user: user)
            isProfileSaved = true
        } catch {
            print("❌ 에러 발생: \(error.localizedDescription)")
        }
    }

    //MARK: - 2. 이미지 업로드
    private func uploadProfileImage(_ image: UIImage) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw NSError(domain: "ImageConversion", code: -1)
        }

        let ref = Storage.storage().reference().child("profileImages/\(UUID().uuidString).jpg")
        _ = try await ref.putDataAsync(imageData)
        return try await ref.downloadURL().absoluteString
    }

    //MARK: - 3. Firestore에 저장
    private func saveUserInfo(user: UserInfo) async throws {
        let db = Firestore.firestore()
        try db.collection("users").document(user.id).setData(from: user)
    }
    
    //MARK: - 4. 프로필 정보 가져오기
    func fetchUserInfo(nickname: String) async {
        let docRef = Firestore.firestore().collection("users").document(nickname)
        do {
            let snapshot = try await docRef.getDocument()
            self.userInfo = try snapshot.data(as: UserInfo.self)
            self.nickname = userInfo?.name ?? ""
        } catch {
            print("❌ 사용자 정보 불러오기 실패: \(error)")
        }
    }
}
