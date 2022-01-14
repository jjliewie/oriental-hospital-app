//
//  ContentView.swift
//  commission-draft
//
//  Created by Julie Rhee on 1/1/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showQa = false
    @State private var showSearch = false
    @State private var showSymptom = false
        
    var body: some View {
                
        NavigationView {
            
            ZStack{
                
                Color.offWhite
                    .ignoresSafeArea()
                
                VStack(spacing:30){
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing:10){
                            Text("보험 한약")
                                .font(.title)
                            Text("저렴하게 당신의 증상을 치료하세요")
                                .font(.title2)
                        } // VStack
                        
                        .padding(.top, 30)
                        
                        Spacer()
                        
                    } // HStack
                    .padding(.leading, 50)
                    
                    
                    About(showQa: $showQa)
                        .padding(.horizontal, 50)
                    
                    HStack(spacing:20){
                        SearchMap(showSearch: $showSearch)
                        SearchSymptom(showSymptom: $showSymptom)
                    }
                    .padding(.horizontal, 50)
                    
                    
                    Spacer()
                    
                } // VStack

                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            
            // ZStack
        } // Nav View
    } // Body
} // View

struct SearchSymptom: View{
    
    @Binding var showSymptom: Bool
        
    var body: some View {
        VStack{
            
            Button(action: {
                showSymptom = true
            }) {
                HStack{
                    Text("증상")
                    Image(systemName: "arrow.right")
                    Text("한약")
                }
                .foregroundColor(.black)
                .padding(10)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.offWhite)
                )
            }
            .fullScreenCover(isPresented: $showSymptom) {
                SymptomsView(isPresented: $showSymptom)
            }

            Image(systemName: "cursorarrow.rays") // picture
                .resizable()
                .scaledToFit()
                .cornerRadius(22)
                .padding()
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gradColor_blue)
        )
        
    }
}

struct SearchMap: View{
    
    @Binding var showSearch: Bool
    
    var body: some View {
        VStack{
            
            Button(action: {
                showSearch = true
            }) {
                
                Text("한의원 찾기")
                .foregroundColor(.black)
                .padding(10)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.offWhite)
                )
            }
            .fullScreenCover(isPresented: $showSearch) {
                SearchView(isPresented: $showSearch)
            }

            Image(systemName: "map") // picture
                .resizable()
                .scaledToFit()
                .cornerRadius(22)
                .padding()
            
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gradColor_blue)
        )
        
    }
}

struct About: View {
    
    @Binding var showQa: Bool
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: 10){
            Text("보험한약이란?")
                .font(.headline)
            
            Text("1. 보건복지부에 의해 급여 혼합엑스제재로  지정된 56종의 한약.")
            Text("2. 다양한 증상 및 일상생활에 흔히 사용할 수 있는 한약들로 구성되어 있습니다.")
            Text("3. 한의사와 간단한 상담이후 처방 가능합니다.")
            
            
            Text("어플 사용법")
                .font(.headline)
            
            Text("1. 증상에 따라서 한약 찾기")
            Text("2. 한약을 구비하고 있는 한의원을 찾기")
            Text("3. 한의사랑 상담 후 맞는 한약 찾기")
            
            Button(action: {
                showQa = true
            }) {
                Text("Q/A 보기")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(10)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.offWhite)
                    )
            }
            .fullScreenCover(isPresented: $showQa) {
                QaView(isPresented: $showQa)
            }
            .padding([.top, .horizontal])
            
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gradColor_blue)
        )
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
