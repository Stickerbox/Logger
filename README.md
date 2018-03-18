# Logger
A logging framework for iOS written in Swift

Logger is a lightweight logging framework that eases QA by generating logs that can be viewed on the device.

It's simple to set up! There are only four things you need to do to set up Logger. To get started:

First, call Logger.setup(logType: LogType, fileName: String). The logType decides whether to log to the console, to a file, both, or neither. You can setup based on compiler flags so that dev prints to the consolse, but QA writes to a file.

Next, make sure you set Logger.canBeDisplayed to true. If there are times in your app when you don't want anyone to see the logs, e.g. a data sensative app, you can change this and the ability to view the logs on the device will be disabled.

Now, anywhere you want to log, just import Logger, and call the log() function. You could even change all your current print function calls to log. log() takes an autoclosure of () -> Any as its first argument, just like print(). There's also another parameter, level, which if set, will also log meta data about the call site, such as the file name, function name, line number, and pretty print the log.

Finally, to view the logs, you just need to call Logger.present(onto: UIViewController?, version: String, build: String). I typically do this in an extension on UIWindow, so the logs can be displayed any time the device is shaken. Here's that extension if you wanna do the same!

    import Foundation
    import Logger

    extension UIWindow {

        open override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {

            guard motion == .motionShake else { return }

            let version = Bundle.main.versionNumber ?? ""
            let build = Bundle.main.buildNumber ?? ""

            Logger.present(onto: rootViewController, version: version, build: build)
        }
    }


    extension Bundle {
        var versionNumber: String? {
            return infoDictionary?["CFBundleShortVersionString"] as? String
        }
        var buildNumber: String? {
            return infoDictionary?["CFBundleVersion"] as? String
        }
    }
    
Copy and paste that into a file in your app, and now when you shake the device, you'll be presented with the Logger interface! From here it's easy to share the logs with a share sheet. Alternativly, you can set UIFileSharingEnabled to YES in your info.plist file and grab them from iTunes!
