//
//  ViewController.m
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/5/21.
//

#import "ViewController.h"
#import "CaptureDevicePropertyArcControlConfiguration.h"


@interface ViewController ()

@end

@implementation ViewController

- (ConfigurationView *)configurationView {
    printf("%s", __PRETTY_FUNCTION__);
    ConfigurationView * cv = self->_configurationView;
    if (!cv || cv == NULL) {
        cv = [[ConfigurationView alloc] initWithFrame:self.view.bounds];
        [cv setTranslatesAutoresizingMaskIntoConstraints:FALSE];
        [cv setBackgroundColor:[UIColor clearColor]];
        
        self->_configurationView = cv;
    }
    
    return cv;
}

- (ControlView *)controlView {
    printf("%s", __PRETTY_FUNCTION__);
    ControlView * cv = self->_controlView;
    if (!cv || cv == NULL) {
        cv = [[ControlView alloc] initWithFrame:self.view.bounds];
        [cv setTranslatesAutoresizingMaskIntoConstraints:FALSE];
        [cv setBackgroundColor:[UIColor clearColor]];
        
        CGFloat radius;
        UserArcControlConfiguration(UserArcControlConfigurationFileOperationRead)(&radius);
        printf("\nRead radius of %f\n", radius);
        CGFloat angle  = degreesToRadians(279.0);
        UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, (CAShapeLayer *)cv.layer);
        for (CaptureDeviceConfigurationControlProperty property = 0; property < CaptureDeviceConfigurationControlPropertyImageKeys.count; property++) {
            UIButton * button = CaptureDeviceConfigurationPropertyButton(property);
            CGFloat scaled_degrees = (property * 18.0);
            CGFloat x = CGRectGetMaxX(cv.bounds) - fabs(radius * sinf(angle + degreesToRadians(scaled_degrees)));
            CGFloat y = CGRectGetMaxY(cv.bounds) - fabs(radius * cosf(angle + degreesToRadians(scaled_degrees)));
            CGPoint new_center = CGPointMake(x, y);
            [button setCenter:new_center];
            [cv addSubview:button];
        }
        
        [cv setUserInteractionEnabled:TRUE];
        
        self->_controlView = cv;
    }
    
    return cv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setUserInteractionEnabled:TRUE];
    
    { // ControlView
        [self.view addSubview:[self controlView]];
        [NSLayoutConstraint activateConstraints:@[
            [self.controlView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [self.controlView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
            [self.controlView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [self.controlView.topAnchor constraintEqualToAnchor:self.view.topAnchor]
        ]];
    }
    
//    { // ConfigurationView
//        [self.view addSubview:[self configurationView]];
//        [NSLayoutConstraint activateConstraints:@[
//            [self.configurationView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
//            [self.configurationView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
//            [self.configurationView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
//            [self.configurationView.topAnchor constraintEqualToAnchor:self.view.topAnchor]
//        ]];
//    }
}

@end
