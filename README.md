# RemoteNotificationHandling

RemoteNotificationHandling does the processing required for remote notification. Inspired by [PushNotificationHandler](https://github.com/gtsifrikas/PushNotificationHandler).

## Features

- [x] Get the device token for the Apple Push Notification Service (APNS)
- [x] Remote notification handling for iOS 9 and below
- [x] Remote notification models

## Installation

```ruby
pod 'RemoteNotificationHandling'
```

## Usage

### Get the device token

#### Conform to protocol

```swift
struct DeviceTokenHandler: RemoteNotificationDeviceTokenHandling {    
}
```

#### Required call in UIApplicationDelegate

```swift
extension AppDelegate { // RemoteNotificationDeviceTokenHandling
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        RemoteNotificationManager.shared.deviceTokenHandler.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        RemoteNotificationManager.shared.deviceTokenHandler.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
}
```

#### Receive handler

##### Callback function

```swift
struct DeviceTokenHandler: RemoteNotificationDeviceTokenHandling {    
    func didRegisterForRemoteNotifications(result: DeviceTokenResult) {
        switch result {
        case .success(let deviceToken):
            print("Success deviceToken.string: \(deviceToken.string)")
        case .failure(let error):
            print("Failure error: \(error)")
        }
    }
}
```

##### Notification.name

```swift
extension Notification.Name {
    public struct RemoteNotificationDeviceTokenHandling {
        public static let didRegisterForRemoteNotifications = Notification.Name(rawValue: "RemoteNotificationDeviceTokenHandling.didRegisterForRemoteNotifications")
        public static let didFailToRegisterForRemoteNotifications = Notification.Name(rawValue: "RemoteNotificationDeviceTokenHandling.didFailToRegisterForRemoteNotifications")
    }    
}
```

### Receive remote notification for iOS 10

Use [UNUserNotificationCenter](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter).

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    UNUserNotificationCenter.current().delegate = self
    return true
}
```

```swift
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        print("Payload: \(Payload(notification)")
        completionHandler([.badge, .sound, .alert])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        print("Payload: \(Payload(response)")
        completionHandler()
    }
}
```

### Receive remote notification for iOS 9 and below

### Conform to protocol

```swift
class iOS9AndBelowRemoteNotificationHandler: iOS9AndBelowRemoteNotificationHandling {    
    let didReceiveRemoteNotificationHandlers = WeakContainer<iOS9AndBelowRemoteNotificationPayloadHandling>()
}
```

#### Required call in UIApplicationDelegate

```swift
extension AppDelegate { // iOS9AndBelowRemoteNotificationHandling
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        RemoteNotificationManager.shared.iOS9AndBelowHandler?.application(application, didFinishLaunchingWithOptions: launchOptions)        
        return true
    }

    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        RemoteNotificationManager.shared.iOS9AndBelowHandler?.application(application, didRegister: notificationSettings)
    }

    /// - note: Opening the app by tapping the icon will never give you information about previous notifications. It's only if you actually open the app via a notification that you will be able to access the notification data. (from [Stackoverflow](https://stackoverflow.com/a/13847840))
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        RemoteNotificationManager.shared.iOS9AndBelowHandler?.application(application, didReceiveRemoteNotification: userInfo)
    }
}
```

#### Receive handler

##### Callback function

```swift
iOS9AndBelowHandler.didReceiveRemoteNotificationHandlers.add(self)
```

```swift
extension ViewController: iOS9AndBelowRemoteNotificationPayloadHandling {
    func didReceiveRemoteNotificationPayload(_ payload: Payload) {
        print("Payload: \(payload)")
    }
}
```

##### Notification.name

```swift
extension Notification.Name {
    public struct RemoteNotificationHandling {
        @available(iOS, deprecated: 10.0)
        public static let didReceiveRemoteNotification = Notification.Name(rawValue: "RemoteNotificationHandling.didReceiveRemoteNotification")
    }
}
```

## Correspondence table of iOS methods

### iOS 10

| [App State](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/TheAppLifeCycle/TheAppLifeCycle.html#//apple_ref/doc/uid/TP40007072-CH2-SW3) | Tap | launchOptions | userNotificationCenter(_:willPresent:withCompletionHandler:) | userNotificationCenter(_:didReceive:withCompletionHandler:) |
| --- | --- | :---: | :---: | :---: |
| Not running | App Icon | ✖️ | ✖️ | ✖️ |
| Not running | Banner | ⭕️ | ✖️ | ⭕️ |
| Foreground | - | ✖️ | ⭕️ | ✖️ |
| Foreground | Banner | ✖️ | ✖️ | ⭕️ |
| Background | App Icon | ✖️ | ✖️ | ✖️ |
| Background | Banner | ✖️ | ✖️ | ⭕️ |

### iOS 9 and below

| [App State](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/TheAppLifeCycle/TheAppLifeCycle.html#//apple_ref/doc/uid/TP40007072-CH2-SW3) | Tap | launchOptions | application(_:didReceiveRemoteNotification:) |
| --- | --- | :---: | :---: |
| Not running | App Icon | ✖️ | ✖️ |
| Not running | Banner | ⭕️ | ✖️ |
| Foreground | - | ✖️ | ⭕️ |
| Background | App Icon | ✖️ | ✖️ |
| Background | Banner | ✖️ | ⭕️ |

## Recommended debug libraries

- [NWPusher](https://github.com/noodlewerk/NWPusher)
- [Knuff](https://github.com/KnuffApp/Knuff)
- [SimulatorRemoteNotifications](https://github.com/acoomans/SimulatorRemoteNotifications)
