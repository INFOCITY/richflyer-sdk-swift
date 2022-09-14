//
//  NotificationService.swift
//  RichFlyer
//
//  Copyright © 2019 INFOCITY,Inc. All rights reserved.
//

import UserNotifications
import RichFlyer

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
          if let confPath = Bundle.main.path(forResource: "RichFlyer", ofType: "plist") {
            if let rfConf = NSDictionary(contentsOfFile: confPath) {
              if let groupId = rfConf["groupId"] as? String {
                RFNotificationService.configureRFNotification(content: bestAttemptContent,
                                                              appGroupId: groupId,
                                                              displayNavigate: true,
                                                              completeHandler: { (content) in
                                                                contentHandler(content)
                })
              }
            }
          }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
