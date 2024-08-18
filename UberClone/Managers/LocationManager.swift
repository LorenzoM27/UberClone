//
//  LocationManager.swift
//  UberClone
//
//  Created by Lorenzo Menino on 31/07/2024.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    static let shared = LocationManager() // va fonctionner comme un environnement, on va pouvoir l'utiliser à différents endroits
    @Published var userLocation : CLLocationCoordinate2D?
    
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
// c'est ici qu'on a l'user location
extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.userLocation = location.coordinate
        // permet de ne pas consgtamment mettre à jour la location. une fois qu'on l'a récupérer on arrete
        locationManager.stopUpdatingLocation()
    }
}
