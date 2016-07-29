//
//  ViewController.swift
//  test
//
//  Created by Deney on 15/6/16.
//  Copyright © 2016年 Brandsh. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

//MARK: life cycle

class ViewController: UIViewController,MKMapViewDelegate ,CLLocationManagerDelegate{

    var map : MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        ConManager.sharedInstance.downLoadDataFromServer(url: "http://img.9ku.com/geshoutuji/singertuji/1/15216/15216_2.jpg", handle: { (totleByte, currentByte) in
//            print("progress: \(currentByte/totleByte) totle:\(totleByte) ")
//            print("current:\(currentByte)")
//            }) { (destinationURL) in
//                print("url:\(destinationURL)")
//        }
        
//        Alamofire.request(download(NSURLRequest.init(URL: NSURL.init(string: "http://img.9ku.com/geshoutuji/singertuji/1/15216/15216_2.jpg")), destination: { (<#NSURL#>, <#NSHTTPURLResponse#>) -> NSURL in
//            <#code#>
//        }))
        
        let clManager = CLLocationManager()
        clManager.delegate = self
        clManager.requestWhenInUseAuthorization()
        clManager.requestAlwaysAuthorization()
        clManager.startUpdatingLocation()
        
        map = MKMapView.init(frame: self.view.bounds)
        map!.showsUserLocation = true
        map!.delegate = self
        map?.showsScale = true
        map?.showsCompass = true
        map?.showsBuildings = true
        map?.userTrackingMode = MKUserTrackingMode.None
        self.view.addSubview(map!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: MKMapViewDelegate
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        map?.setCenterCoordinate(userLocation.coordinate, animated: true)
        map?.region = MKCoordinateRegion.init(center: userLocation.coordinate, span: MKCoordinateSpan.init(latitudeDelta:0.001, longitudeDelta:0.001))
        
    }
    
    
    //MARK: CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
    }

    
}

