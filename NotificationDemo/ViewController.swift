//
//  ViewController.swift
//  NotificationDemo
//
//  Created by Ernest Fan on 2017-06-05.
//  Copyright © 2017 TLE. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scheduleNotification()
    }

    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "10 sec notification demo"
        content.subtitle = "From Ernest"
        content.body = "Notification after 10 seconds - alert is ready"
        content.badge = 1
        content.sound = UNNotificationSound(named: "gong.aif")
        content.userInfo = ["id": 42]
        
        let imageURL = Bundle.main.url(forResource: "treehouse", withExtension: "jpg")
        
        let attachment = try! UNNotificationAttachment(identifier: "treehouse.jpg", url: imageURL!, options: nil)
        
        content.attachments = [attachment]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: "10.second.notification", content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request, withCompletionHandler: nil)
        notificationCenter.delegate = self
    }


}

extension ViewController: UNUserNotificationCenterDelegate {
    // didReceive allow action if they tap on notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.userInfo)
        completionHandler()
    }
    
    // willPresent handles in app notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // present notification with sound
        completionHandler([.alert,.sound])
    }
}

