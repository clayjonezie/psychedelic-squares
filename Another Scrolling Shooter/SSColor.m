//
//  SSColor.m
//  Another Scrolling Shooter
//
//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import "SSColor.h"


@implementation SSColor

+ (UIColor *)colorWithHue:(CGFloat)hue {
  return [UIColor colorWithHue:hue saturation:1.0f brightness:1.0f alpha:1.0f];
}

+ (CGFloat)hueFromColor:(UIColor *)color {
  CGFloat hue;
  [color getHue:&hue saturation:nil brightness:nil alpha:nil];
  return hue;
}

+ (UIColor *)randomColor {
  return [SSColor colorWithHue:skRandf()];
}

+ (UIColor *)oppositeColor:(UIColor *)color {
  CGFloat hue = [SSColor hueFromColor:color];
  
  hue += 0.5;
  hue = fmodf(hue, 1.0f);
  
  return [SSColor colorWithHue:hue];
}

+ (UIColor *)rotateColor:(UIColor *)color {
  CGFloat hue = [SSColor hueFromColor:color];
  hue += 0.001f;
  if (hue > 1.0f) {
    hue = 0.01f;
  }

  return [SSColor colorWithHue:hue];
}

+ (CGFloat)colorDifference:(UIColor *)color1 from:(UIColor *)color2 {
  CGFloat hue1 = [SSColor hueFromColor:color1];
  CGFloat hue2 = [SSColor hueFromColor:color2];
  
  CGFloat diff = fabsf(hue1 - hue2);
  if (diff > 0.5f) {
    if (hue1 < hue2) {
      hue1 += 1.0f;
      diff = fabsf(hue1 - hue2);
    } else {
      hue2 += 1.0f;
      diff = fabsf(hue1 - hue2);
    }
  }
  return diff;
}

@end
