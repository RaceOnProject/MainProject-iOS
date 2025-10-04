//
//  LoginView.swift
//  FlowFolio
//
//  Created by 조성민 on 9/24/25.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    let store: StoreOf<LoginFeature>
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            logo
            
            Spacer()
            
            kakaoLoginButton
                .padding(.horizontal, 16)
            
            googleLoginButton
                .padding(.horizontal, 16)
        }
        .padding(.bottom, 85)
    }
    
    var logo: some View {
        Text("FlowFolio") // TODO: 폰트 적용
    }
    
    var kakaoLoginButton: some View {
        Button {
            
        } label: {
            HStack(spacing: 12) {
                Spacer()
                
                Image(.kakao)
                
                Text("카카오 로그인") // TODO: 폰트 적용
                    .foregroundColor(Color("KakaoText")) // TODO: 디자인 시스템 적용 후 색상 수정
                
                Spacer()
            }
        }
        .frame(height: 56)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("KakaoPrimary")) // TODO: 디자인 시스템 적용 후 색상 수정
        }
    }
    
    var googleLoginButton: some View {
        Button {
            
        } label: {
            HStack(spacing: 12) { // TODO: 디자인은 15인데 공식 디자인 가이드는 12임 확인 필요
                Spacer()
                
                Image(.google)
                
                Text("Google") // TODO: 디자인 시스템 적용 후 폰트 적용
                    .foregroundColor(Color("GoogleText")) // TODO: 디자인 시스템 적용 후 색상 수정
                +
                Text(" 계정으로 로그인")
                    .foregroundColor(Color("GoogleText"))
                
                Spacer()
            }
        }
        .frame(height: 56)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("GoogleNeutral")) // TODO: 디자인 시스템 적용 후 색상 수정
        }
    }
}
