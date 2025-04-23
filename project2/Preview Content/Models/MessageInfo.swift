//
//  MessageInfo.swift
//  project2
//
//  Created by Youbin on 4/17/25.
//

import Foundation

struct MessageInfo: Identifiable, Codable {
    var id: String
    var runnerID: String
    var runner: String       // 작성자 (러너)
    var runnerImageURL: String       // 작성자 프로필 이미지 URL
    var mentor: String       // 대상 멘토
    var topic: String     // 선택한 토픽 제목
    var content: String
    var category: TopicCategory
    var createdAt: Date
    var replyCount: Int        // 댓글 수 (Firestore 트리거로 자동 증가 가능)
}

