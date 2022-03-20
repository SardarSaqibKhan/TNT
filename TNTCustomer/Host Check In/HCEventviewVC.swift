//
//  HCEventviewVC.swift
//  UserGuestTNT
//
//  Created by abdul on 12/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HCEventviewVC: UIViewController , CLLocationManagerDelegate , MKMapViewDelegate{

    @IBOutlet weak var HostImage: UIImageView!
    
    @IBOutlet weak var Hostname: UILabel!
    @IBOutlet weak var Hostdesc: UILabel!
    @IBOutlet weak var Hostaddress: UILabel!
    
    @IBOutlet weak var mapview: UIView!
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var surveyBtn: UIButton!
    @IBOutlet weak var checkinBtn: UIButton!
    
    
    
    var location = CLLocation()
    let manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        setdesign()
        
       // map.showsUserLocation = true
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func surveyBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HCsurveyVC") as! HCsurveyVC
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func checkinBtnAction(_ sender: Any) {
        latlongchecking()
        
    }
    
    @IBAction func backBtnACtion(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
extension HCEventviewVC
{
    func setdesign()
    {
        mapview.HCcarveshadowradius(shadowRadius: 5)
        surveyBtn.HCcarveNextButton()
        checkinBtn.HCcarveNextButton()
        HostImage.HCcircleImage()
    }
}
extension HCEventviewVC
{
    
  

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]

        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        self.location  = location
       // map.setRegion(region, animated: true)

//        print(location.altitude)
//        print(location.speed)
    }
    
    func latlongchecking()
    {
        let coordinate1 = CLLocation(latitude:33.626057, longitude:73.071442)
        let coordinate2 = CLLocation(latitude:33.6938, longitude: 73.0652)
       
        let distance = location.distance(from: coordinate2) / 1000
        print(distance)
        if(distance <= 100)
        {
            checkin()
        }
        else
        {
            let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HCcheckinpopupVC") as! HCcheckinpopupVC
            
            popVC.labelstring = "You are not in range to checkin this event "
            //popVC.dateDelegate = self
            popVC.modalPresentationStyle = .overCurrentContext
            popVC.modalTransitionStyle = .crossDissolve
            self.present(popVC, animated: true, completion: nil)
            
            // out of 1 mile
        }
        
        

    }
}
extension HCEventviewVC
{
    func checkin()
    {
        HCDBManger.manager.membercheckin(EventID: 1, MemberID: 3) { (res) in
            if res
            {
                let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HCcheckinpopupVC") as! HCcheckinpopupVC
                
                popVC.labelstring = "You have check In Sucessfully "
                //popVC.dateDelegate = self
                popVC.modalPresentationStyle = .overCurrentContext
                popVC.modalTransitionStyle = .crossDissolve
                self.present(popVC, animated: true, completion: nil)
            }
            else
            {
                let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HCcheckinpopupVC") as! HCcheckinpopupVC
                
                popVC.labelstring = "Network error please check your connection and try again"
                //popVC.dateDelegate = self
                popVC.modalPresentationStyle = .overCurrentContext
                popVC.modalTransitionStyle = .crossDissolve
                self.present(popVC, animated: true, completion: nil)
            }
        }
    }
}
