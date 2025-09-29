//
//  OccupationView.swift
//  FlowFolio
//
//  Created by 황동혁 on 9/27/25.
//

import SwiftUI

struct OccupationView: View {
    
    ///imageName은 우선 임의로 설정
    let jobData = [
        SelectJobCellData(
            title: "기획자",
            subtitle: "서비스 기획, 기능 정의,\n프로덕트 전정 관리, 데이터 분석",
            imageName: "lightbulb.fill"
        ),
        SelectJobCellData(
            title: "디자이너",
            subtitle: "UI 디자인, 웹/앱 디자인,\n로그 디자인, 프로토타입 제작",
            imageName: "paintbrush.fill"
        ),
        SelectJobCellData(
            title: "개발자",
            subtitle: "웹 개발, 앱 개발, 서버 구축·관리,\n기능 개발 및 유지보수",
            imageName: "laptopcomputer"
        )
    ]
    
    ///선택된 직군 카드뷰 셀의 인덱스
    @State private var selectedIndex: Int = 0
    
  
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading,spacing: 8){
                    Text("환영합니다!")
                        .fontWeight(.light)
                        .foregroundStyle(Color.blue)
                        .font(.title)
                    Text("먼저 직군을 선택해주세요")
                        .fontWeight(.light)
                        .font(.title)
                }
                .padding(.bottom,24)
                Spacer()
            }
            VStack(spacing: 16) {
                ForEach(Array(jobData.enumerated()), id: \.offset) { index, job in
                    SelectJobCell(
                        data: job,
                        isSelected: selectedIndex == index,
                        onTap: {
                            selectedIndex = index
                        }
                    )
                }
            }
            Button{
                let occupation = jobData[selectedIndex].title
                /// store.CreateProfile(occupation:occupation) 과 같이 사용
            } label: {
                Text("선택 완료")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(.top,44)
            }
        }
        .padding(.horizontal,16)
    }
}

#Preview {
    OccupationView()
}

// 직군선택 카드뷰에 들어갈 데이터 모델
struct SelectJobCellData {
    let title: String
    let subtitle: String
    let imageName: String
}

// 직군선택 카드뷰 셀
struct SelectJobCell: View {
    
    ///직군,설명,이미지 데이터 변수
    let data: SelectJobCellData
    
    ///카드뷰 셀이 현재 선택된 상태인지 확인 변수
    let isSelected: Bool
    
    /// 카드뷰 셀이 탭되었을때 발동시킬 함수
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                
                Image(systemName: data.imageName)
                    .font(.system(size: 40))
                    .foregroundColor(isSelected ? .white : .gray)
                    .frame(width: 80, height: 80)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(data.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(isSelected ? .white : .black)
                    
                    Text(data.subtitle)
                        .font(.subheadline)
                        .foregroundColor(isSelected ? .white.opacity(0.8) : .gray)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.blue : Color.gray.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}


