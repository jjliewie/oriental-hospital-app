//
//  MapView.swift
//  commission-draft
//
//  Created by Julie Rhee on 1/1/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var isPresented: Bool
    @State var coordinateRegion = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 56.948889, longitude: 24.106389),
      span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
      Map(coordinateRegion: $coordinateRegion)
        .edgesIgnoringSafeArea(.all)
    }
  }
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(isPresented: .constant(true))
    }
}
