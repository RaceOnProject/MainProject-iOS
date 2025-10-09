//
//  Occupation.swift
//  FlowFolio
//
//  Created by 황동혁 on 10/2/25.
//

import Foundation

enum Occupation: CaseIterable {
    case planner
    case designer
    case developer
    var data: SelectJobCellData {
        switch self {
        case .planner:
            return SelectJobCellData(
                title: "기획자",
                subtitle: "서비스 기획, 기능 정의,\n프로덕트 전정 관리, 데이터 분석",
                imageName: "lightbulb.fill"
            )
        case .designer:
            return SelectJobCellData(
                title: "디자이너",
                subtitle: "UI 디자인, 웹/앱 디자인,\n로그 디자인, 프로토타입 제작",
                imageName: "paintbrush.fill"
            )
        case .developer:
            return SelectJobCellData(
                title: "개발자",
                subtitle: "웹 개발, 앱 개발, 서버 구축·관리,\n기능 개발 및 유지보수",
                imageName: "laptopcomputer"
            )
        }
    }
}
