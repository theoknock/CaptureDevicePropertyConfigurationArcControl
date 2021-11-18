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

static void (^(^(^(^(^(^(^draw_control)(ArcControlMeasurements * const))(ControlView *__strong))(CGRect))(CAShapeLayer *__strong))(CGContextRef))(UITouchPhase))(UITouch *);
static void (^(^(^(^(^(^draw_primary_component_init)(ControlView *__strong))(CGRect))(CAShapeLayer *__strong))(CGContextRef))(UITouchPhase))(UITouch *);
static void (^(^(^(^(^draw_primary_component)(CGRect))(CAShapeLayer *__strong))(CGContextRef))(UITouchPhase))(UITouch *);
static void (^(^(^(^draw_secondary_component_init)(CAShapeLayer *__strong))(CGContextRef))(UITouchPhase))(UITouch *);
static void (^(^(^draw_secondary_component)(CGContextRef))(UITouchPhase))(UITouch *);
static void (^(^touch_event_handler_init)(UITouchPhase))(UITouch *);
static void (^touch_event_handler)(UITouch *);

static void (^(^(^(^(^(^(^(^draw_control_init)(__nullable dispatch_block_t))(ArcControlMeasurements * const))(ControlView *__strong))(CGRect))(CAShapeLayer *__strong))(CGContextRef))(UITouchPhase))(UITouch *) =
^ (dispatch_block_t init) {
    if (init) init();
    return (^ (ArcControlMeasurements * const measurements) {
        return (^ (ControlView * view) {
            return (^ (CGRect rect) {
                CGPoint center = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
                UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, view);
                for (CaptureDeviceConfigurationControlProperty property = CaptureDeviceConfigurationControlPropertyTorchLevel; property <= CaptureDeviceConfigurationControlPropertyZoomFactor; property++) {
                    UIButton * button = CaptureDeviceConfigurationPropertyButton(property);
                    double x = (center.x - button.frame.size.width) + ((CGRectGetMidX(rect)) * -cosf(2.0 * M_PI_4 * ((property) / 4.0)));
                    double y = (center.y - button.frame.size.height) + ((CGRectGetMidX(rect)) * -sinf(2.0 * M_PI_4 * ((property) / 4.0)));
                    CGPoint new_center = CGPointMake(x, y);
                    [button setCenter:new_center];
                    static dispatch_once_t onceToken[5];
                    dispatch_once(&onceToken[property], ^{
                        [view addSubview:button];
                    });
                }
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
                            //                           void(^touch_event_handlers[3])(UITouch *) = {touch_event_handler_init(UITouchPhaseBegan), touch_event_handler_init(UITouchPhaseMoved), touch_event_handler_init(UITouchPhaseEnded)};
                            return touch_event_handlers[touch_phase];
                        });
                    });
                });
                //                return (^ (CAShapeLayer * __strong layer) {
                //                    [layer setLineWidth:0.5];
                //                    [layer setStrokeColor:[UIColor systemBlueColor].CGColor];
                //                    [layer setFillColor:[UIColor clearColor].CGColor];
                //                    [layer setBackgroundColor:[UIColor clearColor].CGColor];
                //                       return (^ (CGContextRef context) {
                //                        printf("%s\n", __PRETTY_FUNCTION__);
                //                        return (^ {
                //                            printf("%s\n", __PRETTY_FUNCTION__);
                //                            return (^ (UITouch * touch) {
                //                                printf("TOUCH: %s\n", __PRETTY_FUNCTION__);
                //                                CGPoint touch_point = [touch preciseLocationInView:touch.view];
                //                                printf("\ntouch_point = %s\n", [NSStringFromCGPoint(touch_point) UTF8String]);
                //
                //                                CGPoint tp = CGPointMake(fmaxf(CGRectGetMinX(rect), fminf(CGRectGetMaxX(rect), touch_point.x)),
                //                                                         fmaxf(CGRectGetMinY(rect), fminf(CGRectGetMaxY(rect), touch_point.y)));
                //                                CGFloat radius = sqrt(pow(tp.x - CGRectGetMaxX(rect), 2.0) + pow(tp.y - CGRectGetMaxY(rect), 2.0));
                //
                //                                UIBezierPath * bezier_quad_curve = [UIBezierPath bezierPathWithArcCenter:tp
                //                                                                                                  radius:radius
                //                                                                                              startAngle:degreesToRadians(270.0) endAngle:degreesToRadians(180.0)
                //                                                                                               clockwise:FALSE];
                //                                [layer setPath:bezier_quad_curve.CGPath];
                //                            });
                //                        });
                //                    });
                //                });
            });
        });
    });
};

//void (^(^(^(^(^draw_components_init)(void))(__strong ControlView *))(CGRect rect))(CAShapeLayer * _Nonnull __strong, CGContextRef _Nonnull))(UITouch *__strong) = ^ {
//    return ^ (__strong ControlView * view) {
//        __strong typeof(view) view = view;
//        [view setNeedsDisplay];
//        return ^ (CGRect rect) {
//            ^ void (void(^draw_primary_component)(void)) {
//                draw_primary_component();
//            }(^ {
//            printf("%s", __PRETTY_FUNCTION__);
//            start = 180.0;
//            UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, view);
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
//                    [view addSubview:button];
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
        [self setFrame:frame];
        [self setBounds:frame];
        [self setUserInteractionEnabled:TRUE];
        [self setTranslatesAutoresizingMaskIntoConstraints:FALSE];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setClipsToBounds:FALSE];
        //        [self setContentMode:UIViewContentModeCenter];
        
        [self.layer setFrame:frame];
        [self.layer setBounds:frame];
        [self.layer setBorderColor:[UIColor redColor].CGColor];
        [self.layer setBorderWidth:0.5];
        [self.layer setContentsScale:UIScreen.mainScreen.scale];
        [self.layer setRasterizationScale:UIScreen.mainScreen.scale];
        [self.layer setShouldRasterize:FALSE];
        //
        draw_control = draw_control_init(^ (ControlView * view, CAShapeLayer * shape_layer) {
            return ^ {
                printf("%s\n", __PRETTY_FUNCTION__);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [view setNeedsDisplay];
                    [shape_layer setNeedsDisplay];
                });
                //                    CAReplicatorLayer * replicator_layer = [CAReplicatorLayer new];
                //                    [replicator_layer setBounds:CGRectMake(CGRectGetMidX(shape_layer.bounds), CGRectGetMidY(shape_layer.bounds), 2.0, 10.0)];
                //                    [replicator_layer setFrame:CGRectMake(CGRectGetMidX(shape_layer.bounds), CGRectGetMidY(shape_layer.bounds), 2.0, 10.0)];
                //                    [replicator_layer setContentsScale:UIScreen.mainScreen.scale];
                //                    [replicator_layer setRasterizationScale:UIScreen.mainScreen.scale];
                //                    [replicator_layer setShouldRasterize:FALSE];
                //                    [shape_layer addSublayer:replicator_layer];
                //
                //                    replicator_layer.instanceCount = 100.0;
                //
                //                    CGFloat degree = 90.0;
                //
                //                    CATransform3D transform = CATransform3DIdentity;
                //                    transform = CATransform3DTranslate(transform, 0, 50, 0);
                //                    transform = CATransform3DRotate(transform, degreesToRadians(degree) * M_PI / 180.0, 0.0, 0.0, 1);
                //                    transform = CATransform3DTranslate(transform, 0, -50, 0);
                //                    replicator_layer.instanceTransform = transform;
                //
                //                    //apply a color shift for each instance
                //                    replicator_layer.instanceBlueOffset  = -1.0/100.0;
                //                    replicator_layer.instanceGreenOffset = -1.0/100.0;
                //                    replicator_layer.instanceGreenOffset = -1.0/100.0;
                //
                //                    CALayer * replicated_layer = [CALayer new];
                //                    [replicated_layer setContentsScale:UIScreen.mainScreen.scale];
                //                    [replicated_layer setRasterizationScale:UIScreen.mainScreen.scale];
                //                    [replicated_layer setShouldRasterize:FALSE];
                //                    [replicated_layer setBackgroundColor:[UIColor systemYellowColor].CGColor];
                //                    [replicated_layer setBounds:CGRectMake(CGRectGetMidX(shape_layer.bounds), CGRectGetMidY(shape_layer.bounds), 2.0, 10.0)];
                //                    [replicated_layer setPosition:CGPointMake(CGRectGetMidX(shape_layer.bounds), CGRectGetMidY(shape_layer.bounds))];
                //                    [replicator_layer addSublayer:replicated_layer];
            };
        }(self, (CAShapeLayer *)self.layer));
        draw_primary_component_init = draw_control((ArcControlMeasurements * const)&arcControlMeasurements);
        draw_primary_component = draw_primary_component_init(self);
        draw_secondary_component_init = draw_primary_component(frame);
    }
    
    return self;
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
    ^ (UITouch * touch) {
            (!touch_event_handler_init(touch.phase) ?: touch_event_handler_init(touch.phase)(touch));
        }(touches.anyObject);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ^ (UITouch * touch) {
            (!touch_event_handler_init(touch.phase) ?: touch_event_handler_init(touch.phase)(touch));
        }(touches.anyObject);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ^ (UITouch * touch) {
            (!touch_event_handler_init(touch.phase) ?: touch_event_handler_init(touch.phase)(touch));
        }(touches.anyObject);
}

@end


////
////  controlView.m
////  CaptureDevicePropertyConfigurationArcControl
////
////  Created by Xcode Developer on 11/5/21.
////
//
//#import "ControlView.h"
//#import "CaptureDevicePropertyArcControlConfiguration.h"
//
//@implementation ControlView
//
//@dynamic layer;
//
//+ (Class)layerClass {
//    return [CAShapeLayer class];
//}
//
//typedef struct __attribute__((objc_boxable)) ArcControlMeasurements ArcControlMeasurements;
//static double center[2] = {0.0, 0.0};
//static double radius    = 380.0;
//static double angle     = 180.0;
//static double start     = 180.0;
//static double length    = 22.5;
//static double end       = 270.0;
//static int    sectors   = 10;
//static int    units     = 10;
//static double range[2]  = {0.0, 1.0};
//static double value;
//static CGRect (^bounds)(void) = ^ { return CGRectMake(center[0] + radius, center[1] - radius, radius, radius); };
//
//double * const center_ptr  = &center[2];
//double * const radius_ptr  = &radius;
//double * const angle_ptr   = &angle;
//double * const start_ptr   = &start;
//double * const length_ptr  = &length;
//double * const end_ptr     = &end;
//int    * const sectors_ptr = &sectors;
//int    * const units_ptr   = &units;
//double * const range_ptr   = &range[2];
//double * const value_ptr   = &value;
//
//static struct __attribute__((objc_boxable)) ArcControlMeasurements
//{
//    double * const center_ptr;
//    double * const radius_ptr;
//    double * const angle_ptr;
//    double * const start_ptr;
//    double * const length_ptr;
//    double * const end_ptr;
//    int    * const sectors_ptr;
//    int    * const int_ptr;
//    double * const range_ptr;
//    double * const value_ptr;
//    __unsafe_unretained CGRect (^bounds)(void);
//} arcControlMeasurements = {
//    .radius_ptr  = &radius,
//    .angle_ptr   = &angle,
//    .center_ptr  = &center[2],
//    .start_ptr   = &start,
//    .length_ptr  = &length,
//    .end_ptr     = &end,
//    .sectors_ptr = &sectors,
//    .range_ptr   = &range[2],
//    .value_ptr   = &value,
//    .bounds  = ^ CGRect { return CGRectMake(((double *)center_ptr)[0] + *radius_ptr, ((double *)center_ptr)[1] - *radius_ptr, *radius_ptr, *radius_ptr); },
//};
//
//static void (^(^(^(^(^(^(^draw_control)(ArcControlMeasurements * const))(ControlView *__strong))(CGRect))(CAShapeLayer *__strong))(CGContextRef __nullable))(UITouchPhase))(UITouch *);
//static void (^(^(^(^(^(^draw_primary_component_init)(ControlView *__strong))(CGRect))(CAShapeLayer *__strong))(CGContextRef __nullable))(UITouchPhase))(UITouch *);
//static void (^(^(^(^(^draw_primary_component)(CGRect))(CAShapeLayer *__strong))(CGContextRef __nullable))(UITouchPhase))(UITouch *);
//static void (^(^(^(^draw_secondary_component_init)(CAShapeLayer *__strong))(CGContextRef __nullable))(UITouchPhase))(UITouch *);
//static void (^(^(^draw_secondary_component)(CGContextRef __nullable))(UITouchPhase))(UITouch *);
//
////static void (^(^(^touch_event_handlers_init)(UITouchPhase))(UITouch *))(NSArray<NSNumber *> *) = ^ void (NSArray<NSNumber *> * touch_phases) {
////    __block NSMutableDictionary<NSNumber *, void(^)(UITouch *)> * touch_event_handlers = [[NSMutableDictionary alloc] initWithCapacity:touch_phases.count];
////    static void (^(^touch_event_handler)(UITouchPhase))(UITouch *) = ^ (UITouchPhase touch_phase) {
////        [touch_event_handlers enumerateObjectsUsingBlock:^(NSNumber * _Nonnull touch_phase_obj, NSUInteger idx, BOOL * _Nonnull stop) {
////            [touch_event_handlers setObject:^ (UITouchPhase phase) {
////                return ^ (UITouch * touch) {
////
////                };
////            }(touch_phase) forKey:touch_phase_obj];
////        }];
////        return [touch_event_handlers objectForKey:@(touch_phase)];
////    };
////}/*(@[@(UITouchPhaseBegan), @(UITouchPhaseMoved), @(UITouchPhaseEnded)]);*/
//
//
//
//static void (^(^(^(^(^(^(^(^draw_control_init)(__nullable dispatch_block_t))(ArcControlMeasurements * const))(ControlView *__strong))(CGRect))(CAShapeLayer *__strong))(CGContextRef __nullable))(UITouchPhase))(UITouch *) =
//^ (dispatch_block_t init) {
//    return (^ (ArcControlMeasurements * const measurements) {
//        return (^ (ControlView * view) {
//            return (^ (CGRect rect) {
//                printf("\ndrawRect:%s\n", [NSStringFromCGRect(rect) UTF8String]);
//                (!init) ?: init();
//                UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, view);
//                for (CaptureDeviceConfigurationControlProperty property = CaptureDeviceConfigurationControlPropertyTorchLevel; property < CaptureDeviceConfigurationControlPropertyDefault; property++) {
//                    UIButton * button = CaptureDeviceConfigurationPropertyButton(property);
//                    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
//                    CGFloat radius = (center.x);
//                    double angle = 180.0 + (90.0 * ((property) / 4.0));
//                    UIBezierPath * bezier_quad_curve = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))
//                                                                                      radius:radius
//                                                                                  startAngle:degreesToRadians(angle) endAngle:degreesToRadians(angle)
//                                                                                   clockwise:FALSE];
//                    [button setCenter:[bezier_quad_curve currentPoint]];
//                    static dispatch_once_t onceToken[CaptureDeviceConfigurationControlPropertyDefault];
//                    dispatch_once(&onceToken[property], ^{
//                        [view addSubview:button];
//                    });
//                }
//                return (^ (CAShapeLayer * __strong layer) {
//                    [layer setLineWidth:1.0];
//                    [layer setFillColor:[UIColor clearColor].CGColor];
//                    [layer setBackgroundColor:[UIColor clearColor].CGColor];
//                    (!init) ?: init();
//                    return (^ (CGContextRef __nullable context) {
//                        __block NSMutableArray<void(^)(UITouch *)> * touch_event_handlers = [[NSMutableArray alloc] initWithCapacity:3]; //void(^touch_event_handlers[3])(UITouch *);
//                        return (^ (UITouchPhase touch_phase) {
//                            touch_event_handlers[touch_phase] = ^ (void(^display_path)(CGPathRef)) {
//                                CGPoint center = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
//                                return ^ (UITouch * touch) {
//                                    CGPoint tp = [touch preciseLocationInView:touch.view];
//                                    CGFloat radius = sqrt(pow(tp.x - center.x, 2.0) + pow(tp.y - center.y, 2.0));
//                                    UIBezierPath * bezier_quad_curve = [UIBezierPath bezierPathWithArcCenter:center
//                                                                                                      radius:radius
//                                                                                                  startAngle:degreesToRadians(270.0) endAngle:degreesToRadians(180.0)
//                                                                                                   clockwise:FALSE];
//                                    display_path(bezier_quad_curve.CGPath);
//                                };
//                            }(^{
//                                UIColor * stroke_color = (touch_phase == UITouchPhaseMoved) ? [UIColor systemGreenColor] : [UIColor systemRedColor];
//                                return ^ (CGPathRef bezier_path_ref) {
//                                    [layer setStrokeColor:stroke_color.CGColor];
//                                    [layer setPath:bezier_path_ref];
//                                };
//                            }());
////                           void(^touch_event_handlers[3])(UITouch *) = {touch_event_handler_init(UITouchPhaseBegan), touch_event_handler_init(UITouchPhaseMoved), touch_event_handler_init(UITouchPhaseEnded)};
//                            return touch_event_handlers[touch_phase];
//                        });
//                    });
//                });
//            });
//        });
//    });
//};
//
//-(void)awakeFromNib {
//    [super awakeFromNib];
//
//    draw_control_init(^ (ControlView * view, CAShapeLayer * layer) {
//        return ^ {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [view setNeedsDisplay];
//                [layer setNeedsDisplay];
//            });
//        };
//    }(self, (CAShapeLayer *)self.layer))((ArcControlMeasurements * const)&arcControlMeasurements)(self)(self.bounds)((CAShapeLayer *)self.layer)(nil);
//
//    for (UITouchPhase touch_phase = UITouchPhaseBegan; touch_phase < UITouchPhaseEnded; touch_phase++) {
//        (!touch_event_handler_init) ?: ^ { handle_touch_event[touch_phase] = touch_event_handler_init(touch_phase); }();
//    }
//}
//
//- (void)drawRect:(CGRect)rect {
//    (!draw_primary_component) ?:
//    ^ { draw_secondary_component_init = draw_primary_component(rect);
//    }();
//}
//
//- (void)drawLayer:(CAShapeLayer *)layer inContext:(CGContextRef)ctx {
//    (!draw_secondary_component_init) ?:
//    ^ { draw_secondary_component = draw_secondary_component_init(layer);
//        draw_secondary_component(ctx);
//    }();
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    touch_event_handler(UITouchPhaseBegan)(touches.anyObject);
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ^ (UITouch * touch) {
//        (!handle_touch_event[touch.phase]) ?: handle_touch_event[touch.phase](touch);
//    }(touches.anyObject);
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ^ (UITouch * touch) {
//        (!handle_touch_event[touch.phase]) ?: handle_touch_event[touch.phase](touch);
//    }(touches.anyObject);
//}
//
//@end
