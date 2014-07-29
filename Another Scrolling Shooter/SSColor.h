//
//  SSColor.h
//  Another Scrolling Shooter
//
//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSColor : NSObject

+ (UIColor *)colorWithHue:(CGFloat)hue;
+ (UIColor *)randomColor;
+ (UIColor *)oppositeColor:(UIColor *)color;
+ (CGFloat)hueFromColor:(UIColor *)color;
+ (UIColor *)rotateColor:(UIColor *)color;
+ (CGFloat)colorDifference:(UIColor *)color1 from:(UIColor *)color2;

@end
