//
//  LoginFeature.swift
//  FlowFolio
//
//  Created by 조성민 on 9/24/25.
//

import ComposableArchitecture

@Reducer
struct LoginFeature {
    @ObservableState
    struct State: Equatable {
    }
    
    enum Action {
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
