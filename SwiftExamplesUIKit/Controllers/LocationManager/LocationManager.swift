//
//  LocationManager.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 22/06/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    // MARK: - Public API
    func fetchLocationIfNeeded() {
        
        manager.delegate = self
        
        handleAuthorization(manager.authorizationStatus)
    }
    
    private func handleAuthorization(_ status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            showLocationPermissionAlert()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            manager.requestLocation()
            
        @unknown default:
            break
        }
    }
    
    private func showLocationPermissionAlert() {
        let alertController = UIAlertController(
            title: "Location Access Required",
            message: "Please enable location access in Settings to use this feature.",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        }))
        
        if let topController = UIApplication.shared.windows.first?.rootViewController {
            topController.present(alertController, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        handleAuthorization(status)
    }
    
    // MARK: - Location
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        geocoder.reverseGeocodeLocation(location) {
            placemarks,
            error in
            
            guard error == nil,
                  let postalCode = placemarks?.first?.postalCode,
                  !postalCode.isEmpty else { return }
            
            print("zipcode :", postalCode)
            globalZipCode = postalCode
            
                NotificationCenter.default.post(
                    name: NSNotification.Name("ZipcodeGet"),
                    object: nil
                )
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Location error: ", error.localizedDescription)
    }
}
