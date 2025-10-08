//
//  OccupationFeature.swift
//  FlowFolio
//
//  Created by 황동혁 on 10/2/25.
//

import Foundation
import ComposableArchitecture


@Reducer
struct OccupationFeature {
    
    @ObservableState		
    struct State: Equatable {
        ///선택된 직업
        var selectedOccupation : Occupation = .planner
    }
    
    enum Action {
        ///직업카드 선택할때 발동되는 함수
        case occupationSelected(Occupation)
        ///선택완료 버튼 눌렀을때 발동되는 함수
        case confirmButtonTapped
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce{ state , action in				
            switch action {
                
            case let .occupationSelected(occupation):
                state.selectedOccupation = occupation
                return .none
                
            case .confirmButtonTapped:
                // API 함수 처리
                return .none
            }
            
        }
    }
    
}

