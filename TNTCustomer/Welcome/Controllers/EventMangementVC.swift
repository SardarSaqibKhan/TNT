//
//  EventMangementVC.swift
//  Event Mangment
//
//  Created by abdul on 07/05/2019.
//  Copyright © 2019 abdul. All rights reserved.
//

import UIKit
import GCCalendar




class EventMangementVC: UIViewController , UIScrollViewDelegate  {
    
    
   
    @IBOutlet weak var calenderdropdownbtn: UIButton!
    
    
    
    
    @IBOutlet weak var calenderview: GCCalendarView!
    //
   
    @IBOutlet weak var heightconstrain_cal_background: NSLayoutConstraint!
    
    @IBOutlet weak var calenderbackgroundview: UIView!

    @IBOutlet weak var eventtableview: UITableView!
    var Events = [Event]()
    var date = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        let date1 = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        date = formatter.string(from: date1)
        calenderview.translatesAutoresizingMaskIntoConstraints = false
        self.calenderview.today()
        calenderview.delegate = self
       calenderview.displayMode = .week
        
        heightconstrain_cal_background.constant = self.view.frame.height / 1.4
        
        calenderbackgroundview.layer.shadowRadius = 8
        
        calenderbackgroundview.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        calenderbackgroundview.layer.shadowOpacity = 1
        geteevents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.eventtableview.reloadData()
    geteevents()
    }
    
    @IBAction func calendermodechangebtn(_ sender: Any) {
        if calenderview.displayMode == .week
        {
            calenderview.displayMode = .month
            view.layoutIfNeeded()
            self.calenderdropdownbtn.setImage(UIImage(named: "btn_close_dropdown"), for: .normal)
            heightconstrain_cal_background.constant = heightconstrain_cal_background.constant - 150
            
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            view.layoutIfNeeded()
            
            heightconstrain_cal_background.constant = heightconstrain_cal_background.constant + 150
            self.calenderdropdownbtn.setImage(UIImage(named: "btn_dropdown"), for: .normal)
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
            calenderview.displayMode = .week
        }
    }
    
    
    override func viewDidLayoutSubviews() {
       
        
    }
    
    
    @IBAction func createeventbtn(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateEventVC") as! CreateEventVC
//        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func backbtn(_ sender: Any) {
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
extension EventMangementVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! eventmangmanttableviewcell
       cell.eventtitlelabel.text = Events[indexPath.row].EventTitle
       cell.eventdatetimelabel.text = Events[indexPath.row].EventDate + " : " +  Events[indexPath.row].EventTime
        
        let path="\(ftpIP)maxresdefault.jpg"
        print(path)
        let imgUrl = URL(string: path)
        cell.attendingpic1.pin_updateWithProgress = true
        cell.attendingpic1
            .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "btn-star-filled"))
        
        cell.attendingpic2.pin_updateWithProgress = true
        cell.attendingpic2
            .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "btn-star-filled"))

        cell.attendingpic3.pin_updateWithProgress = true
        cell.attendingpic3
            .pin_setImage(from: imgUrl, placeholderImage: UIImage(named: "btn-star-filled"))

        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CurrentEventVC") as! CurrentEventVC
       vc.evnet = Events[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
    
}

class eventmangmanttableviewcell: UITableViewCell {
    
    @IBOutlet weak var cellview: UIView!
    
    @IBOutlet weak var eventtitlelabel: UILabel!
    @IBOutlet weak var eventdatetimelabel: UILabel!
    @IBOutlet weak var attendinglabel: UILabel!
    
    @IBOutlet weak var attendingpic1: UIImageView!
    @IBOutlet weak var attendingpic2: UIImageView!
    @IBOutlet weak var attendingpic3: UIImageView!
    
    override func awakeFromNib() {
        attendingpic1.RoundProfileImage()
        attendingpic2.RoundProfileImage()
        attendingpic3.RoundProfileImage()
        cellview.borderHightLightwithshadow()
    }
}
extension EventMangementVC : GCCalendarViewDelegate
{
    func calendarView(_ calendarView: GCCalendarView, didSelectDate date: Date, inCalendar calendar: Calendar) {
        var dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ssZ"
        
        let gmtDate = dateFormatter.string(from: date)
        var date1 = gmtDate.description
        var arr = date1.split(separator: " ")
        
        
        print(arr[0])
        self.date = String(arr[0])
        geteevents()
        
    }
    
    func weekdayLabelTextColor(calendarView: GCCalendarView) -> UIColor {
        return UIColor.black
    }
    
    func currentDateSelectedBackgroundColor(calendarView: GCCalendarView) -> UIColor {
        return  UIColor(red:0.81, green:0.57, blue:0.24, alpha:1.0)
    }
    func currentDateTextColor(calendarView: GCCalendarView) -> UIColor {
        return  UIColor(red:0.81, green:0.57, blue:0.24, alpha:1.0)
    }
    func weekdayLabelFont(calendarView: GCCalendarView) -> UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    
}
extension EventMangementVC
{
    public static func AlertMessage( title:String, message: String){
        UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "Okay").show()
    }
    
    func geteevents()
    {
        DBManger.manager.geteventbydate(date: date) { (res, event) in
            if res
            {
                DispatchQueue.main.async {
                    self.Events = event!
                    self.eventtableview.reloadData()
                }
                
            }
            else{
                
            }
        }
    }
}

