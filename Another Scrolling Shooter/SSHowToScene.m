//
//  SSHowToScene.m
//  Another Scrolling Shooter
//
//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import "SSHowToScene.h"
#import "SSColor.h"

@implementation SSHowToScene

-(instancetype)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    [self setBackgroundColor:[SSColor randomColor]];
    UIColor *fgColor = [SSColor oppositeColor:self.backgroundColor];
    
    CGFloat height = self.size.height;
    
    [self newMessageLabelNodeWithColor:fgColor andMessage:@"you will change colors" atY:height - 50];
    [self newMessageLabelNodeWithColor:fgColor andMessage:@"so will the background" atY:height - 100];
    [self newMessageLabelNodeWithColor:fgColor andMessage:@"collect blocks like you" atY:height - 150];
    [self newMessageLabelNodeWithColor:fgColor andMessage:@"avoid blocks like the background" atY:height - 200];
    [self newMessageLabelNodeWithColor:fgColor andMessage:@"(they might blend in)" atY:height - 250];
    
    [self newMessageLabelNodeWithColor:fgColor andMessage:@"flashing blocks restore health" atY:height - 350];
    [self newMessageLabelNodeWithColor:fgColor andMessage:@"don't die, get points" atY:height - 400];
  }
  return self;
}

@end
