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
static double radius    = 407.0;
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

void (^(^(^(^(^(^(^(^draw_control_init)(void))(ArcControlMeasurements * const))(ControlView *__weak))(CGRect))(CAShapeLayer *__weak))(CGContextRef))(void))(NSSet<UITouch *> *__weak) =
^{
    return (^ (ArcControlMeasurements * const measurements) {
        return (^ (ControlView * __weak w_view) {
            __strong typeof(w_view) s_view = w_view;
            [s_view setNeedsDisplay];
            return (^ (CGRect rect) {
                // add buttons
                return (^ (CAShapeLayer * __weak w_layer) {
                    __strong typeof(w_layer) s_layer = w_layer;
                    [s_layer setNeedsDisplay];
                    return (^ (CGContextRef context) { // arrange layer and touch so that the code following the setting of the layer is not executed unless and until the touch event handler is executed
                        return (^ {
                            return (^ (NSSet<UITouch *> *__weak touches) {
                                CGContextSaveGState(context);
                                ^ (UITouch * touch) {
                                    // handle touch events
                                }([touches anyObject]);
                                CGContextRestoreGState(context);
                            });
                        });
                    });
                });
            });
        });
    });
};

static void (^(^(^(^(^(^(^draw_control)(ArcControlMeasurements * const))(ControlView *))(CGRect))(CAShapeLayer *__strong))(CGContextRef))(void))(NSSet<UITouch *> *__weak);
static void (^(^(^(^(^(^draw_primary_component_init)(ControlView *__weak))(CGRect))(CAShapeLayer *__strong))(CGContextRef))(void))(NSSet<UITouch *> *__weak);
static void (^(^(^(^(^draw_primary_component)(CGRect))(CAShapeLayer *__strong))(CGContextRef))(void))(NSSet<UITouch *> *__weak);
static void (^(^(^(^draw_secondary_component_init)(CAShapeLayer *__strong))(CGContextRef))(void))(NSSet<UITouch *> *__weak);
static void (^(^(^draw_secondary_component)(CGContextRef))(void))(NSSet<UITouch *> *__weak);
static void (^(^handle_touch_control_event_init)(void))(NSSet<UITouch *> *__weak);
static void (^handle_touch_control_event)(NSSet<UITouch *> *__weak);

//void (^(^(^(^(^draw_components_init)(void))(__weak ControlView *))(CGRect rect))(CAShapeLayer * _Nonnull __strong, CGContextRef _Nonnull))(UITouch *__strong) = ^ {
//    return ^ (__weak ControlView * w_view) {
//        __strong typeof(w_view) s_view = w_view;
//        [s_view setNeedsDisplay];
//        return ^ (CGRect rect) {
//            ^ void (void(^draw_primary_component)(void)) {
//                draw_primary_component();
//            }(^ {
//            printf("%s", __PRETTY_FUNCTION__);
//            start = 180.0;
//            UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, s_view);
//            for (CaptureDeviceConfigurationControlProperty property = 0; property < CaptureDeviceConfigurationControlPropertyImageKeys.count; property++) {
//                UIButton * button = CaptureDeviceConfigurationPropertyButton(property);
//                angle = start + length * property;
//                CGFloat x = CGRectGetMaxX(rect) + (radius * cosf(degreesToRadians(angle)));
//                CGFloat y = CGRectGetMaxY(rect) + (radius * sinf(degreesToRadians(angle)));
//                CGPoint new_center = CGPointMake(rescale(x, CGRectGetMaxX(rect) - radius, CGRectGetMaxX(rect), (CGRectGetMaxX(rect) - radius) + (button.intrinsicContentSize.width / 2.0), CGRectGetMaxX(rect) - button.intrinsicContentSize.height),
//                                                 rescale(y, CGRectGetMaxY(rect) - radius, CGRectGetMaxY(rect), (CGRectGetMaxY(rect) - radius) + (button.intrinsicContentSize.width / 2.0), CGRectGetMaxY(rect) - button.intrinsicContentSize.height));
//                [button setCenter:new_center];
//                static dispatch_once_t onceToken[5];
//                dispatch_once(&onceToken[property], ^{
//                    [s_view addSubview:button];
//                });
//            }
//            });
//            return ^ (CAShapeLayer * _Nonnull shape_layer, CGContextRef _Nonnull ctx) {
//                [shape_layer setLineWidth:0.5];
//                [shape_layer setStrokeColor:[UIColor systemBlueColor].CGColor];
//                [shape_layer setFillColor:[UIColor clearColor].CGColor];
//                [shape_layer setBackgroundColor:[UIColor clearColor].CGColor];
//                CGRect bounds = [shape_layer bounds];
//                return ^ (UITouch * touch) {
//                    ^ void (void(^completion_block)(void)) {
//                        completion_block();
//                    }(^ {
//                        return ^ (UIView * touch_view) {
//                            return ^ (CGPoint touch_point) {
//                                CGPoint center_point = CGPointMake(CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
//                                CGPoint tp = CGPointMake(fmaxf(CGRectGetMinX(bounds), fminf(CGRectGetMaxX(bounds), touch_point.x)),
//                                                         fmaxf(CGRectGetMinY(bounds), fminf(CGRectGetMaxY(bounds), touch_point.y)));
//                                radius = sqrt(pow(tp.x - center_point.x, 2.0) + pow(tp.y - center_point.y, 2.0));
//                                UIBezierPath * bezier_quad_curve = [UIBezierPath bezierPathWithArcCenter:center_point
//                                                                                                  radius:radius
//                                                                                              startAngle:degreesToRadians(270.0) endAngle:degreesToRadians(180.0)
//                                                                                               clockwise:FALSE];
//                                [shape_layer setPath:bezier_quad_curve.CGPath];
//                            }([touch locationInView:touch_view]);
//                        }(touch.view);
//                    });
//                };
//            };
//        };
//    };
//};
//

//typedef NS_OPTIONS(NSUInteger, ArcDegreesMeasurementOption) {
//    ArcDegreesMeasurementOptionStart= 1 << 0,
//    ArcDegreesMeasurementOptionEnd = 1 << 1,
//    ArcDegreesMeasurementOptionRadius = 1 << 2
//};
//
//
//typedef double * (^arc_degree_measurement_blk)(ArcDegreesMeasurementOption measurement_options, ...);
//arc_degree_measurement_blk measurement_blk = ^ double * (ArcDegreesMeasurementOption measurement_options, ...) {
//    va_list ap;
//    va_list * ap_ptr = &ap;
//    va_start(ap, measurement_options); // To-Do: get a number of options
//
//    //       for ( i = 0; i < 10; i++ ) {
//    //          printf( "*(p + %f) : %fd\n", i, *(p + i));
//    //       }
//
//    __block double measurement;
//    __block double * measurements = &measurement;
//    for (int i = 0; i < measurement_options; i++) {
//        measurement = (^ double {
//            ArcDegreesMeasurementOption option = 1 << i;
//            switch (option) {
//                case ArcDegreesMeasurementOptionStart:
//                    start = va_arg (*ap_ptr, double);
//                    printf("start[%d] == %f\n", i, start);
//                    return *start_ref;
//                    break;
//                case ArcDegreesMeasurementOptionEnd:
//                    end = va_arg (*ap_ptr, double);
//                    printf("end[%d] == %f\n", i, end);
//                    return *end_ref;
//                    break;
//                case ArcDegreesMeasurementOptionRadius:
//                    radius = va_arg (*ap_ptr, double);
//                    printf("radius[%d] == %f\n", i, radius);
//                    return *radius_ref;
//                    break;
//                default:
//                    return *start_ref;
//                    break;
//            }
//            //            measurements = &measurement;
//        }());
//    }
//    va_end (ap);
//
//    //
//    //    for (int i = 3; i < 3; i++) {
//    //        printf("measurements[%d] == %f\n", i, (double)measurements_ptr[i]);
//    //    }
//
//    return measurements;
//};

static NSUInteger (^gcd)(NSUInteger, NSUInteger) = ^ NSUInteger (NSUInteger firstValue, NSUInteger secondValue) {
    if (firstValue == 0 && secondValue == 0)
        return 1;
    
    NSUInteger r;
    while(secondValue)
    {
        r = firstValue % secondValue;
        firstValue = secondValue;
        secondValue = r;
    }
    return firstValue;
};

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setUserInteractionEnabled:TRUE];
        [self setTranslatesAutoresizingMaskIntoConstraints:FALSE];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setClipsToBounds:FALSE];
        
        [self.layer setFrame:frame];
        [self.layer setBounds:frame];
        [self.layer setBorderColor:[UIColor redColor].CGColor];
        [self.layer setBorderWidth:0.5];
        [self.layer setPosition:CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))];
        
//        draw_control = draw_control_init();
        __weak typeof(ControlView *)w_view = self;
        draw_primary_component = draw_control_init()((ArcControlMeasurements * const)&arcControlMeasurements)(w_view);
//        draw_primary_component = draw_primary_component_init(w_view);
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    draw_secondary_component_init = draw_primary_component(rect);
}

- (void)drawLayer:(CAShapeLayer *)layer inContext:(CGContextRef)ctx {
    __block CGContextRef context = ctx;
    __weak typeof(CAShapeLayer *)w_layer = (CAShapeLayer *)layer;
    handle_touch_control_event = draw_secondary_component_init(w_layer)(context)();
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __weak typeof(NSSet<UITouch *> *)w_touches = touches;
    handle_touch_control_event(w_touches);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __weak typeof(NSSet<UITouch *> *)w_touches = touches;
    handle_touch_control_event(w_touches);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __weak typeof(NSSet<UITouch *> *)w_touches = touches;
    handle_touch_control_event(w_touches);
}

@end
