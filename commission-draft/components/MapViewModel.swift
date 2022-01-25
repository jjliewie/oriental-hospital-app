//
//  MapViewModel.swift
//  commission-draft
//
//  Created by Julie Rhee on 1/25/22.
//

import MapKit

enum mapDetails {
    static let start = CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780)
    static let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region =  MKCoordinateRegion(
        center: mapDetails.start, span: mapDetails.span)
    
    var locationManager: CLLocationManager?
    
    func checkLocationEnabled(){
         
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }
        
        else{
            print("location is disabled")
        }
        
    } // check location enabled
    
    
    private func checkLocationAuth(){
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus{
        
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted, likely due to parental controls")
        case .denied:
            print("You have denied this app location permission.")
        case .authorizedAlways, .authorizedWhenInUse:
            
            region = MKCoordinateRegion(center: locationManager.location?.coordinate ?? mapDetails.start, span: mapDetails.span)
            
        @unknown default:
            break
            
        }
    } // check location authorization
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
    
}
