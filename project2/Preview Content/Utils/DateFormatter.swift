//
//  DateFormatter.swift
//  project2
//
//  Created by Youbin on 4/20/25.
//

import Foundation

/// 날짜 관련 포맷터들을 모아둔 유틸 파일
enum DateUtils {
    static func formatDate(_ date: Date, format: String = "yyyy.MM.dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
