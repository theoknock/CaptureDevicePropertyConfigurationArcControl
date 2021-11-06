//
//  ViewController.h
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/5/21.
//

#import <UIKit/UIKit.h>

#import "ConfigurationView.h"
#import "ControlView.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) ConfigurationView * configurationView;
@property (strong, nonatomic) ControlView       * controlView;

@end

