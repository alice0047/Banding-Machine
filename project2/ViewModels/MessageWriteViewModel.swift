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
class MessageWriteViewModel: ObservableObject {
    @Published var isMessageSaved: Bool = false

    func saveMessage(
            nickname: String,
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
                mentorID: "mentor123", // 추후 선택 연결
                topic: topic,
                content: content,
                category: category,
                createdAt: now,
                replyCount: 0
            )

            do {
                let messageData: [String: Any] = [
                    "id": message.id,
                    "runnerID": message.runnerID,
                    "mentorID": message.mentorID,
                    "topic": message.topic,
                    "content": message.content,
                    "category": message.category.rawValue,
                    "createdAt": Timestamp(date: message.createdAt),
                    "replyCount": message.replyCount
                ]
                
                try await db.collection("messages").document(message.id).setData(messageData)
                    isMessageSaved = true
                    print("✅ 메시지 저장 성공")
            } catch {
                print("❌ 메시지 저장 실패: \(error.localizedDescription)")
            }
        }
}
