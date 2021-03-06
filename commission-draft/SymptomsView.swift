//
//  SymptomsView.swift
//  commission-draft
//
//  Created by Julie Rhee on 1/5/22.
//

import SwiftUI

struct result: Codable, Hashable {
    var illness: String
    var medicine: String
    var symptoms: Array<String>
}

struct SymptomsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool
//    @State var showSymptom: Bool = false
    let illness_list: Array<String> = ["감기", "보약", "소화기", "치료약", "변비", "기타"]
    
    func getJson() -> [result]{
        let url = Bundle.main.url(forResource: "symptoms", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let results = try? decoder.decode([result].self, from: data)
        return results!
    }
    
    func getNumber(illness: String) -> Int{
        var cnt: Int = 0
        
        if illness == "기타"{
            for item in getJson(){
                if !illness_list.contains(item.illness){
                    cnt += 1
                }
            }
        }
        
        else{
            for item in getJson(){
                if item.illness == illness{
                    cnt += 1
                }
            }
        }

        return cnt
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                
                Color.offWhite
                    .ignoresSafeArea(.all)
                
                VStack{
                    
                    Spacer()
                    
                    HStack{
                        Text("병고")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                        Spacer()
                    }.padding(.leading, 50)
                    
                    Spacer()
                    
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 50, maximum: 200), spacing: 25, alignment: .top),
                        GridItem(.flexible(minimum: 50, maximum: 200), spacing: 25),
                    ], alignment: .center, spacing: 25, content: {
                        ForEach(illness_list, id: \.self){ illness in
                            let number = getNumber(illness: illness)
                            Symptom(showSymptom: self.$isPresented, specific: illness, number: number)
                        }
                    }).padding(.horizontal, 50)
                    
                    Spacer()
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }){
                        
                        HStack{
                            Image(systemName: "arrow.down")
                            Text("닫기")
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                        )
                    }
                    
                    Spacer()
                    
                } // VStack
            } // ZStack
            
        } // Naview
        
    }
}

struct Symptom: View {
    @Binding var showSymptom: Bool
    @State var specific: String
    var number: Int
    
    var body: some View {
        
        VStack(alignment:.leading){
            
            HStack{
                Image(systemName: "star") // change to different image
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .topLeading)
//                        .cornerRadius(22)
                Spacer()
            }
            .padding(.leading, 5)
            
            VStack(alignment:.leading, spacing:5){
                Text(specific)
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack(spacing:5){
                    Text(String(number))
                    Text("가지")
                }
                .font(.headline)
                
                NavigationLink(destination: MedicineView(isPresented: $showSymptom, illness: $specific)){
                            
                    Text("보기")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding(10)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.offWhite)
                        )

                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .navigationViewStyle(StackNavigationViewStyle())
                .padding(.top, 10)
                
            }
            .padding([.horizontal, .top], 10)
            
                    
        }
        .foregroundColor(.black)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
        )

    }
}

struct SymptomsView_Previews: PreviewProvider {
    static var previews: some View {
        SymptomsView(isPresented: .constant(true))
    }
}
