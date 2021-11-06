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


//= {
//    .radius = ^ (CGFloat (^(^(^set_radius)(CGFloat * _Nullable))(void))(void)) {
//        return set_radius;
//    }(^ (CGFloat * __nullable new_radius) {
//        return ^ {
//            if (new_radius && !isnan(*new_radius)) {
//                *radius_ref = *new_radius;
//            } else if (isnan(*radius_ref)) {
//                UserArcControlConfiguration(UserArcControlConfigurationFileOperationRead)(radius_ref);
//            }
//            return ^ CGFloat (void) {
//                return *radius_ref;
//            };
//        };
//    }),
//        .start = ^ (CGFloat (^(^(^set_start)(CGFloat * _Nullable))(void))(void)) {
//            return set_start;
//        }(^ (CGFloat * __nullable new_start) {
//            return ^ {
//                if (new_start) *start_ref = *new_start;
//                return ^ CGFloat (void) {
//                    return *start_ref;
//                };
//            };
//        }),
//        .length = ^ (CGFloat (^(^(^set_length)(CGFloat * _Nullable))(void))(void)) {
//            return set_length;
//        }(^ (CGFloat * __nullable new_length) {
//            return ^ {
//                if (new_length) *length_ref = *new_length;
//                return ^ CGFloat (void) {
//                    return *length_ref;
//                };
//            };
//        }),
//        .end = ^ (CGFloat (^(^(^set_end)(CGFloat * _Nullable))(void))(void)) {
//            return set_end;
//        }(^ (CGFloat * __nullable new_end) {
//            return ^ {
//                if (new_end) *end_ref = *new_end;
//                return ^ CGFloat (void) {
//                    return *end_ref;
//                };
//            };
//        }),
//        .sectors = 10
//};

typedef struct __attribute__((objc_boxable)) ArcDegreesMeasurements ArcDegreesMeasurements;
static CGFloat radius;
static CGFloat * radius_ref = &radius;
static CGFloat start;
static CGFloat * start_ref = &start;
static CGFloat * length_ref;
static CGFloat end;
static CGFloat * end_ref = &end;
static struct __attribute__((objc_boxable)) ArcDegreesMeasurements
{
    __unsafe_unretained CGFloat (^(^(^(^radius)(void))(CGFloat * _Nullable))(void))(void);
    __unsafe_unretained CGFloat (^(^(^(^start)(void))(CGFloat * _Nullable))(void))(void);
    __unsafe_unretained CGFloat (^(^(^(^length)(void))(CGFloat * _Nullable))(void))(void);
    __unsafe_unretained CGFloat (^(^(^(^end)(void))(CGFloat * _Nullable))(void))(void);
    NSUInteger sectors;
} arcDegreesMeasurements = {
    .radius = ^ {
        return ^ (CGFloat (^(^(^set_radius)(CGFloat * _Nullable))(void))(void)) {
            return set_radius;
        }(^ (CGFloat * __nullable new_radius) {
            return ^ {
                if (new_radius && !isnan(*new_radius)) {
                    *radius_ref = *new_radius;
                } else if (isnan(*radius_ref)) {
                    UserArcControlConfiguration(UserArcControlConfigurationFileOperationRead)(radius_ref);
                }
                return ^ CGFloat (void) {
                    return *radius_ref;
                };
            };
        });
    },
        .start = ^ {
            return ^ (CGFloat (^(^(^set_start)(CGFloat * _Nullable))(void))(void)) {
                return set_start;
            }(^ (CGFloat * __nullable new_start) {
                return ^ {
                    if (new_start && !isnan(*new_start)) {
                        *start_ref = *new_start;
                    } else if (isnan(*start_ref)) {
                        *start_ref = 270.0;
                    }
                    return ^ CGFloat (void) {
                        return *start_ref;
                    };
                };
            });
        },
        .length = ^ {
            return ^ (CGFloat (^(^(^set_length)(CGFloat * _Nullable))(void))(void)) {
                return set_length;
            }(^ (CGFloat * __nullable new_length) {
                return ^ {
                    if (new_length && !isnan(*new_length)) {
                        *length_ref = *new_length;
                    } else if (isnan(*length_ref)) {
                        *length_ref = 90.0;
                    }
                    return ^ CGFloat (void) {
                        return *length_ref;
                    };
                };
            });
        },
        .end = ^ {
            return ^ (CGFloat (^(^(^set_end)(CGFloat * _Nullable))(void))(void)) {
                return set_end;
            }(^ (CGFloat * __nullable new_end) {
                return ^ {
                    if (new_end && !isnan(*new_end)) {
                        *end_ref = *new_end;
                    } else if (isnan(*end_ref)) {
                        *end_ref = 360.0;
                    }
                    return ^ CGFloat (void) {
                        return *end_ref;
                    };
                };
            });
        }, .sectors = 10
};

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [(CAShapeLayer *)self.layer setNeedsDisplay];
//        CGFloat flt = 8.0;
//        CGFloat i =
//        ^ (CGFloat(^completion_block)(void)) {
//            return completion_block();
//        }(^ (CGFloat * __nullable local_ptr) {
//            return ^ {
//                return (^ CGFloat (CGFloat * global_ptr) {
//                    *global_ptr = *local_ptr;
//                    return *global_ptr;
//                }(radius_ref));
//            };
//        }(&flt)); // a way to connect the value from a ptr of another object to the ptr in this object
//                  // for example: a ptr value from a touch event (CGPoint.x) to the radius ptr
//        printf("\ni == %f\n", i);
//
//
//        ^ (dispatch_block_t completion_block) {
//            completion_block();
//        }(^ (CAShapeLayer * layer) {
//            printf("\nradius_ref == %f\n", *radius_ref);
//            CGFloat f = 1.0;
//            arcDegreesMeasurements.radius()(&f);
//            printf("\nradius_ref == %f\t\tarcDegreesMeasurements.radius()(&f);\n", *radius_ref);
//            CGFloat g = arcDegreesMeasurements.radius()(&f)()();
//            printf("\nradius_ref == %f\t\tarcDegreesMeasurements.radius()(&f)()();\n", *radius_ref);
//            printf("\ng == %f\n", g);
//            CGFloat h = arcDegreesMeasurements.radius()(nil)()();
//            printf("\nradius_ref == %f\t\tarcDegreesMeasurements.radius()(nil)()();\n", *radius_ref);
//            printf("\nh == %f\n", h);
//            return ^ {
//                [layer setNeedsDisplay];
//            };
//        }((CAShapeLayer *)self.layer));
//
//        CGFloat g = 1.0;
//        CGFloat (^(^(^(^f)(void))(CGFloat * _Nullable))(void))(void) =
//        ^ {
//           return ^ (CGFloat (^(^(^set_end)(CGFloat * _Nullable))(void))(void)) {
//                return set_end;
//            }(^ (CGFloat * __nullable new_end) {
//                return ^ {
//                    if (new_end) *end_ref = *new_end;
//                    return ^ CGFloat (void) {
//                        return *end_ref;
//                    };
//                };
//            });
//        };
        
        
    }
    
    return self;
}



- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
    CGFloat modified_arc_control_radius = 100.0; //arc_control_radius - 42.0;

    CGRect bounds = [layer bounds];
    CGContextTranslateCTM(ctx, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
    
    for (NSUInteger t = (NSUInteger)*start_ref; t <= (NSUInteger)*end_ref; t++) {
        CGFloat angle = degreesToRadians(t);
        
        CGFloat tick_height = (t == (NSUInteger)*start_ref || t == (NSUInteger)*end_ref) ? 10.0 : (t % arcDegreesMeasurements.sectors == 10) ? 6.0 : 3.0;
        {
            CGPoint xy_outer = CGPointMake(((modified_arc_control_radius + tick_height) * cosf(angle)),
                                           ((modified_arc_control_radius + tick_height) * sinf(angle)));
            CGPoint xy_inner = CGPointMake(((modified_arc_control_radius - tick_height) * cosf(angle)),
                                           ((modified_arc_control_radius - tick_height) * sinf(angle)));

            CGContextSetStrokeColorWithColor(ctx, (t == (NSUInteger)*start_ref) ? [[UIColor systemGreenColor] CGColor] : (t == (NSUInteger)*end_ref) ? [[UIColor systemRedColor] CGColor] : [[UIColor systemBlueColor] CGColor]);
            CGContextSetLineWidth(ctx, (t == (NSUInteger)*start_ref || t == (NSUInteger)*end_ref) ? 2.0 : (t % 10 == 0) ? 1.0 : 0.625);
            CGContextMoveToPoint(ctx, xy_outer.x + CGRectGetMidX(bounds), xy_outer.y + CGRectGetMidY(bounds));
            CGContextAddLineToPoint(ctx, xy_inner.x + CGRectGetMidX(bounds), xy_inner.y + CGRectGetMidY(bounds));
        }

        CGContextStrokePath(ctx);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    printf("\n%f\n", ^ (CGFloat(^completion_block)(void)) {
        return completion_block();
    }(^ (CAShapeLayer * layer) {
        return ^ {
            [layer setNeedsDisplay];
            return (^ CGFloat (UITouch * touch) {
//                CGPoint touch_point = CGPointMake(rescale(fmaxf(CGRectGetMinX(touch.view.bounds), fminf(CGRectGetMaxX(touch.view.bounds), [touch locationInView:touch.view].x)),
//                                                          fmaxf(CGRectGetMinY(touch.view.bounds), fminf(CGRectGetMaxY(touch.view.bounds), [touch locationInView:touch.view].y))));
//                                                }(),
//                                                CGRectGetMinX(touch.view.bounds),
//                                                CGRectGetMaxX(touch.view.bounds),
//                                                0.0,
//                                                359.0);
                CGPoint touch_point = CGPointMake(rescale([touch locationInView:touch.view].x,
                                                          CGRectGetMinX(touch.view.bounds),
                                                          CGRectGetMaxX(touch.view.bounds),
                                                          0.0,
                                                          359.0),
                                                  rescale(CGRectGetMaxY(touch.view.bounds) - [touch locationInView:touch.view].y,
                                                          CGRectGetMinY(touch.view.bounds),
                                                          CGRectGetMaxY(touch.view.bounds),
                                                          0.0,
                                                          359.0));
                *start_ref = touch_point.x;
                *end_ref = touch_point.y;
                return *start_ref;
            }(touches.anyObject));
        };
    }((CAShapeLayer *)self.layer)));
}

// To-Do: Gradually inch the edge of the circle to the finger if the finger is not on the edge while dragging (the finger should eventually be connected to the edge of the circle, but not in one jump)

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    printf("\n%f\n", ^ (CGFloat(^completion_block)(void)) {
        return completion_block();
    }(^ (CAShapeLayer * layer) {
        return ^ {
            [layer setNeedsDisplay];
            return (^ CGFloat (UITouch * touch) {
                CGPoint touch_point = CGPointMake(rescale([touch locationInView:touch.view].x,
                                                          CGRectGetMinX(touch.view.bounds),
                                                          CGRectGetMaxX(touch.view.bounds),
                                                          0.0,
                                                          359.0),
                                                  rescale(CGRectGetMaxY(touch.view.bounds) - [touch locationInView:touch.view].y,
                                                          CGRectGetMinY(touch.view.bounds),
                                                          CGRectGetMaxY(touch.view.bounds),
                                                          0.0,
                                                          359.0));
                *start_ref = touch_point.x;
                *end_ref = touch_point.y;
                return *start_ref;
            }(touches.anyObject));
        };
    }((CAShapeLayer *)self.layer)));
}

// To-Do: Animate the edge of the circle meeting the finger is dragging is offset (the edge of the circle should meet where the finger was lifted (?))

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ^ (dispatch_block_t completion_block) {
//        completion_block();
//    }(^ (CAShapeLayer * layer) {
//        arcDegreesMeasurements.start = (NSUInteger)(^ CGFloat (UITouch * touch) {
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
