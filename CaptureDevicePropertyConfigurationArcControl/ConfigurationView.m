//
//  ConfigurationView.m
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/5/21.
//

#import "ConfigurationView.h"
#import "CaptureDevicePropertyArcControlConfiguration.h"

@implementation ConfigurationView

static void (^(^handle_touch_event_init)(__kindof __weak UIView *))(UITouch * _Nullable) = ^ (__kindof __weak UIView * view) {
    UIBezierPath * tick_line = [UIBezierPath bezierPath];
    [(CAShapeLayer *)view.layer setPath:
     ^ CGPathRef (void) {
        CGPoint default_center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
        CGFloat default_radius = (view.bounds.size.width <= view.bounds.size.height) ? CGRectGetMidX(view.bounds) : CGRectGetMidY(view.bounds);
        for (int degrees = 0; degrees < 360; degrees = degrees + 10) {
            UIBezierPath * outer_arc = [UIBezierPath bezierPathWithArcCenter:default_center
                                                                      radius:default_radius
                                                                  startAngle:degreesToRadians(degrees)
                                                                    endAngle:degreesToRadians(degrees)
                                                                   clockwise:FALSE];
            UIBezierPath * inner_arc = [UIBezierPath bezierPathWithArcCenter:default_center
                                                                      radius:default_radius * 0.85
                                                                  startAngle:degreesToRadians(degrees)
                                                                    endAngle:degreesToRadians(degrees)
                                                                   clockwise:FALSE];
            
            [tick_line moveToPoint:[outer_arc currentPoint]];
            [tick_line addLineToPoint:[inner_arc currentPoint]];
        }
//        [tick_line closePath];
        
        // @property CGFloat cornerRadius;
        //
        // Setting the radius to a value greater than 0.0 causes the layer to begin drawing rounded corners on its background.
        // By default, the corner radius does not apply to the image in the layer’s contents property;
        // it applies only to the background color and border of the layer.
        // However, setting the masksToBounds property to YES causes the content to be clipped to the rounded corners.
        
        CGRect path_rect = CGPathGetBoundingBox(tick_line.CGPath);
        [(CAShapeLayer *)view.layer setBounds:path_rect];
        [(CAShapeLayer *)view.layer setCornerRadius:path_rect.size.width / 2.0];//R <= path_rect.size.height) ? CGRectGetMidX(path_rect) : CGRectGetMidY(path_rect)];
        [(CAShapeLayer *)view.layer setBorderWidth:1.0];
        [(CAShapeLayer *)view.layer setBorderColor:[UIColor redColor].CGColor];
        [(CAShapeLayer *)view.layer setNeedsDisplayOnBoundsChange:TRUE];
        

        return tick_line.CGPath;
    }()];
    
    static const int (^bitwiseSubtract)(int, int) = ^ int (int x, int y) {
        while (y != 0)
        {
            int borrow = (~x) & y;
            x = x ^ y;
            y = borrow << 1;
        }
        
        return x;
    };

    return ^ (UITouch * _Nullable touch) {
        static UITouch * touch_glb;
        (touch != nil)
        ? ^{
            touch_glb = touch;
        }()
        : ^{
            static CGPoint tp;
            tp = [touch_glb locationInView:touch_glb.view];
            static CGPoint prev_tp;
            prev_tp = [touch_glb previousLocationInView:touch_glb.view];
            
            [(CAShapeLayer *)touch_glb.view.layer setPath:^ CGPathRef (void) {
               (CGRectContainsPoint(CGPathGetPathBoundingBox(((CAShapeLayer *)touch_glb.view.layer).path), tp))
                ? ^{
                    [(CAShapeLayer *)touch_glb.view.layer setTransform:CATransform3DTranslate(touch_glb.view.layer.transform, bitwiseSubtract(tp.x, prev_tp.x), bitwiseSubtract(tp.y, prev_tp.y), 0.0)];
                }()
                : ^{
//                    CGFloat new_radius = sqrt(pow(tp.x - center.x, 2.0) + pow(tp.y - center.y, 2.0));
                    //            CGFloat scale = radius / new_radius;
                    //            [tick_line applyTransform:CGAffineTransformMakeScale(scale, scale)];
                    //            radius = new_radius;
                    printf("\tRadius\n");
                }();
                return tick_line.CGPath;
            }()];
//            [(CAShapeLayer *)touch_glb.view.layer setBounds:CGPathGetBoundingBox(tick_line.CGPath)];
        }();
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
    
    [(CAShapeLayer *)self.layer setLineWidth:2.25];
    [(CAShapeLayer *)self.layer setStrokeColor:[UIColor colorWithRed:4/255 green:51/255 blue:255/255 alpha:1.0].CGColor];
    [(CAShapeLayer *)self.layer setFillColor:[UIColor clearColor].CGColor];
    [(CAShapeLayer *)self.layer setBackgroundColor:[UIColor clearColor].CGColor];
    
//    UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, self);
//    for (CaptureDeviceConfigurationControlProperty property = CaptureDeviceConfigurationControlPropertyTorchLevel; property < CaptureDeviceConfigurationControlPropertyDefault; property++) {
//        [self addSubview:CaptureDeviceConfigurationPropertyButton(property)];
//    }
    
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
//    UITouch * touch = touches.anyObject;
//    printf("\n%s (current) %s %s (previous)\n",
//           [NSStringFromCGPoint([touch locationInView:touch.view]) UTF8String],
//           (CGPointEqualToPoint([touch locationInView:touch.view], [touch previousLocationInView:touch.view])) ? "==" : "!=",
//           [NSStringFromCGPoint([touch previousLocationInView:touch.view]) UTF8String]);
    handle_touch_event(touches.anyObject);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch * touch = touches.anyObject;
//    printf("\n%s (current) %s %s (previous)\n",
//           [NSStringFromCGPoint([touch locationInView:touch.view]) UTF8String],
//           (CGPointEqualToPoint([touch locationInView:touch.view], [touch previousLocationInView:touch.view])) ? "==" : "!=",
//           [NSStringFromCGPoint([touch previousLocationInView:touch.view]) UTF8String]);
    handle_touch_event(nil);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch * touch = touches.anyObject;
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
