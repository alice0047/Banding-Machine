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
    @Published var updatedImageURL: String? = nil /// UserDefaults 갱신용
    
    //MARK: - 1. 프로필 저장 함수 (MakeProfileView 전용)
    func saveProfile() async {
        guard let image = selectedImage,
              let uid = Auth.auth().currentUser?.uid else { return }
        
        do {
            let imageURL = try await uploadProfileImage(image)
            
            let user = UserInfo(
                id: uid, // ✅ 이제 UID 사용
                name: nickname,
                image: imageURL,
                userType: .runner
            )
            try await saveUserInfo(user: user)
            
            self.updatedImageURL = imageURL
            self.isProfileSaved = true
        } catch {
            print("❌ 프로필 저장 실패: \(error.localizedDescription)")
        }
    }
    
    //MARK: - 2. 프로필 수정 (EditProfileView 전용)
    func updateProfile() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        do {
            var updates: [String: Any] = [ "name": nickname ]
            
            if let image = selectedImage {
                let imageURL = try await uploadProfileImage(image)
                updates["image"] = imageURL
                self.updatedImageURL = imageURL
            }
            
            try await updateUserInfo(documentID: uid, updates: updates)
            self.isProfileSaved = true
        } catch {
            print("❌ 프로필 업데이트 실패: \(error.localizedDescription)")
        }
    }
    
    //MARK: - 3. Firebase Storage에 이미지 업로드
    private func uploadProfileImage(_ image: UIImage) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw NSError(domain: "ImageConversion", code: -1)
        }
        
        let ref = Storage.storage().reference().child("profileImages/\(UUID().uuidString).jpg")
        _ = try await ref.putDataAsync(imageData)
        return try await ref.downloadURL().absoluteString
    }
    
    // MARK: - 4. Firestore에 전체 저장 (최초 생성용)
    private func saveUserInfo(user: UserInfo) async throws {
        let db = Firestore.firestore()
        try db.collection("users").document(user.id).setData(from: user)
    }
    
    // MARK: - 5. Firestore에서 일부 필드만 업데이트 (닉네임, 이미지)
    private func updateUserInfo(documentID: String, updates: [String: Any]) async throws {
        let db = Firestore.firestore()
        try await db.collection("users").document(documentID).updateData(updates)
    }
    
    // MARK: - 6. URL → UIImage 변환 (기존 이미지 불러올 때)
    func downloadImage(from urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }
}
