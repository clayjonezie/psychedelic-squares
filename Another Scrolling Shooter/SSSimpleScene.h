//
//  SSSimpleScene.h
//  Another Scrolling Shooter
//
//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class SSSimpleScene;
@protocol SSSimpleSceneDelegate <NSObject>
-(void)simpleSceneDidEnd:(SSSimpleScene*)simpleScene;
@end

@interface SSSimpleScene : SKScene

@property (nonatomic, assign) id<SSSimpleSceneDelegate>delegate;

- (SKLabelNode*)newMessageLabelNodeWithColor:(UIColor*)color andMessage:(NSString *)message atY:(CGFloat)y;

@end
