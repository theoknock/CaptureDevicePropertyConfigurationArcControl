//
//  PreviewView.m
//  CaptureDevicePropertyConfigurationArcControl
//
//  Created by Xcode Developer on 12/14/21.
//

#import "PreviewView.h"

@implementation PreviewView

+ (Class)layerClass {
    return [AVCaptureVideoPreviewLayer class];
}

@end
