//
//  AppDelegate.m
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/5/21.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    ViewController * root_view_controller = [[ViewController alloc] init];
    [self.window setRootViewController:root_view_controller];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
