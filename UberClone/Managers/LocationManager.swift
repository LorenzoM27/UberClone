//
//  LocationManager.swift
//  UberClone
//
//  Created by Lorenzo Menino on 31/07/2024.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        // Most accurate possible for user location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // request user location
        locationManager.requestWhenInUseAuthorization()
        // update user location, we have access to it
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        // permet de ne pas consgtamment mettre à jour la location. une fois qu'on l'a récupérer on arrete
        locationManager.stopUpdatingLocation()
    }
}
