//
//  ConfigurationView.m
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/5/21.
//

#import "ConfigurationView.h"
#import "CaptureDevicePropertyArcControlConfiguration.h"

@implementation ConfigurationView

static void (^(^handle_touch_event_init)(CAShapeLayer * _Nonnull))(UITouch * _Nullable) = ^ (CAShapeLayer * _Nonnull shape_layer) {
    const CGPoint minimum_center = CGPointMake(100.0, 100.0); //CGRectGetMinX(view.bounds), CGRectGetMinY(view.bounds));
    const CGPoint maximum_center = CGPointMake(CGRectGetMidX(shape_layer.bounds), CGRectGetMidY(shape_layer.bounds));
    
    return ^ (UITouch * _Nullable touch) {
        static UITouch * touch_glb;
        (touch != nil) ? ^{ touch_glb = touch; }() : ^{ /* touch == nil */ }();
        
        static CGPoint tp; // An object allocated in static memory is constructed once and persists to the end of the program.
                           // Its address does not change while the program is running. Qualifying the touch point variable as
                           // static increases performance by eliminating allocation and deallocation for each new value (by reuses the same memory address.
        tp = [touch_glb preciseLocationInView:touch_glb.view];
        
        // Qualifying center and radius as static allows for:
        // 1. Determining whether a touch point is on the edge of the control for resizing
        // 2. Determining whether a touch point is inside the circle for repositioning
        // 3. Determining whether a touch point is not on the edge or inside the circle for establishing boundaries and areas
        // To determine how a touch point relates to any of these three, the edge of the circle (boundary)
        // and the inside of the circle (area) must be known. Retaining the center and radius value with static
        // enables the boundary and area of the circle to be used in conjunction with any touch point that follows
        // the touch point that established them.

        static CGPoint center;
        center = CGPointMake(CGRectGetMidX(touch_glb.view.bounds), CGRectGetMidY(touch_glb.view.bounds));
        
        static CGFloat radius;
        radius = sqrt(pow(tp.x - center.x, 2.0) + pow(tp.y - center.y, 2.0)); // TO-DO: Set the radius only if the current touch point is outside of the arc
        
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
        [(CAShapeLayer *)shape_layer setPath:tick_line.CGPath];
        [(CAShapeLayer *)shape_layer setLineWidth:2.25];
        //        CGFloat dash[] = {8.0, 8.0};
        //        [(CAShapeLayer *)touch.view.layer setLineDashPhase:2.0];
        [(CAShapeLayer *)shape_layer setNeedsDisplay];
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
    
    handle_touch_event = handle_touch_event_init((CAShapeLayer *)self.layer);
    
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
