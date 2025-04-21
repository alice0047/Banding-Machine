//
//  MessageWriteViewModel.swift
//  project2
//
//  Created by Youbin on 4/20/25.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

@MainActor
class WriteMessageViewModel: ObservableObject {
    @Published var isMessageSaved: Bool = false

    func saveMessage(
            nickname: String,
            imageURL: String,
            category: TopicCategory,
            topic: String,
            content: String
        ) async {
            let db = Firestore.firestore()
            let messageID = UUID().uuidString
            let now = Date()

            let message = MessageInfo(
                id: messageID,
                runnerID: nickname,
                runnerImageURL: imageURL,
                mentorID: "Isaac", //TODO: 추후 연결
                topic: topic,
                content: content,
                category: category,
                createdAt: now,
                replyCount: 0
            )

            do {
                try db.collection("messages").document(messageID).setData(from: message)
                isMessageSaved = true
                print("✅ 메시지 저장 성공")
            } catch {
                print("❌ 메시지 저장 실패: \(error.localizedDescription)")
            }
        }
}
