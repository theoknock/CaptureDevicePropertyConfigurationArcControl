//
//  CaptureDevicePropertyArcControlConfiguration.h
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 11/5/21.
//

#ifndef CaptureDevicePropertyArcControlConfiguration_h
#define CaptureDevicePropertyArcControlConfiguration_h

// Converts degrees to radians.
#define degreesToRadians(angleDegrees) (angleDegrees * M_PI / 180.0)

// Converts radians to degrees.
#define radiansToDegrees(angleRadians) (angleRadians * 180.0 / M_PI)

static float rescale(float old_value, float old_min, float old_max, float new_min, float new_max) {
    return (new_max - new_min) * /*(fmax(old_min, fmin(old_value, old_max))*/ (old_value - old_min) / (old_max - old_min) + new_min;
};

typedef enum : NSUInteger {
    CaptureDeviceConfigurationControlPropertyTorchLevel,
    CaptureDeviceConfigurationControlPropertyLensPosition,
    CaptureDeviceConfigurationControlPropertyExposureDuration,
    CaptureDeviceConfigurationControlPropertyISO,
    CaptureDeviceConfigurationControlPropertyZoomFactor
} CaptureDeviceConfigurationControlProperty;

static NSArray<NSArray<NSString *> *> * const CaptureDeviceConfigurationControlPropertyImageValues = @[@[@"bolt.circle",
                                                                                                         @"viewfinder.circle",
                                                                                                         @"timer",
                                                                                                         @"camera.aperture",
                                                                                                         @"magnifyingglass.circle"],@[@"bolt.circle.fill",
                                                                                                                                      @"viewfinder.circle.fill",
                                                                                                                                      @"timer",
                                                                                                                                      @"camera.aperture",
                                                                                                                                      @"magnifyingglass.circle.fill"]];

static NSArray<NSString *> * const CaptureDeviceConfigurationControlPropertyImageKeys = @[@"CaptureDeviceConfigurationControlPropertyTorchLevel",
                                                                                          @"CaptureDeviceConfigurationControlPropertyLensPosition",
                                                                                          @"CaptureDeviceConfigurationControlPropertyExposureDuration",
                                                                                          @"CaptureDeviceConfigurationControlPropertyISO",
                                                                                          @"CaptureDeviceConfigurationControlPropertyZoomFactor"];

typedef union CaptureDeviceConfigurationControlPropertyUnion {
    NSString * description;
    CaptureDeviceConfigurationControlProperty value;
} CaptureDeviceConfigurationControlPropertyUnion;

typedef struct CaptureDeviceControlPropertyConfigurationStruct {
    NSString * image;
    CaptureDeviceConfigurationControlProperty property;
} CaptureDeviceControlPropertyConfigurationStruct;

typedef enum : NSUInteger {
    CaptureDeviceConfigurationControlStateDeselected,
    CaptureDeviceConfigurationControlStateSelected
} CaptureDeviceConfigurationControlState;

static NSString * (^CaptureDeviceConfigurationControlPropertySymbol)(CaptureDeviceConfigurationControlProperty, CaptureDeviceConfigurationControlState) = ^ NSString * (CaptureDeviceConfigurationControlProperty property, CaptureDeviceConfigurationControlState state) {
    return CaptureDeviceConfigurationControlPropertyImageValues[state][property];
};

static NSString * (^CaptureDeviceConfigurationControlPropertyString)(CaptureDeviceConfigurationControlProperty) = ^ NSString * (CaptureDeviceConfigurationControlProperty property) {
    return CaptureDeviceConfigurationControlPropertyImageKeys[property];
};

static UIImageSymbolConfiguration * (^CaptureDeviceConfigurationControlPropertySymbolImageConfiguration)(CaptureDeviceConfigurationControlState) = ^ UIImageSymbolConfiguration * (CaptureDeviceConfigurationControlState state) {
    switch (state) {
        case CaptureDeviceConfigurationControlStateDeselected: {
            UIImageSymbolConfiguration * symbol_palette_colors = [UIImageSymbolConfiguration configurationWithHierarchicalColor:[UIColor systemBlueColor]];
            UIImageSymbolConfiguration * symbol_font_weight    = [UIImageSymbolConfiguration configurationWithWeight:UIImageSymbolWeightThin];
            UIImageSymbolConfiguration * symbol_font_size      = [UIImageSymbolConfiguration configurationWithPointSize:42.0 weight:UIImageSymbolWeightUltraLight];
            UIImageSymbolConfiguration * symbol_configuration  = [symbol_font_size configurationByApplyingConfiguration:[symbol_palette_colors configurationByApplyingConfiguration:symbol_font_weight]];
            return symbol_configuration;
        }
            break;
            
        case CaptureDeviceConfigurationControlStateSelected: {
            UIImageSymbolConfiguration * symbol_palette_colors_selected = [UIImageSymbolConfiguration configurationWithHierarchicalColor:[UIColor systemYellowColor]];// configurationWithPaletteColors:@[[UIColor systemYellowColor], [UIColor clearColor], [UIColor systemYellowColor]]];
            UIImageSymbolConfiguration * symbol_font_weight_selected    = [UIImageSymbolConfiguration configurationWithWeight:UIImageSymbolWeightRegular];
            UIImageSymbolConfiguration * symbol_font_size_selected      = [UIImageSymbolConfiguration configurationWithPointSize:42.0 weight:UIImageSymbolWeightThin];
            UIImageSymbolConfiguration * symbol_configuration_selected  = [symbol_font_size_selected configurationByApplyingConfiguration:[symbol_palette_colors_selected configurationByApplyingConfiguration:symbol_font_weight_selected]];
            
            return symbol_configuration_selected;
        }
            break;
        default:
            return nil;
            break;
    }
};

static UIImage * (^CaptureDeviceConfigurationControlPropertySymbolImage)(CaptureDeviceConfigurationControlProperty, CaptureDeviceConfigurationControlState) = ^ UIImage * (CaptureDeviceConfigurationControlProperty property, CaptureDeviceConfigurationControlState state) {
    return [UIImage systemImageNamed:CaptureDeviceConfigurationControlPropertySymbol(property, state) withConfiguration:CaptureDeviceConfigurationControlPropertySymbolImageConfiguration(state)];
};

// *********************************

struct __attribute__((objc_boxable)) BezierQuadCurveControlPoints
{
    CGPoint start_point;
    CGPoint end_point;
    CGPoint intermediate_point;
    NSRange time_range;
};
typedef struct BezierQuadCurveControlPoints BezierQuadCurveControlPoints;

//typedef enum : NSUInteger {
//    BezierQuadCurveControlPointStart,
//    BezierQuadCurveControlPointEnd,
//    BezierQuadCurveControlPointIntermediate,
//    BezierQuadCurveControlPointTimeRange
//} BezierQuadCurveControlPointsEnum;

static NSValue * (^(^bezier_quad_curve_control_points)(NSRange, NSRange, CGFloat, NSRange))(void) = ^ (NSRange width_range, NSRange height_range, CGFloat mid_range, NSRange time_range) {
    BezierQuadCurveControlPoints p =
    {
         .start_point        = CGPointMake(width_range.location, height_range.location),
         .end_point          = CGPointMake(width_range.location + width_range.length, height_range.location),
         .intermediate_point = CGPointMake(mid_range, height_range.location + height_range.length),
         .time_range         = time_range
    };
    
    NSValue * points = @(p);
    
    return ^ NSValue * (void) {
        return points;
    };
};

typedef CGPoint (^BezierQuadCurvePoint)(CGFloat time);
static CGPoint (^(^bezier_quad_curve_point)(NSValue * (^)(void)))(CGFloat) = ^ (NSValue * (^bezier_quad_curve_points)(void)) {
    BezierQuadCurveControlPoints p;
    [bezier_quad_curve_points() getValue:&p];
    return ^ CGPoint (CGFloat time) {
        CGFloat t = (time - p.time_range.location) / (p.time_range.length - p.time_range.location);
        CGFloat x = (1 - t) * (1 - t) * p.start_point.x + 2 * (1 - t) * t * p.intermediate_point.x + t * t * p.end_point.x;
        CGFloat y = (1 - t) * (1 - t) * p.start_point.y + 2 * (1 - t) * t * p.intermediate_point.y + t * t * p.end_point.y;
        return CGPointMake(x, y);
    };
};

//typedef UIBezierPath * (^BezierQuadCurvePath)(CGPoint (^)(CGFloat));

static UIBezierPath * (^bezier_quad_curve_path)(CGPoint (^)(CGFloat)) = ^ UIBezierPath * (CGPoint (^bezier_quad_curve_point)(CGFloat)) {
    UIBezierPath * quad_curve = [UIBezierPath bezierPath];
    [quad_curve moveToPoint:bezier_quad_curve_point(0)];
    for (int t = (int)CGRectGetMinX(UIScreen.mainScreen.bounds); t < (int)CGRectGetWidth(UIScreen.mainScreen.bounds); t++) {
        [quad_curve addLineToPoint:bezier_quad_curve_point(t)];
    }
    return quad_curve;
};

typedef UIButton * (^(^PrimaryComponents)(NSArray<NSArray<NSString *> *> * const, typeof(UIView *)))(NSUInteger);
static UIButton * (^(^CaptureDeviceConfigurationPropertyButtons)(NSArray<NSArray<NSString *> *> * const, typeof(UIView *)))(CaptureDeviceConfigurationControlProperty) = ^ (NSArray<NSArray<NSString *> *> * const captureDeviceConfigurationControlPropertyImageNames, typeof(UIView *) controlView) {
    CGFloat button_boundary_length = (CGRectGetMaxX(UIScreen.mainScreen.bounds) - CGRectGetMinX(UIScreen.mainScreen.bounds)) / ((CGFloat)captureDeviceConfigurationControlPropertyImageNames[0].count - 1.0);
    __block NSMutableArray<UIButton *> * buttons = [[NSMutableArray alloc] initWithCapacity:captureDeviceConfigurationControlPropertyImageNames[0].count];
    [captureDeviceConfigurationControlPropertyImageNames[0] enumerateObjectsUsingBlock:^(NSString * _Nonnull imageName, NSUInteger idx, BOOL * _Nonnull stop) {
        [buttons addObject:^ (CaptureDeviceConfigurationControlProperty property) {
            UIButton * button;
            [button = [UIButton new] setTag:property];
            
            [button setBackgroundColor:[UIColor clearColor]];
            [button setShowsTouchWhenHighlighted:TRUE];
            
            [button setImage:[UIImage systemImageNamed:captureDeviceConfigurationControlPropertyImageNames[0][idx] withConfiguration:CaptureDeviceConfigurationControlPropertySymbolImageConfiguration(CaptureDeviceConfigurationControlStateDeselected)] forState:UIControlStateNormal];
            [button setImage:[UIImage systemImageNamed:captureDeviceConfigurationControlPropertyImageNames[1][idx] withConfiguration:CaptureDeviceConfigurationControlPropertySymbolImageConfiguration(CaptureDeviceConfigurationControlStateSelected)] forState:UIControlStateSelected];
            
            [button sizeToFit];
            CGSize button_size = [button intrinsicContentSize];
            [button setFrame:CGRectMake(0.0, 0.0,
                                        button_size.width, button_size.height)];
            [button setCenter:CGPointMake(button_boundary_length * property,
                                          CGRectGetMidY(UIScreen.mainScreen.bounds))];
            
            //            [button setEventHandlerBlock:^ {
            //                BezierQuadCurveControlPoints bezier_quad_curve_plot_points = bezier_quad_curve_control_points(
            //                                                                                                    NSMakeRange(CGRectGetMinX(UIScreen.mainScreen.bounds), (CGRectGetMaxX(UIScreen.mainScreen.bounds) - CGRectGetMinX(UIScreen.mainScreen.bounds))),
            //                                                                                                    NSMakeRange(CGRectGetMidY(UIScreen.mainScreen.bounds) + (button_size.height / 2.0), -button_size.height * 2.0/*CGRectGetMinY(UIScreen.mainScreen.bounds))*/),
            //                                                                                                    button_boundary_length * property,
            //                                                                                                    NSMakeRange(CGRectGetMinX(UIScreen.mainScreen.bounds), (CGRectGetMaxX(UIScreen.mainScreen.bounds) - CGRectGetMinX(UIScreen.mainScreen.bounds)))
            //                                                                                                    );
            //                BezierQuadCurvePoint bezier_quad_curve_point_position = bezier_quad_curve(bezier_quad_curve_plot_points);
            //
            //                CGMutablePathRef quad_curve_path = ^ CGMutablePathRef (NSValue * p) {
            //                    BezierQuadCurveControlPoints points;
            //                    [p getValue:&points];
            //                    UIBezierPath * quad_curve = [UIBezierPath bezierPath];
            //                    [quad_curve moveToPoint:points.start_point];
            //                    [quad_curve addQuadCurveToPoint:points.end_point controlPoint:points.control_point];
            //                    return quad_curve.CGPath;
            //                }(bezier_quad_curve_plot_points());
            //
            //                const CGRect rects[] = { /*CGPathGetBoundingBox(quad_curve_path),*/ CGPathGetPathBoundingBox(quad_curve_path) };
            //                NSUInteger count = sizeof(rects) / sizeof(CGRect);
            //                CGPathAddRects(quad_curve_path, NULL, rects, count);
            //
            //                [(CAShapeLayer *)shape_layer setStrokeColor:[UIColor whiteColor].CGColor];
            //                [(CAShapeLayer *)shape_layer setFillColor:[UIColor clearColor].CGColor];
            //                [(CAShapeLayer *)shape_layer setLineWidth:0.5];
            //                [(CAShapeLayer *)shape_layer setPath:quad_curve_path];
            //
            //
            //                for (UIButton * b in buttons) {
            //                    [b setSelected:(b.tag == [buttons objectAtIndex:property].tag) ? TRUE : FALSE];
            //                    CGFloat t_position = button_boundary_length * b.tag;
            //                    CGPoint position = bezier_quad_curve_point_position(t_position);
            ////                    CGFloat x = rescale(position.x,
            ////                                        CGRectGetMinX(UIScreen.mainScreen.bounds),
            ////                                        CGRectGetMinX(UIScreen.mainScreen.bounds) + ((CGRectGetMaxX(UIScreen.mainScreen.bounds) - CGRectGetMinX(UIScreen.mainScreen.bounds))),
            ////                                        t_position,
            ////                                        CGRectGetMinX(UIScreen.mainScreen.bounds) + ((CGRectGetMaxX(UIScreen.mainScreen.bounds) - CGRectGetMinX(UIScreen.mainScreen.bounds))));
            //                    [UIView animateWithDuration:0.2 animations:^{
            //                        [b setCenter:CGPointMake(position.x, CGRectGetMidY(UIScreen.mainScreen.bounds))];
            //                    }];
            //                }
            //            }];
            //            [button addTarget:button.eventHandlerBlock action:@selector(invoke) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
            
            return ^ UIButton * (void) {
                return button;
            };
        }((CaptureDeviceConfigurationControlProperty)idx)()];
    }];
    return ^ UIButton * (CaptureDeviceConfigurationControlProperty property) {
        return [buttons objectAtIndex:property];
    };
};

struct __attribute__((objc_boxable)) ArcControlDimensions
{
    CGRect bounding_box;
    CGFloat radius;
};
typedef struct ArcControlDimensions ArcControlDimensions;

/*
 = ^ (CAShapeLayer * shape_layer) {
    CGPathRef quad_curve_path_ref = ^ CGPathRef (void) {
        UIBezierPath * quad_curve = [UIBezierPath bezierPath];
        [quad_curve setLineWidth:1.0];
        [quad_curve moveToPoint:start_point];
        for (int t = (int)CGRectGetMinX(UIScreen.mainScreen.bounds); t < (int)CGRectGetWidth(UIScreen.mainScreen.bounds); t++) {
            [quad_curve addLineToPoint:^ CGPoint (CGFloat t) {
                CGFloat rescaled_t = rescale(t, CGRectGetMinX(UIScreen.mainScreen.bounds), CGRectGetWidth(UIScreen.mainScreen.bounds), 0.0, 1.0);
                rescaled_t = fmaxf(0.0, fminf(rescaled_t, 1.0));
                //                    printf("\nt== %f\n", rescaled_t);
                CGFloat x = (1 - rescaled_t) * (1 - rescaled_t) * start_point.x + 2 * (1 - rescaled_t) * rescaled_t * control_point.x + rescaled_t * rescaled_t * end_point.x;
                CGFloat y = (1 - rescaled_t) * (1 - rescaled_t) * start_point.y + 2 * (1 - rescaled_t) * rescaled_t * control_point.y + rescaled_t * rescaled_t * end_point.y;
                return CGPointMake(x, y);
            }(t)];
        }
        return quad_curve.CGPath;
    }();
    [(CAShapeLayer *)shape_layer setStrokeColor:[UIColor whiteColor].CGColor];
    [(CAShapeLayer *)shape_layer setFillColor:[UIColor clearColor].CGColor];
    [(CAShapeLayer *)shape_layer setPath:quad_curve_path_ref];
};
 */

//static void(^ConfigurationforCaptureDeviceProperty)(CaptureDeviceConfigurationControlProperty) = ^ NSString * (CaptureDeviceConfigurationControlProperty control_property) {
//
//                                                    [self setUserInteractionEnabled:TRUE];
//                                                    [self addEventHandler:^(CaptureDeviceConfigurationPropertyReusableButton * sender) {
//                                                        CaptureDeviceConfigurationControlProperty sender_control_property = (CaptureDeviceConfigurationControlProperty)sender.tag;
//
//
//                                                        [UIView animateWithDuration:0.25 animations:^{
//                                                            [self.valueControl setAlpha:0.0];
//
//                                                    //        for (CaptureDeviceConfigurationControlProperty control_property = CaptureDeviceConfigurationControlPropertyTorchLevel; control_property <= CaptureDeviceConfigurationControlPropertyZoomFactor; control_property++) {
//                                                    //            BOOL changeState = (sender_control_property == control_property);
//                                                    //            [ButtonForCaptureDeviceConfigurationControlProperty(control_property) setSelected:changeState];
//                                                    //            [ButtonForCaptureDeviceConfigurationControlProperty(control_property) setHighlighted:changeState];
//                                                    //        }
//
//                                            //                [ButtonForCaptureDeviceConfigurationControlProperty(CaptureDeviceConfigurationControlPropertyTorchLevel) setSelected:TRUE];
//                                            //                [ButtonForCaptureDeviceConfigurationControlProperty(CaptureDeviceConfigurationControlPropertyTorchLevel) setHighlighted:TRUE];
//
//                                                    //        NSIndexPath * selectedIndexPath = [NSIndexPath indexPathForItem:CaptureDeviceConfigurationControlPropertyTorchLevel inSection:0];
//                                                    //        [(PropertyCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath] setCaptureDeviceConfigurationPropertyButtonActiveState:FALSE];
//
//
//
//                                                        } completion:^(BOOL finished) {
//                                                            [captureDevice unlockForConfiguration];
//
//                                                            void(^cameraPropertyConfiguration)(float) = nil;
//                                                            switch (sender_control_property) {
//                                                                case CaptureDeviceConfigurationControlPropertyTorchLevel: {
//                                                                    cameraPropertyConfiguration = ^ (UIScrollView * valueScrollView, AVCaptureDevice * cd, float old_value, float old_min, float old_max) {
//                                                                        CGPoint scrollViewContentOffset = CGPointMake(old_value * CGRectGetWidth(valueScrollView.bounds), valueScrollView.contentOffset.y);
//                                                                        [valueScrollView setContentOffset:scrollViewContentOffset animated:TRUE];
//
//                                                                        return ^ void (float offset) {
//                                                                            float new_value = MAX(old_min, MIN(scale(offset, 0.0, CGRectGetWidth(valueScrollView.bounds), old_min, old_max), old_max));
//                                                                            if (new_value != 0.0 && ([[NSProcessInfo processInfo] thermalState] != NSProcessInfoThermalStateCritical && [[NSProcessInfo processInfo] thermalState] != NSProcessInfoThermalStateSerious))
//                                                                                [cd setTorchModeOnWithLevel:new_value error:nil];
//                                                                            else
//                                                                                [cd setTorchMode:AVCaptureTorchModeOff];
//
//                                                                            [(ValueScrollViewContentViewLayerContent *)self.valueContentView.layer setValue:rescale(new_value, old_min, old_max)];
//                                                                        };
//                                                                    }(self.valueScrollView, captureDevice, [captureDevice torchLevel], 0.0, 1.0);
//                                                                    break;
//                                                                }
//                                                                case CaptureDeviceConfigurationControlPropertyLensPosition: {
//                                                                    cameraPropertyConfiguration = ^ (UIScrollView * valueScrollView, AVCaptureDevice * cd, float old_value, float old_min, float old_max) {
//                                                                        CGPoint scrollViewContentOffset = CGPointMake(old_value * CGRectGetWidth(valueScrollView.bounds), valueScrollView.contentOffset.y);
//                                                                        [valueScrollView setContentOffset:scrollViewContentOffset animated:TRUE];
//
//                                                                        return ^ void (float offset) {
//                                                                            float new_value = MAX(old_min, MIN(scale(offset, 0.0, CGRectGetWidth(valueScrollView.bounds), old_min, old_max), old_max));
//                                                                            [cd setFocusModeLockedWithLensPosition:new_value completionHandler:nil];
//                                                                            [(ValueScrollViewContentViewLayerContent *)self.valueContentView.layer setValue:rescale(new_value, old_min, old_max)];
//                                                                        };
//                                                                    }(self.valueScrollView, captureDevice, captureDevice.lensPosition, 0.0, 1.0);
//                                                                    break;
//                                                                }
//                                                                case CaptureDeviceConfigurationControlPropertyExposureDuration: {
//                                                                    cameraPropertyConfiguration = ^ (UIScrollView * valueScrollView, AVCaptureDevice * cd, float old_value, float old_min, float old_max) {
//                                                                        float rescaled_value = rescale(old_value, old_min, old_max);
//                                                                        float offset_value     = rescaled_value * CGRectGetWidth(valueScrollView.bounds);
//                                                                        CGPoint scrollViewContentOffset = CGPointMake(offset_value, valueScrollView.contentOffset.y);
//                                                                        [valueScrollView setContentOffset:scrollViewContentOffset animated:TRUE];
//
//                                                                        return ^ void (float offset) {
//                                                                            float new_value = MAX(old_min, MIN(scale(offset, 0.0, CGRectGetWidth(valueScrollView.bounds), old_min, old_max), old_max));
//                                                                            CMTime exposureDurationValue = CMTimeMakeWithSeconds(new_value, 1000*1000*1000);
//                                                                            [cd setExposureModeCustomWithDuration:exposureDurationValue ISO:AVCaptureISOCurrent completionHandler:nil];
//
//                                                                            [(ValueScrollViewContentViewLayerContent *)self.valueContentView.layer setValue:rescale(new_value, old_min, old_max)];
//                                                                        };
//                                                                    }(self.valueScrollView, captureDevice, CMTimeGetSeconds([captureDevice exposureDuration]), CMTimeGetSeconds(captureDevice.activeFormat.minExposureDuration), 1.0/3.0);
//                                                                    break;
//                                                                }
//                                                                case CaptureDeviceConfigurationControlPropertyISO: {
//                                                                    cameraPropertyConfiguration = ^ (UIScrollView * valueScrollView, AVCaptureDevice * cd, float old_value, float old_min, float old_max) {
//                                                                        float rescaled_value = rescale(old_value, old_min, old_max);
//                                                                        float offset_value     = rescaled_value * CGRectGetWidth(valueScrollView.bounds);
//                                                                        CGPoint scrollViewContentOffset = CGPointMake(offset_value, valueScrollView.contentOffset.y);
//                                                                        [valueScrollView setContentOffset:scrollViewContentOffset animated:TRUE];
//
//                                                                        return ^ void (float offset) {
//                                                                            float new_value = MAX(old_min, MIN(scale(offset, 0.0, CGRectGetWidth(valueScrollView.bounds), old_min, old_max), old_max));
//                                                                            [cd setExposureModeCustomWithDuration:captureDevice.exposureDuration ISO:new_value completionHandler:nil];
//
//                                                                            [(ValueScrollViewContentViewLayerContent *)self.valueContentView.layer setValue:rescale(new_value, old_min, old_max)];
//                                                                        };
//                                                                    }(self.valueScrollView, captureDevice, captureDevice.ISO, captureDevice.activeFormat.minISO, captureDevice.activeFormat.maxISO);
//                                                                    break;
//                                                                }
//                                                                case CaptureDeviceConfigurationControlPropertyZoomFactor: {
//                                                                    cameraPropertyConfiguration = ^(UIScrollView * valueScrollView, AVCaptureDevice * cd, float old_value, float old_min, float old_max) {
//                                                                        float rescaled_value = rescale(old_value, old_min, old_max);
//                                                                        float offset_value     = rescaled_value * CGRectGetWidth(valueScrollView.bounds);
//                                                                        CGPoint scrollViewContentOffset = CGPointMake(offset_value, valueScrollView.contentOffset.y);
//                                                                        [valueScrollView setContentOffset:scrollViewContentOffset animated:TRUE];
//
//                                                                        return ^ void (float offset) {
//                                                                            float new_value = MAX(old_min, MIN(scale(offset, 0.0, CGRectGetWidth(valueScrollView.bounds), old_min, old_max), old_max));
//                                                                            [cd setVideoZoomFactor:new_value];
//
//                                                                            [(ValueScrollViewContentViewLayerContent *)self.valueContentView.layer setValue:rescale(new_value, old_min, old_max)];
//                                                                        };
//                                                                    }(self.valueScrollView, captureDevice, captureDevice.videoZoomFactor, captureDevice.minAvailableVideoZoomFactor, captureDevice.maxAvailableVideoZoomFactor);
//                                                                    break;
//                                                                }
//                                                                default:
//                                                                    break;
//                                                            }
//
//                                                            configureCameraProperty = ^ (void(^cameraPropertySetter)(float)) {
//                                                                return ^ void (float x) {
//                                                                    dispatch_async(capture_session_configuration_queue_ref(), ^{
//                                                                        cameraPropertySetter(x);
//                                                                    });
//                                                                };
//                                                            }(cameraPropertyConfiguration);
//
//                                                            [UIView animateWithDuration:0.25 animations:^{
//                                                                [self.valueScrollView setAlpha:1.0];
//
//                                                            } completion:^(BOOL finished) {
//                                                                [captureDevice lockForConfiguration:nil];
//                                                            }];
//                                                        }];
//                                                    }  forControlEvents:UIControlEventAllEvents];)


#endif /* CaptureDevicePropertyArcControlConfiguration_h */
