//
//  SSSimpleScene.m
//  Another Scrolling Shooter
//
//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import "SSSimpleScene.h"

@implementation SSSimpleScene

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  [self.delegate simpleSceneDidEnd:self];
}

- (SKLabelNode*)newMessageLabelNodeWithColor:(UIColor*)color andMessage:(NSString *)message atY:(CGFloat)y {
  SKLabelNode *labelNode = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
  [labelNode setFontColor:color];
  [labelNode setFontSize:20.0f];
  [labelNode setText:message];
  [labelNode setPosition:CGPointMake(self.size.width / 2, y)];
  [self addChild:labelNode];
  return labelNode;
}

@end
