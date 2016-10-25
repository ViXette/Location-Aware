//
//  ViewController.swift
//  Location Aware
//
//  Created by VX on 24/10/2016.
//  Copyright © 2016 VXette. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate
{
	var manager = CLLocationManager()

	@IBOutlet weak var lat_Label: UILabel!
	@IBOutlet weak var lon_Label: UILabel!
	@IBOutlet weak var course_Label: UILabel!
	@IBOutlet weak var speed_Label: UILabel!
	@IBOutlet weak var alt_Label: UILabel!
	@IBOutlet weak var address_Label: UILabel!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		manager.delegate = self
		manager.desiredAccuracy = kCLLocationAccuracyBest
		manager.requestWhenInUseAuthorization()
		manager.startUpdatingLocation()
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
	{
		let location = locations[0]
			
		self.lat_Label.text = String(location.coordinate.latitude)
		self.lon_Label.text = String(location.coordinate.longitude)
		self.course_Label.text = String(location.course)
		self.speed_Label.text = String(location.speed)
		self.alt_Label.text = String(location.altitude)
		
		CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
			if error != nil {
				print(error)
			} else {
				if let placemark = placemarks?[0] {
					var address = ""
					if placemark.subThoroughfare != nil { address += placemark.subThoroughfare! + " " }
					if placemark.thoroughfare != nil { address += placemark.thoroughfare! + "\n" }
					if placemark.subLocality != nil { address += placemark.subLocality! + "\n" }
					if placemark.subAdministrativeArea != nil { address += placemark.subAdministrativeArea! + "\n" }
					if placemark.postalCode != nil { address += placemark.postalCode! + "\n" }
					if placemark.country != nil { address += placemark.country! + "\n" }
					
					self.address_Label.text = address
				}
			}
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

