//
//  SSMenuScene.h
//  Another Scrolling Shooter
//
//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, SSMenuSceneButton) {
  SSMenuSceneButtonPlay = 0,
  SSMenuSceneHowToButton,
  SSMenuSceneButtonAbout
};

@class SSMenuScene;
@protocol SSMenuSceneDelegate <NSObject>
@required
-(void)menuScene:(SSMenuScene *)menuScene didPressButton:(SSMenuSceneButton)button;
@end

@interface SSMenuScene : SKScene

@property (nonatomic, readonly) SKLabelNode *playButton;
@property (nonatomic, readonly) SKShapeNode *playButtonBorder;
@property (nonatomic, readonly) SKLabelNode *howToButton;
@property (nonatomic, readonly) SKShapeNode *howToButtonBorder;
@property (nonatomic, readonly) SKLabelNode *aboutButton;
@property (nonatomic, readonly) SKShapeNode *aboutButtonBorder;
@property (nonatomic, readonly) SKLabelNode *versionLabel;

@property (nonatomic, readonly) NSInteger updateMod;

@property (nonatomic, assign) id<SSMenuSceneDelegate> delegate;

@end
