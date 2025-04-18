//
//  Comment.swift
//  project2
//
//  Created by Youbin on 4/17/25.
//

import Foundation

struct Comment: Identifiable, Codable {
    var id: String
    var messageID: String            // 어떤 게시글에 달린 댓글인지
    var author: UserInfo            // 작성자 정보 (닉네임, 프로필 이미지 포함)
    var content: String
    var createdAt: Date
}

