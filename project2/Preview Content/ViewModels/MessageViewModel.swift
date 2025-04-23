//
//  MessageViewModel.swift
//  project2
//
//  Created by Youbin on 4/22/25.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

@MainActor
class MessageViewModel: ObservableObject {
    @Published var messages: [MessageInfo] = []
    @Published var isMessageSaved: Bool = false

    private let db = Firestore.firestore()

    // MARK: - CREATE
    func saveMessage(
        nickname: String,
        imageURL: String,
        category: TopicCategory,
        topic: String,
        content: String,
        mentor: String
    ) async {
        let messageID = UUID().uuidString
        let now = Date()
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let message = MessageInfo(
            id: messageID,
            runnerID: uid,
            runner: nickname,
            runnerImageURL: imageURL,
            mentor: mentor,
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

    // MARK: - READ
    func fetchMessages(for nickname: String) async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            let snapshot = try await db.collection("messages")
                .whereField("runnerID", isEqualTo: uid)
                .order(by: "createdAt", descending: true)
                .getDocuments()

            let result: [MessageInfo] = snapshot.documents.compactMap { doc in
                try? doc.data(as: MessageInfo.self)
            }

            self.messages = result
            print("✅ \(nickname)의 메시지 \(result.count)개 불러옴")
        } catch {
            print("❌ 메시지 불러오기 실패: \(error.localizedDescription)")
        }
    }

    // MARK: - DELETE
    func deleteMessage(id: String) async {
        do {
            try await db.collection("messages").document(id).delete()
            messages.removeAll { $0.id == id }
            print("🗑 메시지 삭제 완료: \(id)")
        } catch {
            print("❌ 메시지 삭제 실패: \(error.localizedDescription)")
        }
    }

    // MARK: - UPDATE (topic과 content만 수정)
    func updateMessage(id: String, newTopic: String, newContent: String) {
        Task.detached {
            let db = Firestore.firestore()
            do {
                try await db.collection("messages")
                    .document(id)
                    .updateData([
                        "topic": newTopic,
                        "content": newContent
                    ])
                
                // 업데이트 후 UI 상태 반영은 MainActor에서
                await MainActor.run {
                    if let index = self.messages.firstIndex(where: { $0.id == id }) {
                        self.messages[index].topic = newTopic
                        self.messages[index].content = newContent
                    }
                }
                print("✏️ 메시지 내용 수정 완료")
            } catch {
                print("❌ 메시지 수정 실패: \(error.localizedDescription)")
            }
        }
    }
}
