//
//  NotificationsManager.swift
//  Billz
//
//  Created by Zayn on 1/25/22.
//

import Foundation
import UserNotifications

final class NotificationsManager: ObservableObject {
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authStatus: UNAuthorizationStatus?
    
    
    //Listens notifications settings
    func loadAuthStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { notificationsSettings in
            DispatchQueue.main.async {
                self.authStatus = notificationsSettings.authorizationStatus
            }
            
        }
    }
    
    
    //ask for user's permission
    func requestAuth() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in

            
           
                DispatchQueue.main.async {
                    self.authStatus = granted ? .authorized : .denied
                }
            
        
            
        }
    }
    
    
    //set and load notifications if auth is true
    func resetNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            
            DispatchQueue.main.async {
                self.notifications = notifications
            }
            
        }
    }
    
    //Create Notifications
    func createNotification(title: String, hour: Int, minute: Int, completion: @escaping (Error?) -> Void) {
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let notitrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.sound = .default
        
        let notiRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: notitrigger)
        
        UNUserNotificationCenter.current().add(notiRequest, withCompletionHandler: completion)
        
    }
    
}
