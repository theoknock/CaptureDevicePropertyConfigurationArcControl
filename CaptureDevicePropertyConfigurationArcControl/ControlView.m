//
//  controlView.m
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/5/21.
//

#import "ControlView.h"
#import "CaptureDevicePropertyArcControlConfiguration.h"

@implementation ControlView

@dynamic layer;

+ (Class)layerClass {
    return [CAShapeLayer class];
}

typedef struct __attribute__((objc_boxable)) ArcControlMeasurements ArcControlMeasurements;
static double center[2] = {0.0, 0.0};
static double radius    = 380.0;
static double angle     = 180.0;
static double start     = 180.0;
static double length    = 22.5;
static double end       = 270.0;
static int    sectors   = 10;
static int    units     = 10;
static double range[2]  = {0.0, 1.0};
static double value;
static CGRect (^bounds)(void) = ^ { return CGRectMake(center[0] + radius, center[1] - radius, radius, radius); };

double * const center_ptr  = &center[2];
double * const radius_ptr  = &radius;
double * const angle_ptr   = &angle;
double * const start_ptr   = &start;
double * const length_ptr  = &length;
double * const end_ptr     = &end;
int    * const sectors_ptr = &sectors;
int    * const units_ptr   = &units;
double * const range_ptr   = &range[2];
double * const value_ptr   = &value;

static struct __attribute__((objc_boxable)) ArcControlMeasurements
{
    double * const center_ptr;
    double * const radius_ptr;
    double * const angle_ptr;
    double * const start_ptr;
    double * const length_ptr;
    double * const end_ptr;
    int    * const sectors_ptr;
    int    * const int_ptr;
    double * const range_ptr;
    double * const value_ptr;
    __unsafe_unretained CGRect (^bounds)(void);
} arcControlMeasurements = {
    .radius_ptr  = &radius,
    .angle_ptr   = &angle,
    .center_ptr  = &center[2],
    .start_ptr   = &start,
    .length_ptr  = &length,
    .end_ptr     = &end,
    .sectors_ptr = &sectors,
    .range_ptr   = &range[2],
    .value_ptr   = &value,
    .bounds  = ^ CGRect { return CGRectMake(((double *)center_ptr)[0] + *radius_ptr, ((double *)center_ptr)[1] - *radius_ptr, *radius_ptr, *radius_ptr); },
};


//𝑥(𝑛)=𝑥(0)+𝑟cos(2𝜋𝑛𝑁)𝑦(𝑛)=𝑦(0)+𝑟sin(2𝜋𝑛𝑁)
//
//// Points on a circle using radius and center point
//(𝑥,𝑦)≡(𝑥0+𝑟cos𝜃,𝑦0+𝑟sin𝜃)
//
//2𝜋/𝑁

typedef enum : NSUInteger {
    TouchEventHandlerTypeTouchesBegan,
    TouchEventHandlerTypeTouchesMoved,
    TouchEventHandlerTypeTouchesEnded,
    TouchEventHandlerTypeDefault
} TouchEventHandlerType;

static void (^(^(^(^(^(^(^draw_control)(ArcControlMeasurements * const))(ControlView *__strong))(CGRect))(CAShapeLayer *__strong))(CGContextRef __nullable))(TouchEventHandlerType))(UITouch *);
static void (^(^(^(^(^(^draw_primary_component_init)(ControlView *__strong))(CGRect))(CAShapeLayer *__strong))(CGContextRef __nullable))(TouchEventHandlerType))(UITouch *);
static void (^(^(^(^(^draw_primary_component)(CGRect))(CAShapeLayer *__strong))(CGContextRef __nullable))(TouchEventHandlerType))(UITouch *);
static void (^(^(^(^draw_secondary_component_init)(CAShapeLayer *__strong))(CGContextRef __nullable))(TouchEventHandlerType))(UITouch *);
static void (^(^(^draw_secondary_component)(CGContextRef __nullable))(TouchEventHandlerType))(UITouch *);
static void (^(^handle_touch_control_event_init)(TouchEventHandlerType))(UITouch *);
static void (^handle_touch_control_event[TouchEventHandlerTypeDefault])(UITouch *);

static void (^(^(^(^(^(^(^(^draw_control_init)(__nullable dispatch_block_t))(ArcControlMeasurements * const))(ControlView *__strong))(CGRect))(CAShapeLayer *__strong))(CGContextRef __nullable))(TouchEventHandlerType))(UITouch *) =
^ (dispatch_block_t init) {
    if (init) init();
    return (^ (ArcControlMeasurements * const measurements) {
        return (^ (ControlView * view) {
            return (^ (CGRect rect) {
                UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, view);
                for (CaptureDeviceConfigurationControlProperty property = CaptureDeviceConfigurationControlPropertyTorchLevel; property <= CaptureDeviceConfigurationControlPropertyZoomFactor; property++) {
                    UIButton * button = CaptureDeviceConfigurationPropertyButton(property);
                    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
                    CGFloat radius = (center.x);
//                    double x = (center.x + (radius * -cosf(2.0 * M_PI_4 * ((property) / 4.0))));
//                    double y = (center.y + (radius * -sinf(2.0 * M_PI_4 * ((property) / 4.0))));
                    double angle = 180.0 + (90.0 * ((property) / 4.0));
                    UIBezierPath * bezier_quad_curve = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))
                                                                                      radius:radius
                                                                                  startAngle:degreesToRadians(angle) endAngle:degreesToRadians(angle)
                                                                                   clockwise:FALSE];
                    
                    [button setCenter:[bezier_quad_curve currentPoint]];
                    static dispatch_once_t onceToken[5];
                    dispatch_once(&onceToken[property], ^{
                        [view addSubview:button];
                    });
                }
                return (^ (CAShapeLayer * __strong layer) {
                    return (^ (CGContextRef __nullable context) {
                        return (^ (TouchEventHandlerType touch_event_handler_type) {
                            [layer setLineWidth:1.0];
                            [layer setFillColor:[UIColor clearColor].CGColor];
                            [layer setBackgroundColor:[UIColor clearColor].CGColor];
                            void(^touch_event_handler)(UITouch *) = ^ (dispatch_block_t blk) {
                                return ^ (UITouch * touch) {
                                    printf("\n%lu\n", touch_event_handler_type);
                                    CGPoint center = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
                                    CGFloat radius = (center.x);
                                    CGPoint touch_point = [touch preciseLocationInView:touch.view];
                                    CGPoint tp = touch_point;/* CGPointMake(rescale(fmaxf(CGRectGetMinX(rect), fminf(CGRectGetMaxX(rect), touch_point.x)), CGRectGetMinX(rect), CGRectGetMaxX(rect), 0.0, 360.0),
                                                              rescale(fmaxf(CGRectGetMinY(rect), fminf(CGRectGetMaxY(rect), touch_point.y)), CGRectGetMinY(rect), CGRectGetMaxY(rect), 0.0, 360.0));*/
                                    radius = sqrt(pow(tp.x - center.x, 2.0) + pow(tp.y - center.y, 2.0));
                                    UIBezierPath * bezier_quad_curve = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))
                                                                                                      radius:radius
                                                                                                  startAngle:degreesToRadians(270.0) endAngle:degreesToRadians(180.0)
                                                                                                   clockwise:FALSE];
                                    blk();
                                    [layer setPath:bezier_quad_curve.CGPath];
                                };
                            }(^{
                                UIColor * stroke_color =
                                (touch_event_handler_type == TouchEventHandlerTypeTouchesMoved) ? [UIColor systemGreenColor] : [UIColor systemRedColor];
                                [layer setStrokeColor:stroke_color.CGColor];
                            });
                            void(^touch_event_handlers[3])(UITouch *) = {touch_event_handler, touch_event_handler, touch_event_handler};
                            return touch_event_handlers[touch_event_handler_type];
                        });
                    });
                });
            });
        });
    });
};

-(void)awakeFromNib {
    [super awakeFromNib];
    
    handle_touch_control_event_init = draw_control_init(^ (ControlView * view, CAShapeLayer * layer) {
        return ^ {
            printf("%s\n", __PRETTY_FUNCTION__);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [view setNeedsDisplay];
                    [layer setNeedsDisplay];
                });
        };
    }(self, (CAShapeLayer *)self.layer))((ArcControlMeasurements * const)&arcControlMeasurements)(self)(self.bounds)((CAShapeLayer *)self.layer)(nil);
    handle_touch_control_event[0] = handle_touch_control_event_init(TouchEventHandlerTypeTouchesBegan);
    handle_touch_control_event[1] = handle_touch_control_event_init(TouchEventHandlerTypeTouchesMoved);
    handle_touch_control_event[2] = handle_touch_control_event_init(TouchEventHandlerTypeTouchesEnded);
}

- (void)drawRect:(CGRect)rect {
    (!draw_primary_component) ?:
    ^ { draw_secondary_component_init = draw_primary_component(rect);
    }();
}

- (void)drawLayer:(CAShapeLayer *)layer inContext:(CGContextRef)ctx {
    (!draw_secondary_component_init) ?:
    ^ { draw_secondary_component = draw_secondary_component_init(layer);
        draw_secondary_component(ctx);
    }();
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    handle_touch_control_event[0](touches.anyObject);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    handle_touch_control_event[1](touches.anyObject);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    handle_touch_control_event[2](touches.anyObject);
}

@end
