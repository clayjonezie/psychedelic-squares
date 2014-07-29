//
//  SSAboutScene.m
//  Another Scrolling Shooter
//
//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import "SSAboutScene.h"
#import "SSColor.h"

@implementation SSAboutScene

-(id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    /* Setup your scene here */
    
    [self setBackgroundColor:[SSColor randomColor]];
    UIColor *fgColor = [SSColor oppositeColor:self.backgroundColor];
    
    CGFloat height = self.size.height;
    
    [self newMessageLabelNodeWithColor:fgColor andMessage:@"i'm @clay_jones" atY:height - 100];
    [self newMessageLabelNodeWithColor:fgColor andMessage:@"hope you have fun" atY:height - 200];
  }
  return self;
}

@end
