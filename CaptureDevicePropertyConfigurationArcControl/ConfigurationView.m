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

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, self);
        for (CaptureDeviceConfigurationControlProperty property = 0; property < CaptureDeviceConfigurationControlPropertyImageKeys.count; property++) {
            [self addSubview:CaptureDeviceConfigurationPropertyButton(property)];
        }
    }
    
    return self;
}

// To-Do: Keep circle at current radius on touchesBegan, adding or subtracting the value of the touch point (makes it easier to make adjustments to the arc control radius when the drag-target is range-wide and prevents jumping from the current radius to the finger location)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

// To-Do: Gradually inch the edge of the circle to the finger if the finger is not on the edge while dragging (the finger should eventually be connected to the edge of the circle, but not in one jump)

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ^ (UITouch * touch) {
        ^ void (void(^completion_block)(void)) {
            completion_block();
        }(^ {
            return ^ (UIView * touch_view) {
                return ^ (CAShapeLayer * guide_layer) {
                    [(CAShapeLayer *)guide_layer setLineWidth:0.5];
                    [(CAShapeLayer *)guide_layer setStrokeColor:[UIColor systemBlueColor].CGColor];
                    [(CAShapeLayer *)guide_layer setFillColor:[UIColor clearColor].CGColor];
                    [(CAShapeLayer *)guide_layer setBackgroundColor:[UIColor clearColor].CGColor];
                    CGRect bounds = [guide_layer bounds];
                    return ^ (CGPoint touch_point) {
                        UIBezierPath * bezier_quad_curve;
                        CGPoint tp = CGPointMake(fmaxf(CGRectGetMinX(bounds), fminf(CGRectGetMaxX(bounds), touch_point.x)),
                                                 fmaxf(CGRectGetMinY(bounds), fminf(CGRectGetMaxY(bounds), touch_point.y)));
                        CGFloat radius = sqrt(pow(tp.x - CGRectGetMaxX(bounds), 2.0) + pow(tp.y - CGRectGetMaxY(bounds), 2.0));
                        
                        bezier_quad_curve = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMaxX(bounds),
                                                                                              CGRectGetMaxY(bounds))
                                                                           radius:radius startAngle:degreesToRadians(270.0) endAngle:degreesToRadians(180.0) clockwise:FALSE];
                        [guide_layer setPath:bezier_quad_curve.CGPath];
                        
                        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
                            CGFloat scaled_degrees = (idx * 18.0);
                            CGFloat x = CGRectGetMaxX(self.bounds) - fabs(radius * sinf(degreesToRadians(279.0) + degreesToRadians(scaled_degrees)));
                            CGFloat y = CGRectGetMaxY(self.bounds) - fabs(radius * cosf(degreesToRadians(279.0) + degreesToRadians(scaled_degrees)));
                            CGPoint new_center = CGPointMake(x, y);
                            [subview setCenter:new_center];
                        }];
                    }([touch locationInView:touch_view]);
                }((CAShapeLayer *)touch_view.layer);
            }(touch.view);
        });
    }(touches.anyObject);
}

// To-Do: Animate the edge of the circle meeting the finger is dragging is offset (the edge of the circle should meet where the finger was lifted (?))

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
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
