import UIKit
import Flutter
import flutter_local_notifications
import FirebaseCore
import Firebase
import FirebaseMessaging
import workmanager


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
    // // In AppDelegate.application method
    // WorkmanagerPlugin.registerBGProcessingTask(withIdentifier: "task-identifier")

    //   // Register a periodic task in iOS 13+
    // WorkmanagerPlugin.registerPeriodicTask(withIdentifier: "be.tramckrijte.workmanagerExample.iOSBackgroundAppRefresh", frequency: NSNumber(value: 20 * 60))
    FirebaseApp.configure()
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken devicetoken: Data){
        Messaging.messaging().apnsToken = devicetoken
        print("token : \(devicetoken)")
        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: devicetoken)
    }
      
}
