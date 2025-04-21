
//
//  ReadMessageViewModel.swift
//  project2
//
//  Created by Youbin on 4/21/25.
//

import Foundation
import FirebaseFirestore

@MainActor
class ReadMessageViewModel: ObservableObject {
    @Published var messages: [MessageInfo] = []

    private let db = Firestore.firestore()

    func fetchMessages(for nickname: String) async {
        do {
            let snapshot = try await db.collection("messages")
                .whereField("runnerID", isEqualTo: nickname)
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
}
