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
    ConfigurationView * cv = self->_configurationView;
    if (!cv || cv == NULL) {
        cv = [[ConfigurationView alloc] initWithFrame:self.view.bounds];
        [cv setTranslatesAutoresizingMaskIntoConstraints:FALSE];
        [cv setBackgroundColor:[UIColor clearColor]];

        self->_configurationView = cv;
    }

    return cv;
}

// To-Do: Keep this code for initializing controlView-executed blocks that need to capture variables only within the purview of viewController and its other views and any solely owned objects (this also includes constraints, of course)
//        Otherwise, aside from dependencies, move it to ControlView.h/m
//- (ControlView *)controlView {
//    printf("%s", __PRETTY_FUNCTION__);
//    ControlView * cv = self->_controlView;
//    if (!cv || cv == NULL) {
//        cv = [[ControlView alloc] initWithFrame:self.view.bounds];
//        [cv setTranslatesAutoresizingMaskIntoConstraints:FALSE];
//        [cv setBackgroundColor:[UIColor clearColor]];
//        
//        CGFloat radius;
//        UserArcControlConfiguration(UserArcControlConfigurationFileOperationRead)(&radius);
//        printf("\nRead radius of %f\n", radius);
//        CGFloat angle  = degreesToRadians(279.0);
//        UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, (CAShapeLayer *)cv.layer);
//        for (CaptureDeviceConfigurationControlProperty property = 0; property < CaptureDeviceConfigurationControlPropertyImageKeys.count; property++) {
//            UIButton * button = CaptureDeviceConfigurationPropertyButton(property);
//            CGFloat scaled_degrees = (property * 18.0);
//            CGFloat x = CGRectGetMaxX(cv.bounds) - fabs(radius * sinf(angle + degreesToRadians(scaled_degrees)));
//            CGFloat y = CGRectGetMaxY(cv.bounds) - fabs(radius * cosf(angle + degreesToRadians(scaled_degrees)));
//            CGPoint new_center = CGPointMake(x, y);
//            [button setCenter:new_center];
//            [cv addSubview:button];
//        }
//        
//        [cv setUserInteractionEnabled:TRUE];
//        
//        self->_controlView = cv;
//    }
//    
//    return cv;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setUserInteractionEnabled:TRUE];
    [self.view setClipsToBounds:FALSE];
    
    
//    { // ControlView
//        self.controlView = [[ControlView alloc] initWithFrame:UIScreen.mainScreen.bounds];
//        [self.view addSubview:self.controlView];
//        [NSLayoutConstraint activateConstraints:@[
//            [self.controlView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
//            [self.controlView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
//            [self.controlView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
//            [self.controlView.topAnchor constraintEqualToAnchor:self.view.topAnchor]
//        ]];
//    }
//    
//    { // ConfigurationView
//        self.configurationView = [[ConfigurationView alloc] initWithFrame:UIScreen.mainScreen.bounds];
//        [self.configurationView willMoveToSuperview:self.view];
//        [self.view addSubview:self.configurationView];
//        [self.configurationView didMoveToSuperview];
//        [NSLayoutConstraint activateConstraints:@[
//            [self.configurationView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
//            [self.configurationView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
//            [self.configurationView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
//            [self.configurationView.topAnchor constraintEqualToAnchor:self.view.topAnchor]
//        ]];
//    }
}

//- (void)viewWillLayoutSubviews {
//    [NSLayoutConstraint activateConstraints:@[
//        [self.configurationView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
//        [self.configurationView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
//        [self.configurationView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
//        [self.configurationView.topAnchor constraintEqualToAnchor:self.view.topAnchor]
//    ]];
//}

@end
