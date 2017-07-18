//
//  ViewController.swift
//  RemoteNotificationHandling
//
//  Created by yusuga on 07/18/2017.
//  Copyright (c) 2017 yusuga. All rights reserved.
//

import UIKit
import RemoteNotificationHandling

class ViewController: UIViewController {
    var count = 0 {
        didSet {
            title = String(count)
        }
    }
    
    @IBOutlet weak var contentView: UIView! {
        didSet {
            if #available(iOS 10.0, *) {
                contentView.isHidden = true
            }
        }
    }
    
    @IBOutlet weak var nextButtonItem: UIBarButtonItem! {
        didSet {
            if #available(iOS 10.0, *) {
                navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    @IBOutlet weak var deviceTokenLabel: UILabel! {
        didSet {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(didRegisterForRemoteNotifications(notification:)),
                name: Notification.Name.RemoteNotificationDeviceTokenHandling.didRegisterForRemoteNotifications,
                object: nil)
        }
    }
    
    @IBAction func handlerSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            RemoteNotificationManager.shared.iOS9AndBelowHandler?.didReceiveRemoteNotificationHandlers.add(self)
        } else {
            RemoteNotificationManager.shared.iOS9AndBelowHandler?.didReceiveRemoteNotificationHandlers.remove(self)
        }
    }
    
    @IBAction func notificationSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(didReceiveRemoteNotification(_:)),
                name: Notification.Name.RemoteNotificationHandling.didReceiveRemoteNotification,
                object: nil)
        } else {
            NotificationCenter.default.removeObserver(
                self,
                name: Notification.Name.RemoteNotificationHandling.didReceiveRemoteNotification,
                object: nil)
        }
    }
    
    @IBAction func registerUserNotificationSettings() {
        // Util
        if #available(iOS 10.0, *) {
            RemoteNotificationUtility.requestAuthorization()
        } else {
            RemoteNotificationUtility.registerUserNotificationSettings()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Notification
    
    func didRegisterForRemoteNotifications(notification: Notification) {
        deviceTokenLabel.text = (notification.object as! DeviceToken).string
    }
    
    func didReceiveRemoteNotification(_ notification: Notification) {
        let payload = notification.object as! Payload
        print("\(type(of: self))\(count) \(#function) payload.userInfo: \(payload.userInfo)")
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! ViewController).count = count + 1
    }
}

extension ViewController: iOS9AndBelowRemoteNotificationPayloadHandling {
    func didReceiveRemoteNotificationPayload(_ payload: Payload) {
        print("\(type(of: self))\(count) \(#function) payload.userInfo: \(payload.userInfo)")
    }
}

