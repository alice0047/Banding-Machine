//
//  TopicOptions.swift
//  project2
//
//  Created by Youbin on 4/16/25.
//

import Foundation

enum TopicCategory: String {
    case career = "진로/커리어"
    case worry = "고민"
    // 필요한 카테고리 추가
}

struct TopicOptions {
    static let all: [TopicCategory: [String]] = [
        .career: [
            "어떤 직무가 저한테 맞을까요?",
            "직무 경험을 쌓는 방법이 궁금해요",
            "이력서를 어떻게 작성해야 할까요?",
            "포트폴리오 어떻게 구성하나요?"
        ],
        .worry: [
            "친구 관계가 힘들어요",
            "자존감이 너무 낮아요",
            "스트레스 해소법이 궁금해요"
        ]
    ]
}
