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
    ^ void (void(^completion_block)(void)) {
        completion_block();
    }(^ {
        return ^ (UIView * touch_view) {
            UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, touch.view);
            for (CaptureDeviceConfigurationControlProperty property = CaptureDeviceConfigurationControlPropertyTorchLevel; property < CaptureDeviceConfigurationControlPropertyDefault; property++) {
                static dispatch_once_t onceToken[CaptureDeviceConfigurationControlPropertyDefault];
                dispatch_once(&onceToken[property], ^{
//                UIButton * button = CaptureDeviceConfigurationPropertyButton(property);
               CGPoint center = CGPointMake(CGRectGetMidX(touch.view.bounds) + [CaptureDeviceConfigurationPropertyButton(property) intrinsicContentSize].width, CGRectGetMidY(touch.view.bounds) - [CaptureDeviceConfigurationPropertyButton(property) intrinsicContentSize].height);
                CGFloat radius = (center.x);
                double angle = 180.0 + (90.0 * ((property) / 4.0));
                UIBezierPath * bezier_quad_curve = [UIBezierPath bezierPathWithArcCenter:center
                                                                                  radius:radius
                                                                              startAngle:degreesToRadians(angle) endAngle:degreesToRadians(angle)
                                                                               clockwise:FALSE];
                    CGPoint new_center = CGPointMake([bezier_quad_curve currentPoint].x + [CaptureDeviceConfigurationPropertyButton(property) intrinsicContentSize].width, [bezier_quad_curve currentPoint].y - [CaptureDeviceConfigurationPropertyButton(property) intrinsicContentSize].height);
                [CaptureDeviceConfigurationPropertyButton(property) setCenter:new_center];
//                CGPoint center = CGPointMake(CGRectGetMidX(touch.view.bounds), CGRectGetMidY(touch.view.bounds));
//                CGFloat radius = (center.x);
//                double angle = 180.0 + (90.0 * ((property) / 4.0));
//                UIBezierPath * bezier_quad_curve = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMaxX(touch.view.bounds), CGRectGetMaxY(touch.view.bounds))
//                                                                                  radius:radius
//                                                                              startAngle:degreesToRadians(angle) endAngle:degreesToRadians(angle)
//                                                                               clockwise:FALSE];
//                [button setCenter:[bezier_quad_curve currentPoint]];
               
                    [touch.view addSubview:CaptureDeviceConfigurationPropertyButton(property)];
                });
            }
            return ^ (CAShapeLayer * guide_layer) {
                [(CAShapeLayer *)guide_layer setLineWidth:0.5];
                [(CAShapeLayer *)guide_layer setStrokeColor:[UIColor systemBlueColor].CGColor];
                [(CAShapeLayer *)guide_layer setFillColor:[UIColor clearColor].CGColor];
                [(CAShapeLayer *)guide_layer setBackgroundColor:[UIColor clearColor].CGColor];
                CGRect bounds = [guide_layer bounds];
                return ^ (CGPoint touch_point) {
                    UIBezierPath * bezier_quad_curve_lower;
                    CGPoint tp = CGPointMake(fmaxf(CGRectGetMinX(bounds), fminf(CGRectGetMaxX(bounds), touch_point.x)),
                                             fmaxf(CGRectGetMinY(bounds), fminf(CGRectGetMaxY(bounds), touch_point.y)));
                    CGFloat radius = sqrt(pow(tp.x - CGRectGetMaxX(bounds), 2.0) + pow(tp.y - CGRectGetMaxY(bounds), 2.0));
                    bezier_quad_curve_lower = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMaxX(bounds),
                                                                                                CGRectGetMaxY(bounds))
                                                                             radius:radius startAngle:degreesToRadians(270.0) endAngle:degreesToRadians(180.0) clockwise:FALSE];
                        
                    [guide_layer setPath:bezier_quad_curve_lower.CGPath];
                    
                    [touch_view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
                        CGPoint center = CGPointMake(CGRectGetMaxX(touch.view.bounds), CGRectGetMaxY(touch.view.bounds));
                        CGPoint tp = [touch preciseLocationInView:touch.view];
                        CGFloat radius = sqrt(pow(tp.x - center.x, 2.0) + pow(tp.y - center.y, 2.0));
                        double angle = 180.0 + (90.0 * ((idx) / 4.0));
                        UIBezierPath * bezier_quad_curve = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMaxX(touch.view.bounds) - [subview intrinsicContentSize].width, CGRectGetMaxY(touch.view.bounds) - [subview intrinsicContentSize].height)
                                                                                          radius:radius
                                                                                      startAngle:degreesToRadians(angle) endAngle:degreesToRadians(angle)
                                                                                       clockwise:FALSE];
                        CGPoint new_center = CGPointMake([bezier_quad_curve currentPoint].x, [bezier_quad_curve currentPoint].y);
                    
                        [subview setCenter:new_center];
//                        CGFloat scaled_degrees = (idx * 18.0);
//                        CGFloat x = CGRectGetMaxX(touch_view.bounds) - fabs(radius * sinf(degreesToRadians(279.0) + degreesToRadians(scaled_degrees)));
//                        CGFloat y = CGRectGetMaxY(touch_view.bounds) - fabs(radius * cosf(degreesToRadians(279.0) + degreesToRadians(scaled_degrees)));
//                        CGPoint new_center = CGPointMake(x, y);
//                        [subview setCenter:new_center];
                    }];
                }([touch locationInView:touch_view]);
            }((CAShapeLayer *)touch_view.layer);
        }(touch.view);
    });
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
