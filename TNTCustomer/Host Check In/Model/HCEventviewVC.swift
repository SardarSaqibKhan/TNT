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
    
    
    var event = HCEvent()
    
    var location = CLLocation()
    
    let manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        setdesign()
        
      
        loaddata()
        
        
       // map.showsUserLocation = true
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let user = UserDefaults.standard.value(forKey: "Submitted")
        {
            if (user as! Bool)
            {
                UserDefaults.standard.set(false, forKey: "Submitted")
                showToasts(message: "Submitted", senderView: self)
            }
        }
    }
    

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        // let cpa = annotation as! CustomPointAnnotation
        
        // anView!.layer.cornerRadius =  (anView?.frame.height)! / 2
        
        // var img : UIImage = UIImage(named:"icon-facebook")!
        var img = UIImage()
        if let hostimg = HostImage.image
        {
            img = hostimg
            
            let imageLayer = CALayer()
            imageLayer.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            imageLayer.contents = img.cgImage
            imageLayer.cornerRadius = imageLayer.frame.size.width / 2
            imageLayer.masksToBounds = true
            imageLayer.borderWidth = 4.0
            imageLayer.borderColor = UIColor.white.cgColor
            anView!.layer.addSublayer(imageLayer)
            anView!.frame = imageLayer.frame
        }
        else
        {
            
        }
        
        //var img1 = Mapimage.mapimage.resizeImage(image: img, targetSize: CGSize(width: 50.0, height: 50.0))
        //        anView?.calloutOffset = CGPoint(x: 0, y: -10)
        //        anView!.image = img1
        // anView!.layer.masksToBounds = true
        // anView!.clipsToBounds = true
        
        
        
        return anView
    }
    
    @IBAction func surveyBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HCsurveyVC") as! HCsurveyVC
        vc.eventid = String(event.EventId)
        vc.event = event
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func checkinBtnAction(_ sender: Any) {
        latlongchecking()
        
    }
    
    @IBAction func backBtnACtion(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
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
    func loaddata()
    {
        let path="\(ftpIP)\(event.EventHostProfileImage)"
        print(path)
        let imgUrl = URL(string: path)
        self.HostImage.pin_updateWithProgress = true
        self.HostImage
            .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "avatar"))
        Hostname.text = event.EventHostName
        Hostdesc.text = event.EventHostDescription
        Hostaddress.text = event.EventHostAddress
        
       
        
       
        
       
        
        var ann = CustomPointAnnotation()
        ann.coordinate = CLLocationCoordinate2D(latitude: Double(event.Latitude)!, longitude: Double(event.Longitude)!)
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let myLocation:CLLocationCoordinate2D = ann.coordinate
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        ann.imageName = "icon_about_us"
         map.setRegion(region, animated: true)
        map.addAnnotation(ann)
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
       // let coordinate1 = CLLocation(latitude:33.626057, longitude:73.071442)
        let coordinate2 = CLLocation(latitude: Double(event.Latitude) as! CLLocationDegrees, longitude: Double(event.Longitude) as! CLLocationDegrees)
       
        let distance = location.distance(from: coordinate2) / 1000
        print(distance)
        if(distance <= 100)
        {
            checkin()
        }
        else
        {
            let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HCcheckinpopupVC") as! HCcheckinpopupVC
            
            popVC.labelstring = "You are not in range to check in this event "
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
        HCDBManger.manager.membercheckin(EventID: 20, MemberID: 7) { (res) in
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
