//
//  DeviceLockUnlockForConfigurationBlockTestView.m
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/11/21.
//

/* MODEL */

/*
 
 return (^ (CAShapeLayer * __strong layer) {
 [layer setLineWidth:1.0];
 [layer setFillColor:[UIColor clearColor].CGColor];
 [layer setBackgroundColor:[UIColor clearColor].CGColor];
 (!init) ?: init();
 return (^ (CGContextRef __nullable context) {
 __block NSMutableArray<void(^)(UITouch *)> * touch_event_handlers = [[NSMutableArray alloc] initWithCapacity:3]; //void(^touch_event_handlers[3])(UITouch *);
 return (^ (UITouchPhase touch_phase) {
 touch_event_handlers[touch_phase] = ^ (void(^display_path)(CGPathRef)) {
 CGPoint center = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
 return ^ (UITouch * touch) {
 CGPoint tp = [touch preciseLocationInView:touch.view];
 CGFloat radius = sqrt(pow(tp.x - center.x, 2.0) + pow(tp.y - center.y, 2.0));
 UIBezierPath * bezier_quad_curve = [UIBezierPath bezierPathWithArcCenter:center
 radius:radius
 startAngle:degreesToRadians(270.0) endAngle:degreesToRadians(180.0)
 clockwise:FALSE];
 display_path(bezier_quad_curve.CGPath);
 };
 }(^{
 UIColor * stroke_color = (touch_phase == UITouchPhaseMoved) ? [UIColor systemGreenColor] : [UIColor systemRedColor];
 return ^ (CGPathRef bezier_path_ref) {
 [layer setStrokeColor:stroke_color.CGColor];
 [layer setPath:bezier_path_ref];
 };
 }());
 return touch_event_handlers[touch_phase];
 });
 });
 });
 
 */

/*
 CAMERA
 */

/*
 
 static AVCaptureSession * captureSession;
 static AVCaptureDevice * captureDevice;
 static AVCaptureDeviceInput * captureInput;
 static AVCaptureConnection * captureConnection;
 static AVCaptureVideoPreviewLayer * capturePreview;
 
 ^ (typeof(UIView *__strong)view) {
 [captureSession = [[AVCaptureSession alloc] init]
 setSessionPreset:([captureSession canSetSessionPreset:AVCaptureSessionPreset3840x2160]) ? AVCaptureSessionPreset3840x2160 : AVCaptureSessionPreset1920x1080];
 [captureSession beginConfiguration];
 {
 [captureInput  = [AVCaptureDeviceInput deviceInputWithDevice:[captureDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInDualCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack] self] error:nil] setUnifiedAutoExposureDefaultsEnabled:TRUE];
 [captureSession addInput:([captureSession canAddInput:captureInput]) ? captureInput : nil];
 
 [capturePreview = (AVCaptureVideoPreviewLayer *)[(DeviceLockUnlockForConfigurationBlockTestView *)self layer]
 setSessionWithNoConnection:captureSession];
 
 [captureConnection = [[AVCaptureConnection alloc] initWithInputPort:captureInput.ports.firstObject videoPreviewLayer:capturePreview]
 setVideoOrientation:AVCaptureVideoOrientationPortrait];
 [captureSession addConnection:([captureSession canAddConnection:captureConnection]) ? captureConnection : nil];
 }
 [captureSession commitConfiguration];
 
 [captureSession startRunning];
 
 };
 */

@import AVFoundation;

#import "DeviceLockUnlockForConfigurationBlockTestView.h"
#import "CaptureDevicePropertyArcControlConfiguration.h"

static void (^(^(^(^(^configure_device)(AVCaptureDevice *__strong))(UIControl *))(NSArray<NSNumber *> *))(UITouchPhase))(UITouch *);
static void (^(^(^touch_event_handlers)(NSArray<NSNumber *> *))(UITouchPhase))(UITouch *);
static void (^(^touch_event_handler_init)(UITouchPhase))(UITouch *);
static void (^touch_event_handler)(UITouch *);


@implementation DeviceLockUnlockForConfigurationBlockTestView {
    void(^SetPropertyFromControlValues)(float *);
    void(^RefreshControlsFromPropertyValues)(const NSArray<UIControl *> *);
}

+ (Class)layerClass {
    return [AVCaptureVideoPreviewLayer class];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    struct __attribute__((objc_boxable)) PropertyConfiguration
    {
        const NSArray<UIControl *> * controls;
        __unsafe_unretained void (^setProperty)(float *);
        __unsafe_unretained void (^refreshControls)(const NSArray<UIControl *> * controls);
        
    };
    typedef struct PropertyConfiguration PropertyConfiguration;
    
    PropertyConfiguration torchLevelConfiguration =
    { .controls = @[],
            .setProperty = ^ void (float * control_values) {
                // setProperty (executed by configureCameraProperty)
                // Get the value of the control(s) and set the property to its corresponding value
            },
            .refreshControls = ^ void (const NSArray<UIControl *> * controls) {
                // Gets the value of the property and refreshes its corresponding control(s) to reflect that value
            }
    };
    
    const PropertyConfiguration property_configuration_structs[] = {torchLevelConfiguration};
    
    struct __attribute__((objc_boxable)) PropertyConfigurationStructs
    {
        // These blocks are initialized in the property button event handler
        __unsafe_unretained void (^(^SetPropertyFromControlValues)(void(^)(float *)))(float *);
        __unsafe_unretained void (^(^RefreshControlsFromPropertyValues)(void(^)(const NSArray<UIControl *> *)))(const NSArray<UIControl *> *);
        const PropertyConfiguration * property_configurations;
    } property_configuration_struct = {
        .SetPropertyFromControlValues = ^ (void(^propertySetter)(float *)) {
            return ^ void (float * control_values) {
                propertySetter(&control_values[CaptureDeviceConfigurationControlPropertyTorchLevel]);
            };
        },
        .RefreshControlsFromPropertyValues = ^ (void(^controlsRefresher)(const NSArray<UIControl *> *)) {
            return ^ void (const NSArray<UIControl *> * controls) {
                controlsRefresher(controls);
            };
        },
        .property_configurations = property_configuration_structs,
    };
    
/*
 
 */

touch_event_handler_init = ^ (NSArray<NSNumber *> * touch_phases) {
    return ^ (UITouchPhase touch_phase) {
        __block NSMutableDictionary<NSNumber *, void(^)(UITouch *)> * touch_event_handlers = [[NSMutableDictionary alloc] initWithCapacity:touch_phases.count];
        [touch_phases enumerateObjectsUsingBlock:^(NSNumber * _Nonnull touch_phase_obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [touch_event_handlers setObject:^ (UITouchPhase phase) {
                return ^ (UITouch * touch) {
                    
                };
            }((UITouchPhase)touch_phase_obj.unsignedIntegerValue) forKey:touch_phase_obj];
        }];
        return [touch_event_handlers objectForKey:@(touch_phase)];
    };
}(@[@(UITouchPhaseBegan), @(UITouchPhaseMoved), @(UITouchPhaseEnded)]);


^ (AVCaptureDevice *__strong capture_device) {
    return ^ (typeof(UIControl *) control) {
        return ^ (UITouch * touch) {
            (touch.phase == UITouchPhaseBegan) ? ^{ [capture_device lockForConfiguration:nil]; }()
            : !(touch.phase == UITouchPhaseMoved) ? ^{ [capture_device unlockForConfiguration];   }()
            : ^{
                // configure device here
            }();
        };
    };
};

};

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    (!touch_event_handler) ?: (touch_event_handler(touches.anyObject));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    (!touch_event_handler) ?: (touch_event_handler(touches.anyObject));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    (!touch_event_handler) ?: (touch_event_handler(touches.anyObject));
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    (!touch_event_handler) ?: (touch_event_handler(touches.anyObject));
}


@end

