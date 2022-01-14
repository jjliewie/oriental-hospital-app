//
//  QaView.swift
//  commission-draft
//
//  Created by Julie Rhee on 1/5/22.
//

import SwiftUI

struct QaView: View {
    @Binding var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 25){
                
                Spacer()
                
                HStack{
                    
                    Text("Q & A : 보험한약이란?")
                    .font(.title)
//                    .padding(.top, 30)
                    
                    Spacer()
                    
                } // HStack
                .padding(.leading, 50)
                
                
                QA(question: "Q1. 보험 한약은 어떤 장점이 있나요?", answers: [
                    "- 가격이 매우 저렴합니다. (처방 기간에 따라 다르지만, 대부분 몇 천원 정도 나옵니다.)",
                    "- 한의원에서 당일에 바로 처방을 받을 수 있습니다.",
                    "- 짧은 기간(ex) 하루, 이틀)도 사용이 가능합니다."
                ])
                QA(question: "Q2. 어떤 약들이 있나요?", answers: [
                    "- 감기, 변비, 소화기 계통, 호흡기계통, 보약 및 기타 다양한 증상에 응용가능한 한약들로 이루어져 있습니다."
                ])
                QA(question: "Q3. 한의사랑 상담이 꼭 필요한가요?", answers: [
                "- 안전한 약 처방을 위해서, 혹시 다른 건강 상태에 관련해서 물어보시는 좋은 기회가 될 겁니다. 상담해서 더 잘 맞는 약을 찾게 되면 일석이조!"
                ])
                QA(question: "Q4. 안전한 약들인가요?", answers: [
                "- 모든 약이 완전히 안전한 건 아니지만, 상담 후 안전하게 사용하시면 됩니다."
                ])
                QA(question: "Q6. 아무 한의원이나 가도 보험한약을 찾을 수 있나요?", answers: [
                    "- 제가 한약을 취급하는 곳을 지도에 표시해드릴게요",
                    "- 전화로 한의원에 한 번 물어보시고 가세요"
                ])
                
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    
                    HStack{
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                    )
                }
                
                
            } // VStack
            
        } // ZStack
        
    }
}

struct QA: View{
    
    var question: String
    var answers: Array<String>
    
    var body: some View {
        
        VStack(alignment:.leading, spacing:10){
            
            Text(question)
                .font(.title3)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
                .padding(.bottom, 10)
            
            ForEach(answers, id: \.self){ answer in
                Text(answer)
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
            }
            
        } // VStack
        .padding(.horizontal,50)
    }
}

struct QaView_Previews: PreviewProvider {
    static var previews: some View {
        QaView(isPresented: .constant(true))
    }
}
