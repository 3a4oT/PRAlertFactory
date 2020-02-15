## PRAlertFactory - Display UIAlertController from UIView/NSObject class


Allows you to show  ```UIAlertController```  from any layer of your application. Works for both Swift and Objective-C.

### Installation

**Swift Package Manager**

```
.package(url: https://github.com/3a4oT/PRAlertFactory.git, from: "0.1.0")

```

**Carthage**

```
github "3a4oT/PRAlertFactory" ~> 0.1.0

```

### Usage

Initialize in your app's **AppDelegate**

**Swift**

```
// MyAppDelegate.swift

import PRAlertFactory

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    // Register "show"
    UIAlertController.initShow()
    
    return true
}

```

**Objective-C**

```
// MyAppDelegate.m

@import PRAlertFactory;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    // Register "show"
    [UIAlertController initShow];
    
    return YES;
}

```

And  just  ```show```  somewhere in your UIView/NSObject based class.

**Swift**

```
import PRAlertFactory

class FooService: NSObject {
    public func fooRequest() -> Void {
        let alert: UIAlertController = UIAlertController(title:"Test title", message: "Test message", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        alert.show()
    }
}

```

**Objective-C**

```

#import "BarService.h"
#import <UIKit/UIKit.h>
#import <UIAlertControllerShowLegacy/UIAlertControllerShowLegacy-Swift.h>


@implementation BarService

- (void)barRequest {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"Test bar title"
                                        message:@"Test bar obj-c request"
                                 preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:okAction];

    [alert show];
}

@end

```
