//
//  WriteModeHelper.swift
//  project2
//
//  Created by Youbin on 4/22/25.
//

import Foundation

/// 메시지 작성/수정 모드
enum WriteMode {
    case create
    case edit(existingMessage: MessageInfo)
}

extension WriteMode {
    /// 네비게이션 타이틀
    var navigationTitle: String {
        switch self {
        case .create: return "메시지 작성"
        case .edit: return "메시지 수정"
        }
    }

    /// 메인 버튼 텍스트
    var buttonText: String {
        switch self {
        case .create: return "등록하기"
        case .edit: return "수정하기"
        }
    }
}
