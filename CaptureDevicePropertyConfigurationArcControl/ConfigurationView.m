//
//  ConfigurationView.m
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/5/21.
//

#import "ConfigurationView.h"
#import "CaptureDevicePropertyArcControlConfiguration.h"

@implementation ConfigurationView {
    CGPoint(^(^arc_control_attributes_guide)(CGPoint))(CAShapeLayer *);
}

static void (^handle_touch_event)(UITouch *) = ^ (UITouch * touch) {
    //    (touch.phase == UITouchPhaseBegan) ? ^ { printf("\nLockDeviceForConfiguration\n"); }() : (touch.phase == UITouchPhaseEnded) ?
    //    ^ { printf("\nUnlockDeviceForConfiguration\n"); }() : ^ { printf("\n-----\n"); }();
    UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, touch.view);
    for (CaptureDeviceConfigurationControlProperty property = CaptureDeviceConfigurationControlPropertyTorchLevel; property < CaptureDeviceConfigurationControlPropertyDefault; property++) {
        static dispatch_once_t onceToken[CaptureDeviceConfigurationControlPropertyDefault];
        dispatch_once(&onceToken[property], ^{
            [touch.view addSubview:CaptureDeviceConfigurationPropertyButton(property)];
        });
    }
    [(CAShapeLayer *)touch.view.layer setLineWidth:0.5];
    [(CAShapeLayer *)touch.view.layer setStrokeColor:[UIColor systemBlueColor].CGColor];
    [(CAShapeLayer *)touch.view.layer setFillColor:[UIColor clearColor].CGColor];
    [(CAShapeLayer *)touch.view.layer setBackgroundColor:[UIColor clearColor].CGColor];
    
    __block CGPoint center;
    __block CGFloat radius;
    [touch.view.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        center = CGPointMake(CGRectGetMaxX(touch.view.bounds) - [button intrinsicContentSize].width, CGRectGetMaxY(touch.view.bounds) - [button intrinsicContentSize].height);
        CGPoint tp = CGPointMake([touch preciseLocationInView:touch.view].x - [button intrinsicContentSize].width, [touch preciseLocationInView:touch.view].y - [button intrinsicContentSize].height);
        radius = sqrt(pow(tp.x - center.x, 2.0) + pow(tp.y - center.y, 2.0));
        double angle = 180.0 + (90.0 * ((idx) / 4.0));
        UIBezierPath * bezier_quad_curve = [UIBezierPath bezierPathWithArcCenter:center
                                                                          radius:radius
                                                                      startAngle:degreesToRadians(angle) endAngle:degreesToRadians(angle)
                                                                       clockwise:FALSE];
        [button setCenter:[bezier_quad_curve currentPoint]];
        
    }];
    UIBezierPath * bezier_quad_curve_arc = [UIBezierPath bezierPathWithArcCenter:center
                                                                          radius:radius
                                                                      startAngle:degreesToRadians(270.0) endAngle:degreesToRadians(180.0)
                                                                       clockwise:FALSE];
    [(CAShapeLayer *)touch.view.layer setPath:bezier_quad_curve_arc.CGPath];
};

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        //        UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, self);
        //        for (CaptureDeviceConfigurationControlProperty property = 0; property < CaptureDeviceConfigurationControlPropertyImageKeys.count; property++) {
        //            [self addSubview:CaptureDeviceConfigurationPropertyButton(property)];
        //        }
    }
    
    return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    handle_touch_event(touches.anyObject);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    handle_touch_event(touches.anyObject);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    handle_touch_event(touches.anyObject);
}

- (NSString *)userArcControlConfigurationFileName {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * fileName = [NSString stringWithFormat:@"%@/arc_control_configuration.dat", documentsDirectory];
    
    return fileName;
}

- (CGFloat)userArcControlConfiguration {
    CGFloat radius = (CGRectGetMidX(self.bounds) + CGRectGetMinX(self.bounds)) / 2.0;
    __autoreleasing NSError * error = nil;
    NSData *structureData = [[NSData alloc] initWithContentsOfFile:[self userArcControlConfigurationFileName] options:NSDataReadingUncached error:&error];
    if (!error) {
        NSDictionary<NSString *, NSNumber *> * structureDataAsDictionary = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSDictionary class] fromData:structureData error:&error];
        radius = [(NSNumber *)[structureDataAsDictionary objectForKey:@"PreferredArcRadius"] floatValue];
    }
    if (error) printf("\nERROR\t\t%s\n", [[error description] UTF8String]);
    
    return radius;
}

- (CGFloat)setUserArcControlConfiguration:(CGFloat)radius {
    NSDictionary<NSString *, NSNumber *> * structureDataAsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:radius], @"PreferredArcRadius", nil];
    __autoreleasing NSError * error = nil;
    NSData *structureData = [NSKeyedArchiver archivedDataWithRootObject:structureDataAsDictionary requiringSecureCoding:FALSE error:&error];
    if (!error) {
        ([structureData writeToFile:[self userArcControlConfigurationFileName] options:NSDataWritingAtomic error:&error]) ?
        ^{ printf("\nThe control-points preferences were saved to %s\n", [[self userArcControlConfigurationFileName] UTF8String]); }() :
        ^{ printf("\nThe control-points preferences were not saved\n"); }();
    }
    if (error) printf("\nERROR\t\t%s\n", [[error description] UTF8String]);
    
    return radius;
}

@end
