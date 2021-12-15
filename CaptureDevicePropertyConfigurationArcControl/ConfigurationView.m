//
//  ConfigurationView.m
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/5/21.
//

#import "ConfigurationView.h"
#import "CaptureDevicePropertyArcControlConfiguration.h"

@implementation ConfigurationView

static void (^(^handle_touch_event_init)(__kindof UIView * _Nonnull view))(UITouch * _Nullable) = ^ (__kindof UIView * _Nonnull view) {
    const CGPoint minimum_center = CGPointMake(100.0, 100.0); //CGRectGetMinX(view.bounds), CGRectGetMinY(view.bounds));
    const CGPoint maximum_center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    
    return ^ (UITouch * _Nullable touch) {
        static UITouch * touch_glb;
        (touch != nil) ? ^{ touch_glb = touch; }() : ^{ /* touch == nil */ }();
        
        static CGPoint center;
        (center.x == minimum_center.x && center.y == minimum_center.y)
        ? ^{ center = CGPointMake(CGRectGetMidX(touch_glb.view.bounds), CGRectGetMidY(touch_glb.view.bounds)); printf("default center == %s\n", [NSStringFromCGPoint(center) UTF8String]); }()
        : ^{ center = [touch_glb preciseLocationInView:touch_glb.view]; printf("new
                                                                               \center == %s\n", [NSStringFromCGPoint(center) UTF8String]); }();

        static CGFloat radius;
        
        
        
        
        
//        // If previous location in view is the same as the current location in view, skip this block here or in touch-handler methods
//        (touch.phase == UITouchPhaseBegan) ? ^ { /* */ }() : (touch.phase == UITouchPhaseEnded) ?
//        ^ { /* */ }() : ^ { /* UITouchPhaseMoved */ }();
    
        
        
        CGPoint tp = [touch_glb preciseLocationInView:touch_glb.view];
        
        radius = sqrt(pow(tp.x - center.x, 2.0) + pow(tp.y - center.y, 2.0)); // To-Do: Update the center if control is relocated
    
        // To-Do: Move the center of the control if the finger is dragging from its inside
        // 1. Calculate a new radius using the touch point
        // 2. Compare to the current radius (use the last touch point for that -- don't create a "last radius variable")
        
        __block UIBezierPath * tick_line = [UIBezierPath bezierPath];
        
        for (int degrees = 0; degrees < 360; degrees = degrees + 10) {
            UIBezierPath * outer_arc = [UIBezierPath bezierPathWithArcCenter:center /* (radius <= previous_radius) ? tp : center */
                                                                      radius:radius /* (radius < previous_radius) ? previous_radius : radius */
                                                                  startAngle:degreesToRadians(degrees)
                                                                    endAngle:degreesToRadians(degrees)
                                                                   clockwise:FALSE];
            UIBezierPath * inner_arc = [UIBezierPath bezierPathWithArcCenter:center /* (radius <= previous_radius) ? tp : center */
                                                                      radius:radius /* ((radius < previous_radius) ? previous_radius : radius) * 0.85 */
                                                                  startAngle:degreesToRadians(degrees)
                                                                    endAngle:degreesToRadians(degrees)
                                                                   clockwise:FALSE];
            
            // To-Do: Use a different color for the tick that corresponds to the control/property value
            [tick_line moveToPoint:[outer_arc currentPoint]];
            [tick_line addLineToPoint:[inner_arc currentPoint]];
            //            [[UIColor whiteColor] setStroke];
            //            [tick_line setLineWidth:4.0];
            //            [tick_line stroke];
        }
        [(CAShapeLayer *)touch_glb.view.layer setPath:tick_line.CGPath];
        [(CAShapeLayer *)touch_glb.view.layer setLineWidth:2.25];
        //        CGFloat dash[] = {8.0, 8.0};
        //        [(CAShapeLayer *)touch.view.layer setLineDashPhase:2.0];
        [(CAShapeLayer *)touch_glb.view.layer setNeedsDisplay];
    };
};


static const void (^handle_touch_event)(UITouch * _Nullable);

+ (Class)layerClass {
    return [CAShapeLayer class];
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self == [super initWithFrame:frame]) {
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setFrame:UIScreen.mainScreen.bounds];
    [self setBounds:UIScreen.mainScreen.bounds];
    [self setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    [self setBackgroundColor:[UIColor blackColor]];
    
    [(CAShapeLayer *)self.layer setLineWidth:0.5];
    [(CAShapeLayer *)self.layer setStrokeColor:[UIColor colorWithRed:4/255 green:51/255 blue:255/255 alpha:1.0].CGColor];
    [(CAShapeLayer *)self.layer setFillColor:[UIColor clearColor].CGColor];
    [(CAShapeLayer *)self.layer setBackgroundColor:[UIColor clearColor].CGColor];
    
    UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, self);
    for (CaptureDeviceConfigurationControlProperty property = CaptureDeviceConfigurationControlPropertyTorchLevel; property < CaptureDeviceConfigurationControlPropertyDefault; property++) {
        [self addSubview:CaptureDeviceConfigurationPropertyButton(property)];
    }
    
    handle_touch_event = handle_touch_event_init(self);
    
    [self.layer setNeedsDisplay];
    //    }
    //
    //    return self;
}

//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
//    CGRect rect = layer.bounds;
//
//    CGContextSetLineWidth(ctx, 1.0);
//    CGContextSetStrokeColorWithColor(ctx, [[UIColor lightGrayColor] CGColor]);
//    CGFloat dash[] = {8.0, 8.0};
//    CGContextSetLineDash(ctx, 0.0, dash, 2);
//
////    CGContextMoveToPoint(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect));
//    CGRect square_rect = CGRectMake(CGRectGetMinX(rect), CGRectGetMidY(rect) / 2.0, CGRectGetMaxX(rect), CGRectGetMaxX(rect));
//    CGContextAddEllipseInRect(ctx, square_rect);
//
//    CGContextStrokePath(ctx);
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = touches.anyObject;
//    printf("\n%s (current) %s %s (previous)\n",
//           [NSStringFromCGPoint([touch locationInView:touch.view]) UTF8String],
//           (CGPointEqualToPoint([touch locationInView:touch.view], [touch previousLocationInView:touch.view])) ? "==" : "!=",
//           [NSStringFromCGPoint([touch previousLocationInView:touch.view]) UTF8String]);
    handle_touch_event(touch);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = touches.anyObject;
//    printf("\n%s (current) %s %s (previous)\n",
//           [NSStringFromCGPoint([touch locationInView:touch.view]) UTF8String],
//           (CGPointEqualToPoint([touch locationInView:touch.view], [touch previousLocationInView:touch.view])) ? "==" : "!=",
//           [NSStringFromCGPoint([touch previousLocationInView:touch.view]) UTF8String]);
    handle_touch_event(nil);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = touches.anyObject;
//    printf("\n%s (current) %s %s (previous)\n",
//           [NSStringFromCGPoint([touch locationInView:touch.view]) UTF8String],
//           (CGPointEqualToPoint([touch locationInView:touch.view], [touch previousLocationInView:touch.view])) ? "==" : "!=",
//           [NSStringFromCGPoint([touch previousLocationInView:touch.view]) UTF8String]);
    handle_touch_event(nil);
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
