//
//  HospitalView.swift
//  commission-draft
//
//  Created by Julie Rhee on 1/3/22.
//

import SwiftUI

struct HospitalView: View {
    
    let hospital : product
    
    var body: some View {
        
        ZStack{
            Color.offWhite
                .ignoresSafeArea(.all)
            Text(hospital.name)
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

//struct HospitalView_Previews: PreviewProvider {
//    static var previews: some View {
//        HospitalView()
//    }
//}
