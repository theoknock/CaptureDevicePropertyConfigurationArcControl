//
//  controlView.m
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/5/21.
//

#import "ControlView.h"
#import "CaptureDevicePropertyArcControlConfiguration.h"

@implementation ControlView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

//static CGRect arc_control_bounds;
//static CGRect (^arc_control_bounds_ref)(CGRect) = ^ CGRect (CGRect parent_rect) {
//    return CGRectMake(CGRectGetMaxX(parent_rect) - arc_control_radius,
//                      CGRectGetMaxY(parent_rect) - arc_control_radius,
//                      arc_control_radius,
//                      arc_control_radius);
//};

/*
 You need to specify whether you are traversing the circle positively or negatively. I will discuss the positive (counterclockwise) case; the negative case is computed in the same way with obvious changes.
 
 For the positive direction, the circle's center is to the left of the arc. Just add 90 degrees to the bearing and travel for the radial distance and stop: that's the center. Now we know the circle's center and radius, we can find any point on it. The bearing from the center to a point on the circle is 90 degrees less than the bearing around the circle (in the positive direction).
 
 Here are some formulas. The start point has coordinates (x1,x2), the radius is r, and the bearing is alpha. (I use the mathematical convention that 0 is due east, 90 is north.) We seek the coordinates (y1,y2) of the endpoint where the new bearing will be beta. Let the origin's coordinates be (o1,o2).
 
 The direction vector for bearing alpha is (by definition)
 
 (cos(alpha), sin(alpha))
 Rotating this 90 degrees to the left gives the unit vector
 
 (-sin(alpha), cos(alpha))
 Moving along this from (x0,x1) by distance r ends up at
 
 (o1,o2) = (x1,x2) + r * (-sin(alpha), cos(alpha))
 That's the circle's center.
 The bearing from the center to the end point is beta - 90 degrees. The endpoint is reached by moving a distance r in this direction, whence
 
 (y1,y2) = (o1,o2) + r * (cos(beta-90), sin(beta-90))
 */

// To-Do: Replace CGdouble pointers with a variadic argument so that normal doubles can be passed in or omitted without specifying 'nil'

//typedef double (^ArcDegreeMeasurement)(int argument_count, ...);
typedef struct __attribute__((objc_boxable)) ArcDegreesMeasurements ArcDegreesMeasurements;
static double radius = 0.0;
static double * const radius_ref = &radius;
static double angle = 180.0;
static double * const angle_ref = &angle;
static double start = 180.0;
static double * const start_ref = &start;
static double length = 22.5;
static double * const length_ref = &length;
static double end = 270.0;
static double * const end_ref = &end;
static double * measurements_ptr;
static struct __attribute__((objc_boxable)) ArcDegreesMeasurements
{
    __unsafe_unretained double (^(^(^(^radius)(void))(double * _Nullable))(void))(void);
    __unsafe_unretained double (^(^(^(^angle)(void))(double * _Nullable))(void))(void);
    __unsafe_unretained double (^(^(^(^start)(void))(double * _Nullable))(void))(void);
    __unsafe_unretained double (^(^(^(^length)(void))(double * _Nullable))(void))(void);
    __unsafe_unretained double (^(^(^(^end)(void))(double * _Nullable))(void))(void);
    NSUInteger sectors;
} arcDegreesMeasurements = {
    .radius = ^ {
        return ^ (double (^(^(^set_radius)(double * _Nullable))(void))(void)) {
            return set_radius;
        }(^ (double * __nullable new_radius) {
            return ^ {
                if (new_radius && !isnan(*new_radius)) {
                    *radius_ref = *new_radius;
                } else {
                    radius = 407.0; //UserArcControlConfiguration(UserArcControlConfigurationFileOperationRead)(&radius_);
                }
                return ^ double (void) {
                    return *radius_ref;
                };
            };
        });
    },
        .angle = ^ {
            return ^ (double (^(^(^set_angle)(double * _Nullable))(void))(void)) {
                return set_angle;
            }(^ (double * __nullable new_angle) {
                return ^ {
                    if (new_angle && !isnan(*new_angle)) {
                        *angle_ref = *new_angle;
                    }
                    return ^ double (void) {
                        return *angle_ref;
                    };
                };
            });
        },
        .start = ^ {
            return ^ (double (^(^(^set_start)(double * _Nullable))(void))(void)) {
                return set_start;
            }(^ (double * __nullable new_start) {
                return ^ {
                    if (new_start && !isnan(*new_start)) {
                        *start_ref = *new_start;
                    }
                    return ^ double (void) {
                        return *start_ref;
                    };
                };
            });
        },
        .length = ^ {
            return ^ (double (^(^(^set_length)(double * _Nullable))(void))(void)) {
                return set_length;
            }(^ (double * __nullable new_length) {
                return ^ {
                    if (new_length && !isnan(*new_length)) {
                        *length_ref = *new_length;
                    }
                    return ^ double (void) {
                        return *length_ref;
                    };
                };
            });
        },
        .end = ^ {
            return ^ (double (^(^(^set_end)(double * _Nullable))(void))(void)) {
                return set_end;
            }(^ (double * __nullable new_end) {
                return ^ {
                    if (new_end && !isnan(*new_end)) {
                        *end_ref = *new_end;
                    }
                    return ^ double (void) {
                        return *end_ref;
                    };
                };
            });
        }, .sectors = 10
};

typedef NS_OPTIONS(NSUInteger, ArcDegreesMeasurementOption) {
    ArcDegreesMeasurementOptionStart= 1 << 0,
    ArcDegreesMeasurementOptionEnd = 1 << 1,
    ArcDegreesMeasurementOptionRadius = 1 << 2
};


typedef double * (^arc_degree_measurement_blk)(ArcDegreesMeasurementOption measurement_options, ...);
arc_degree_measurement_blk measurement_blk = ^ double * (ArcDegreesMeasurementOption measurement_options, ...) {
    va_list ap;
    va_list * ap_ptr = &ap;
    va_start(ap, measurement_options); // To-Do: get a number of options

//       for ( i = 0; i < 10; i++ ) {
//          printf( "*(p + %f) : %fd\n", i, *(p + i));
//       }
    
    
    
    __block double measurement;
    __block double * measurements = &measurement;
    for (int i = 0; i < measurement_options; i++) {
        measurement = (^ double {
            ArcDegreesMeasurementOption option = 1 << i;
          switch (option) {
              case ArcDegreesMeasurementOptionStart:
                  start = va_arg (*ap_ptr, double);
                  printf("start[%d] == %f\n", i, start);
                  return *start_ref;
                  break;
              case ArcDegreesMeasurementOptionEnd:
                  end = va_arg (*ap_ptr, double);
                  printf("end[%d] == %f\n", i, end);
                  return *end_ref;
                  break;
              case ArcDegreesMeasurementOptionRadius:
                  radius = va_arg (*ap_ptr, double);
                  printf("radius[%d] == %f\n", i, radius);
                  return *radius_ref;
                  break;
              default:
                  return *start_ref;
                  break;
          }
//            measurements = &measurement;
        }());
    }
    va_end (ap);
    
//
//    for (int i = 3; i < 3; i++) {
//        printf("measurements[%d] == %f\n", i, (double)measurements_ptr[i]);
//    }
    
    return measurements;
};

- (void)iterateArray {
    double * measurements = (measurement_blk(ArcDegreesMeasurementOptionStart | ArcDegreesMeasurementOptionEnd  | ArcDegreesMeasurementOptionRadius, 0.0, 360.0, 407.0));
    for (int i = 3; i < 3; i++) {
        printf("%s", __PRETTY_FUNCTION__);
               //        printf("measurements[%d] == %f\n", i, *(measurements + i));
    }
}

// To-Do: Don't rotate the arc control; tap value on scale instead

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
//        [self iterateArray];
//
        [self.layer setFrame:frame];//CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), 100.0, 100.0)];
         [self.layer setBounds:frame];//CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), 100.0, 100.0)];//CGRectMake(CGRectGet530MinX(self.frame), CGRectGetMinY(self.frame), CGRectGetMaxY(self.frame), CGRectGetMaxY(self.frame))];
        [self.layer setBorderColor:[UIColor redColor].CGColor];
        [self.layer setBorderWidth:0.5];
        [self.layer setPosition:CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))];
        [self.layer setNeedsDisplay];
        
        [self setUserInteractionEnabled:TRUE];
        [self setTranslatesAutoresizingMaskIntoConstraints:FALSE];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setClipsToBounds:FALSE];
//        UserArcControlConfiguration(UserArcControlConfigurationFileOperationRead)(&radius);
//        printf("\nRead radius of %f\n", radius);
        int a = 530, x = 53, m = 62, n = 12, b = (a + x) % m;
        
        printf("b = %d\n", b);
        //(530 + x) % 62 = 25;
        //how to get x?
        
        x = (b - a) % m;
        printf("x = %d\n", x);
    }
    
    return self;
}


// To-Do: Draw both the original arc control *and* the new one
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGRect bounds = [layer bounds];
    CGContextTranslateCTM(ctx, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
    CGFloat new_radius = arcDegreesMeasurements.radius()(nil)()() - 48.0; // 48.0 is buttons' (below) intrinsic content width
    CGFloat *new_radius_ptr = &new_radius;
//    printf("\n1.\tarcDegreesMeasurements.radius()(nil)()() == %f\n", arcDegreesMeasurements.radius()(nil)()());
    arcDegreesMeasurements.radius()(new_radius_ptr)()();
//    printf("\n2.\tarcDegreesMeasurements.radius()(new_radius_ptr)()() == %f\n", arcDegreesMeasurements.radius()(new_radius_ptr)()());
    
    
//    CGFloat new_start  = 180.0;
//    for (NSUInteger t = (NSUInteger)arcDegreesMeasurements.start()(nil)()(); t <= (NSUInteger)arcDegreesMeasurements.end()(nil)()(); t++) {
    NSUInteger t = arcDegreesMeasurements.start()(nil)()();
        CGFloat angle = degreesToRadians(t);
        CGFloat tick_height = (t == 180 || t == 269) ? 10.0 : (t % arcDegreesMeasurements.sectors == 10) ? 10.0 : 10.0;
        {
            CGPoint xy_outer = CGPointMake(((arcDegreesMeasurements.radius()(new_radius_ptr)()() + tick_height) * cosf(angle)),
                                           ((arcDegreesMeasurements.radius()(new_radius_ptr)()() + tick_height) * sinf(angle)));
            CGPoint xy_inner = CGPointMake(((arcDegreesMeasurements.radius()(new_radius_ptr)()() - tick_height) * cosf(angle)),
                                           ((arcDegreesMeasurements.radius()(new_radius_ptr)()() - tick_height) * sinf(angle)));
//            printf("\n3.\tarcDegreesMeasurements.radius()(nil)()() == %f\n", arcDegreesMeasurements.radius()(nil)()());
            
            
            CGContextSetStrokeColorWithColor(ctx, (t == 180) ? [[UIColor systemGreenColor] CGColor] : (t == 269) ? [[UIColor systemRedColor] CGColor] : [[UIColor systemYellowColor] CGColor]);
            CGContextSetLineWidth(ctx, (t == 180 || t == 269) ? 3.0 : ((NSUInteger)t % 10 == 0) ? 2.0 : 1.0);
            CGContextMoveToPoint(ctx, xy_outer.x + CGRectGetMaxX(bounds), xy_outer.y + CGRectGetMaxY(bounds));
            CGContextAddLineToPoint(ctx, xy_inner.x + CGRectGetMaxX(bounds), xy_inner.y + CGRectGetMaxY(bounds));
        }

        CGContextStrokePath(ctx);
//    }
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat start_offset = 180.0;
        //        CGFloat angle_sector = (((arcDegreesMeasurements.end()(nil)()() - arcDegreesMeasurements.start()(nil)()()) / CaptureDeviceConfigurationControlPropertyImageKeys.count));
        UIButton * (^CaptureDeviceConfigurationPropertyButton)(CaptureDeviceConfigurationControlProperty) = CaptureDeviceConfigurationPropertyButtons(CaptureDeviceConfigurationControlPropertyImageValues, (CAShapeLayer *)self.layer);
        for (CaptureDeviceConfigurationControlProperty property = 0; property < CaptureDeviceConfigurationControlPropertyImageKeys.count; property++) {
            UIButton * button = CaptureDeviceConfigurationPropertyButton(property);
                CGFloat a = arcDegreesMeasurements.start()(&start_offset)()() + (arcDegreesMeasurements.length()(nil)()() * property);
                printf("\t\t\tarcDegreesMeasurements.angle()(&a)()() == %f\n", arcDegreesMeasurements.angle()(&a)()()); // DO NOT COMMENT OR REMOVE THIS LINE
                CGFloat x = CGRectGetMaxX(bounds) + (arcDegreesMeasurements.radius()(nil)()() * cosf(degreesToRadians( arcDegreesMeasurements.angle()(nil)()() )));
                CGFloat y = CGRectGetMaxY(bounds) + (arcDegreesMeasurements.radius()(nil)()() * sinf(degreesToRadians( arcDegreesMeasurements.angle()(nil)()() )));
                CGPoint old_center = CGPointMake(x, y);
                printf("old_center.x == %f\t\told.center.y == %f\n", x, y);
                CGPoint new_center = CGPointMake(rescale(x,
                                                         CGRectGetMaxX(bounds) - arcDegreesMeasurements.radius()(nil)()(),
                                                         CGRectGetMaxX(bounds),
                                                         (CGRectGetMaxX(bounds) - arcDegreesMeasurements.radius()(nil)()()) + (24.0),
                                                         CGRectGetMaxX(bounds) - (48.0)),
                                                 rescale(y,
                                                         CGRectGetMaxY(bounds) - arcDegreesMeasurements.radius()(nil)()(),
                                                         CGRectGetMaxY(bounds),
                                                         (CGRectGetMaxY(bounds) - arcDegreesMeasurements.radius()(nil)()()) + (24.0),
                                                         CGRectGetMaxY(bounds) - (48.0)));
//                printf("\n1.\tarcDegreesMeasurements.radius()(nil)()() == %f\n", arcDegreesMeasurements.radius()(nil)()());
                
                // CGPoint new_center = CGPointMake(fminf(x, CGRectGetMaxX(bounds) - (button.intrinsicContentSize.width / 2.0)), fminf(y, CGRectGetMaxY(bounds) - (button.intrinsicContentSize.height / 2.0)));
                printf("new_center.x == %f\t\tnew_center.y == %f\n", new_center.x, new_center.y);
//                printf("\nbutton.intrinsicContentSize == %f\n", button.intrinsicContentSize.height);
                [button setCenter:new_center];
                printf("btn.center.x == %f\t\tbtn.center.y == %f\n", button.center.x, button.center.y);
                [self addSubview:button];
        }
    });
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __block CGAffineTransform transform;
    ^ void (dispatch_block_t completion_block) {
        return (^ (UITouch * touch) {
            CGPoint touch_point = CGPointMake(rescale([touch locationInView:touch.view].x,
                                                      CGRectGetMinX(touch.view.bounds),
                                                      CGRectGetMaxX(touch.view.bounds),
                                                      180.0,
                                                      270.0),
                                              rescale(CGRectGetMaxY(touch.view.bounds) - [touch locationInView:touch.view].y,
                                                      CGRectGetMinY(touch.view.bounds),
                                                      CGRectGetMaxY(touch.view.bounds),
                                                      180.0,
                                                      270.0));
            arcDegreesMeasurements.start()(&touch_point.x)()();
            arcDegreesMeasurements.end()(&touch_point.y)()();
            transform = CGAffineTransformMakeRotation(degreesToRadians(arcDegreesMeasurements.start()(nil)()()));
            
            completion_block();
        }(touches.anyObject));
    }(^ (ControlView * self) {
        return ^ {
//            [self setTransform:transform];
            [self.layer setNeedsDisplay];
        };
    }((self)));
}

// To-Do: Gradually inch the edge of the circle to the finger if the finger is not on the edge while dragging (the finger should eventually be connected to the edge of the circle, but not in one jump)

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __block CGAffineTransform transform;
    ^ void (dispatch_block_t completion_block) {
        return (^ (UITouch * touch) {
            CGPoint touch_point = CGPointMake(rescale([touch locationInView:touch.view].x,
                                                      CGRectGetMinX(touch.view.bounds),
                                                      CGRectGetMaxX(touch.view.bounds),
                                                      180.0,
                                                      270.0),
                                              rescale(CGRectGetMaxY(touch.view.bounds) - [touch locationInView:touch.view].y,
                                                      CGRectGetMinY(touch.view.bounds),
                                                      CGRectGetMaxY(touch.view.bounds),
                                                      180.0,
                                                      270.0));
            arcDegreesMeasurements.start()(&touch_point.x)()();
            arcDegreesMeasurements.end()(&touch_point.y)()();
            transform = CGAffineTransformMakeRotation(degreesToRadians(arcDegreesMeasurements.start()(nil)()()));
            
            completion_block();
        }(touches.anyObject));
    }(^ (ControlView * self) {
        return ^ {
//            [self setTransform:transform];
            [self.layer setNeedsDisplay];
        };
    }((self)));
}

// To-Do: Animate the edge of the circle meeting the finger is dragging is offset (the edge of the circle should meet where the finger was lifted (?))

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ^ (dispatch_block_t completion_block) {
//        completion_block();
//    }(^ (CAShapeLayer * layer) {
//        arcDegreesMeasurements.start = (NSUInteger)(^ CGdouble (UITouch * touch) {
//            return rescale(
//                           ^ CGPoint (void) {
//                               return CGPointMake(fmaxf(CGRectGetMinX(touch.view.bounds), fminf(CGRectGetMaxX(touch.view.bounds), [touch locationInView:touch.view].x)),
//                                                  fmaxf(CGRectGetMinY(touch.view.bounds), fminf(CGRectGetMaxY(touch.view.bounds), [touch locationInView:touch.view].y)));
//                           }().x,
//                           CGRectGetMinX(touch.view.bounds),
//                           CGRectGetMaxX(touch.view.bounds),
//                           0.0,
//                           359.0);
//        }(touches.anyObject));
//        return ^ {
//            [layer setNeedsDisplay];
//        };
//    }((CAShapeLayer *)self.layer));
}

@end
