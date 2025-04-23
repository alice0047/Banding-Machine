//
//  TopicCategory.swift
//  project2
//
//  Created by Youbin on 4/16/25.
//

import Foundation

enum TopicCategory: String, Codable, CaseIterable {
    case career = "진로/커리어"
    case friendship = "친해지기"
    case insight = "인사이트"
    case worry = "고민"
}

struct Topic: Identifiable, Codable {
    var id: String                // Firestore document ID
    var title: String             // 질문 내용 (예: "첫 회사는 어떻게 선택하셨어요?")
    var category: TopicCategory   // 분류 (진로, 고민 등)
}

extension TopicCategory {
    //카테고리 출력
    static var displayNames: [String] {
        TopicCategory.allCases.map { $0.rawValue }
    }
    
    var dummyTopics: [String] {
        switch self {
        case .career:
            return [
                "첫 회사는 어떻게 선택하셨어요?",
                "직무 경험을 쌓는 방법이 궁금해요",
                "이력서를 어떻게 작성해야 할까요?",
                "포트폴리오 어떻게 구성하나요?",
                "취업 준비 초반에 어떤 역량이 키우려고 가장 노력하셨나요?",
                "스펙 관리는 어떻게 하셨어요?"
            ]
        case .friendship:
            return [
                "요즘 빠져있는 취미 있으신가요?",
                "퇴근 후에는 보통 뭘 하세요?",
                "MBTI가 어떻게 되세요?",
                "요즘 좋아하는 콘텐츠가 있나요?"
            ]
        case .insight:
            return [
                "가장 인상 깊었던 프로젝트는 무엇인가요?",
                "요즘 관심 있는 기술 트렌드는 뭔가요?"
            ]
        case .worry:
            return [
                "친구 관계가 힘들어요",
                "자존감이 너무 낮아요",
                "스트레스 해소법이 궁금해요"
            ]
        }
    }
}
