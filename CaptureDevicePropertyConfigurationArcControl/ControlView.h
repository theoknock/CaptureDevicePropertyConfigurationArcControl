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

@interface ControlView : UIView

@property(nonatomic, readonly, strong) CAShapeLayer * layer;

@end

NS_ASSUME_NONNULL_END
