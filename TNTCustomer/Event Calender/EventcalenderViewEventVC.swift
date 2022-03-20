//
//  EventcalenderViewEventVC.swift
//  UserGuestTNT
//
//  Created by abdul on 11/06/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit
import MapKit
import NVActivityIndicatorView
import CoreLocation

class EventcalenderViewEventVC: UIViewController , CLLocationManagerDelegate , MKMapViewDelegate {

    
    //label
    @IBOutlet weak var Eventtitlelabel: UILabel!
    @IBOutlet weak var Eventdeslabel: UILabel!
    @IBOutlet weak var HostName: UILabel!
    @IBOutlet weak var hostdes: UILabel!
    @IBOutlet weak var hostaddress: UILabel!
    
    //images
    
    @IBOutlet weak var hostprofile: UIImageView!
    @IBOutlet weak var websiteimage: UIImageView!
    @IBOutlet weak var facebookimage: UIImageView!
    @IBOutlet weak var tiwtteimage: UIImageView!
    
    //views
    
    @IBOutlet weak var Hostinfopview: UIView!
    @IBOutlet weak var websiteview: UIView!
    @IBOutlet weak var mapandaddressview: UIView!
    
    //map
    
    @IBOutlet weak var map: MKMapView!
    
    //button
    @IBOutlet weak var goingbtn: UIButton!
    @IBOutlet weak var interestedbtn: UIButton!
    
    @IBOutlet weak var notgoingbtn: UIButton!
    
    @IBOutlet weak var Rsvplistbtn: UIButton!
    @IBOutlet weak var RSVPbtn: UIButton!
    
    var custom_annation = CustomPointAnnotation()
    var rsvpreturnvalue = String()
    var evnet = ECEvent()
    var date = String()
    var lat = String()
    var lng = String()
    var statustext = "Going"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date1 = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        date = formatter.string(from: date1)
        
        let ac = ActivityData()
        
        if evnet.EventHostName == ""
        {
            
            
            self.geteevents()
        }
        else
        {
            loaddata()
        }
        
        setdesgin()
        
        
        
        // Do any additional setup after loading the view.
    }
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        print("hrlo")
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
        if let hostimg = hostprofile.image
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
    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func rsvplisttbnaction(_ sender: Any) {
        let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RSVPListVC") as! RSVPListVC
        
        popVC.eventid = String(evnet.EventId)
        //popVC.dateDelegate = self
        
        self.present(popVC, animated: true, completion: nil)
        
    }
    
    @IBAction func RSVPbtn(_ sender: Any) {
       
        
        addrsvp()
        
        
        
        
        //popVC.dateDelegate = self
//        popVC.modalPresentationStyle = .overCurrentContext
//        popVC.modalTransitionStyle = .crossDissolve
//        self.present(popVC, animated: true, completion: nil)
    }
    
    
    @IBAction func webistebtn(_ sender: Any) {
        if evnet.HostWebsiteLink != ""
        {
            if let url = URL(string: evnet.HostWebsiteLink) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    
    @IBAction func fbbtn(_ sender: Any) {
        if evnet.HostFB != ""
        {
            if let url = URL(string: evnet.HostFB) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    @IBAction func twitterbtn(_ sender: Any) {
        if evnet.HostTwitter != ""
        {
            if let url = URL(string: evnet.HostTwitter) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    
    @IBAction func instabtn(_ sender: Any) {
        if evnet.HostInstagram != ""
        {
            if let url = URL(string: evnet.HostInstagram) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    
    @IBAction func linkedinbtn(_ sender: Any) {
        if evnet.HostLinkedIn != ""
        {
            if let url = URL(string: evnet.HostLinkedIn) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    @IBAction func goingbtnaction(_ sender: Any) {
        
        statustext = "Going"
        goingbtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        goingbtn.backgroundColor = #colorLiteral(red: 0.848572433, green: 0.5695539713, blue: 0.2421401143, alpha: 1)
        
        
         interestedbtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        interestedbtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        notgoingbtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        notgoingbtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    @IBAction func interestedbtnaction(_ sender: Any) {
        
        statustext = "Interested"
        interestedbtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        interestedbtn.backgroundColor = #colorLiteral(red: 0.848572433, green: 0.5695539713, blue: 0.2421401143, alpha: 1)
        
        goingbtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        goingbtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        notgoingbtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        notgoingbtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
    }
    @IBAction func notgoingbtnaction(_ sender: Any) {
        
        statustext = "NotGoing"
        notgoingbtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        notgoingbtn.backgroundColor = #colorLiteral(red: 0.848572433, green: 0.5695539713, blue: 0.2421401143, alpha: 1)
        
        
        interestedbtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        interestedbtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        goingbtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        goingbtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
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
extension EventcalenderViewEventVC
{
    func setdesgin()
    {
        Hostinfopview.ECcarveshadowradius(shadowRadius: 6)
        websiteview.ECcarveshadowradius(shadowRadius: 6)
        mapandaddressview.ECcarveshadowradius(shadowRadius: 5)
        
        goingbtn.ECroundBuiltView(size: 5)
        goingbtn.layer.shadowRadius = 5
        goingbtn.layer.shadowOpacity = 0.1
        
        interestedbtn.ECroundBuiltView(size: 5)
        interestedbtn.layer.shadowRadius = 5
        interestedbtn.layer.shadowOpacity = 0.1
        
        
        interestedbtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        
        
        notgoingbtn.ECroundBuiltView(size: 5)
        notgoingbtn.layer.shadowRadius = 5
        notgoingbtn.layer.shadowOpacity = 0.1
        
        notgoingbtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        
        
        
        RSVPbtn.ECroundBuiltView(size: 5)
        RSVPbtn.layer.borderWidth = 0.2
        RSVPbtn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        RSVPbtn.layer.shadowRadius = 5
        RSVPbtn.layer.shadowOpacity = 0.1
        
        Rsvplistbtn.ECroundBuiltView(size: 5)
        Rsvplistbtn.layer.borderWidth = 0.2
        Rsvplistbtn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        Rsvplistbtn.layer.shadowRadius = 5
        Rsvplistbtn.layer.shadowOpacity = 0.1
        
        map.ECcarveTopleftRightView(size:5)
        hostprofile.ECRoundProfileImage()
        
        
    }
    
   
    func loaddata()
    {
        let path="\(ftpIP)fc37ea41a74611abbab0996a31350aa629ad3cfab9bc2cf621f12e1ce5dca08f.jpg"
        print(path)
        let imgUrl = URL(string: path)
        self.hostprofile.pin_updateWithProgress = true
        self.hostprofile
            .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "btn-star-filled"))
        
        
        Eventtitlelabel.text = evnet.EventTitle
        Eventdeslabel.text = evnet.EventHostDescription
        hostaddress.text = evnet.EventHostAddress
        HostName.text = evnet.EventHostName
        lat = evnet.Latitude
        lng = evnet.Longitude
        //var annotation = custom_annation()
        custom_annation.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lng)!)
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let myLocation:CLLocationCoordinate2D = custom_annation.coordinate
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        
        custom_annation.imageName =  "Ellipse 5"
        
       // map.addAnnotation(custom_annation)
        map.setRegion(region, animated: true)
        
        var ann = CustomPointAnnotation()
        ann.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lng)!)
        ann.imageName = "icon_about_us"
        //ann.img = hostprofile.image!
        map.addAnnotation(ann)
        
//        var annotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lng)!)
//        map.addAnnotation(annotation)
        
    }
}

extension EventcalenderViewEventVC
{
    func geteevents()
    {
        ECDBManger.manager.getupcomingevents(date: date) { (res, event) in
            if res
            {
                if event!.count > 0
                {
                    DispatchQueue.main.async {
                        self.evnet = event![0]
                        self.loaddata()
                        self.reloadInputViews()
                    }
                }
            }
            else{
                
            }
        }
    }
    
    func addrsvp()
    {
        if let memberid = UserDefaults.standard.string(forKey: "CurrenMemberID")
        {
        //UserDefaults.standard.set(memberID, forKey: "CurrenMemberID")
            ECDBManger.manager.addRSVP(Hostid: "0", eventId: String(evnet.EventId), name: "", email: "", Status: statustext, memberid: Int(memberid)!) { (res) in
            self.rsvpreturnvalue = res
                
             let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ECRsvpPopupVC") as! ECRsvpPopupVC
        
            //vc.mypendingdelegate = self
            popVC.rsvpreturnvalue = res
            popVC.modalPresentationStyle = .overCurrentContext
            popVC.modalTransitionStyle = .crossDissolve
            self.present(popVC, animated: true, completion: nil)
        }
    }
    }
}

