//
//  ViewController.h
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/5/21.
//

#import <UIKit/UIKit.h>
@import AVFoundation;

#import "ConfigurationView.h"
#import "PreviewView.h"
//#import "ControlView.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet ConfigurationView * configurationView;
//@property (strong, nonatomic) ControlView       * controlView;
@property (strong, nonatomic) IBOutlet PreviewView *previewView;


@end

