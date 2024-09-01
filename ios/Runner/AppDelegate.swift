import Flutter
import UIKit
import workmanager

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    WorkmanagerPlugin.registerBGProcessingTask(withIdentifier: "syncTasksWithFirebase")
    WorkmanagerPlugin.registerPeriodicTask(withIdentifier: "syncTasksWithFirebase", frequency: NSNumber(value: 6 * 60 * 60))
    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(6 * 60 * 60))

    UNUserNotificationCenter.current().delegate = self

     AppDelegate.registerPlugins(with: self) // Register the app's plugins in the context of a normal run

            WorkmanagerPlugin.setPluginRegistrantCallback { registry in
                // The following code will be called upon WorkmanagerPlugin's registration.
                // Note : all of the app's plugins may not be required in this context ;
                // instead of using GeneratedPluginRegistrant.register(with: registry),
                // you may want to register only specific plugins.
                AppDelegate.registerPlugins(with: registry)
            }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                           willPresent notification: UNNotification,
                                           withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
           completionHandler(.alert) // shows banner even if app is in foreground
       }

        static func registerPlugins(with registry: FlutterPluginRegistry) {
                   GeneratedPluginRegistrant.register(with: registry)
              }
}
