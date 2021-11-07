//
//  controlView.h
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/5/21.
//

#import <UIKit/UIKit.h>

#import "CaptureDevicePropertyArcControlConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@class ControlView;

typedef ControlView * (^DrawConfiguration)(id);
typedef void (^DrawComponentPrimary)(ControlView *);
typedef void (^DrawComponentSecondary)(UITouch * touch);
typedef DrawComponentSecondary (^DrawComponents)(DrawComponentPrimary);

@interface ControlView : UIView

// A block that initializes shared properties between the property button and value components of the control
// and draws the control based on user preferences, various device properties (size, orientation, etc.);
// when executed, it returns a block that draws the value component as properties are set or get;\
// When user preferences change or the device is rotated, etc., it can be ran again using the block:
//
// void (^(^drawControl)(ControlView *))(void) = ....
@property(strong, nonatomic) DrawComponents draw_components;
@property(nonatomic, readonly, strong) CAShapeLayer * layer;

@end

NS_ASSUME_NONNULL_END
