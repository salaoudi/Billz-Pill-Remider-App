//
//  BillzApp.swift
//  Billz
//
//  Created by Zayn on 1/21/22.
//

import SwiftUI

@main
struct BillzApp: App {
   
    @StateObject var mvm = TodayViewModal()
    @StateObject var notificationsManager = NotificationsManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(notificationManager: notificationsManager)
                
        }
    }
}
