//
//  SSHelper.m
//  Another Scrolling Shooter
//
//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import "SSHelper.h"

@implementation SSHelper

+ (NSString *)randomNote {
  NSArray *notes = @[@"A.mp3", @"B.mp3", @"C.mp3", @"D.mp3", @"E.mp3", @"F.mp3", @"G.mp3"];
  return notes[rand() % [notes count]];
}

@end

CGFloat skRandf() {
  return rand() / (CGFloat) RAND_MAX;
}

CGFloat skRand(CGFloat low, CGFloat high) {
  return skRandf() * (high - low) + low;
}
