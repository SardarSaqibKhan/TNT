//
//  CurrentEventVC.swift
//  UserGuestTNT
//
//  Created by abdul on 27/05/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit
import MapKit
import NVActivityIndicatorView
import PINRemoteImage
import PINCache
import IHProgressHUD
import CoreLocation

protocol rsvpdelagate:class {
    func getrsvpresult(rsvpstatus:String,flag:Bool)
}

class CurrentEventVC: UIViewController ,CLLocationManagerDelegate , MKMapViewDelegate {

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
    @IBOutlet weak var goingBtn: UIButton!
    @IBOutlet weak var interestedBtn: UIButton!
    @IBOutlet weak var NotgoingBtn: UIButton!
    
    
    @IBOutlet weak var RSVPbtn: UIButton!
    
    var rsvpflag = false
    var rsvpreturnvalue = String()
    var status = "Going"
    var date = String()
    var evnet = Event()
    var lat = String()
    var lng = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date1 = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        date = formatter.string(from: date1)
        
        let ac = ActivityData()
        
        if evnet.EventHostName == ""
        {
            IHProgressHUD.show()
            if Connectivity.isConnectedToInternet {
                
                self.geteevents()
            }
            else{
                
                IHProgressHUD.dismiss()
                showToasts(message: "Network Not Found.!\nPlease Try Again Later.!", senderView: self)
            }
        }
        else
        {
            loaddata()
        }
       
        setdesgin()
       
        
        
       
        
        // Do any additional setup after loading the view.
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
    override func viewWillAppear(_ animated: Bool) {
        if rsvpflag
        {
            rsvpflag = false
            let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ECRsvpPopupVC") as! ECRsvpPopupVC
            
            //popVC.dateDelegate = self
            
//            popVC.Eventid = String(evnet.EventId)
//            popVC.hostid = String(evnet.HostId)
//            popVC.status = status
            popVC.modalPresentationStyle = .overCurrentContext
            popVC.modalTransitionStyle = .crossDissolve
            self.present(popVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goingBtnaction(_ sender: Any) {
        status = "Going"
        goingBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        goingBtn.backgroundColor = #colorLiteral(red: 0.848572433, green: 0.5695539713, blue: 0.2421401143, alpha: 1)
        
        
        interestedBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        interestedBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        NotgoingBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        NotgoingBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    @IBAction func interestedBtnaction(_ sender: Any) {
         status = "Interested"
        interestedBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        interestedBtn.backgroundColor = #colorLiteral(red: 0.848572433, green: 0.5695539713, blue: 0.2421401143, alpha: 1)
        
        goingBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        goingBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        NotgoingBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        NotgoingBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
    }
    
    @IBAction func notgoingBtnaction(_ sender: Any) {
        status = "NotInterested"
        NotgoingBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        NotgoingBtn.backgroundColor = #colorLiteral(red: 0.848572433, green: 0.5695539713, blue: 0.2421401143, alpha: 1)
        
        
        interestedBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        interestedBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        goingBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        goingBtn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    
    @IBAction func RSVPbtn(_ sender: Any) {

        let  popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RSVPpopupVC") as! RSVPpopupVC
        
        popVC.delagate = self
        
        popVC.Eventid = String(evnet.EventId)
        popVC.hostid = String(evnet.HostId)
        popVC.status = status
        
        self.addChild(popVC)
        popVC.view.frame = self.view.frame
        //vc.mypendingdelegate = self
        self.view.addSubview(popVC.view)
        popVC.didMove(toParent: self)
//        popVC.modalPresentationStyle = .overCurrentContext
//        popVC.modalTransitionStyle = .crossDissolve
       // self.present(popVC, animated: true, completion: nil)
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
}
extension CurrentEventVC
{
    func setdesgin()
    {
        Hostinfopview.carveshadowradius(shadowRadius: 6)
        websiteview.carveshadowradius(shadowRadius: 6)
        mapandaddressview.carveshadowradius(shadowRadius: 5)
        RSVPbtn.roundBuiltView(size: 5)
        map.carveTopleftRightView(size:5)
        hostprofile.RoundProfileImage()
        
        
        goingBtn.roundBuiltView(size: 5)
        goingBtn.layer.shadowRadius = 5
        goingBtn.layer.shadowOpacity = 0.1
        
        interestedBtn.roundBuiltView(size: 5)
        interestedBtn.layer.shadowRadius = 5
        interestedBtn.layer.shadowOpacity = 0.1
        
        
        interestedBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        
        
        NotgoingBtn.roundBuiltView(size: 5)
        NotgoingBtn.layer.shadowRadius = 5
        NotgoingBtn.layer.shadowOpacity = 0.1
        
        NotgoingBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        
        
    }
    func loaddata()
    {
        
        let path="\(ftpIP)\(evnet.EventHostProfileImage)"
        print(path)
        let imgUrl = URL(string: path)
        self.hostprofile.pin_updateWithProgress = true
        self.hostprofile
            .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "avatar"))
        Eventtitlelabel.text = evnet.EventTitle
        Eventdeslabel.text = evnet.EventHostDescription
        hostaddress.text = evnet.EventHostAddress
        HostName.text = evnet.EventHostName
        lat = evnet.Latitude
        lng = evnet.Longitude
        var annotation = CustomPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lng)!)
        map.addAnnotation(annotation)
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let myLocation:CLLocationCoordinate2D = annotation.coordinate
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        map.setRegion(region, animated: true)
        
        
        
        
        
    }
}

extension CurrentEventVC
{
    func geteevents()
    {
        DBManger.manager.getupcomingevents(date: date) { (res, event) in
            if res
            {
                if event!.count > 0
                {
                    IHProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.evnet = event![0]
                    self.loaddata()
                    self.reloadInputViews()
                }
              }
                else{
                    IHProgressHUD.dismiss()
                }
            }
            else{
                IHProgressHUD.dismiss()
            }
        }
    }
    
    
    
}
extension CurrentEventVC:rsvpdelagate
{
    func getrsvpresult(rsvpstatus: String, flag: Bool) {
        rsvpflag = flag
        rsvpreturnvalue = rsvpstatus
        viewWillAppear(false)
    }
    
    
}
