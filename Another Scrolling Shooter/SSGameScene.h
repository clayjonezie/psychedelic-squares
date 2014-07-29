//
//  SSMyScene.h
//  Another Scrolling Shooter
//

//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class SSGameScene;
@protocol SSGameSceneDelegate <NSObject>
@required
-(void)gameSceneDidEndGame:(SSGameScene*)gameScene;
-(void)gameSceneDidRetry:(SSGameScene*)gameScene;
@end

@interface SSGameScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, readonly) BOOL gameIsActive;
@property (nonatomic, readonly) SKSpriteNode *player;
@property (nonatomic, readonly) SKSpriteNode *healthBar;

@property (nonatomic, readonly) CGFloat gameSpeed;
@property (nonatomic, readonly) NSInteger gameDifficulty;

@property (nonatomic, readonly) NSMutableArray *gameElements;
@property (nonatomic, readonly) NSInteger gamePoints;
@property (nonatomic, readonly) NSInteger playerHealth;
@property (nonatomic, readonly) BOOL contentCreated;

@property (nonatomic, readonly) SKLabelNode *pointsLabel;

@property (nonatomic, readonly) NSInteger updateMod;
@property (nonatomic, readonly) NSInteger bgColorChangeMod;

@property (nonatomic, readonly) NSDate *gameStartTime;

@property (nonatomic, assign) id<SSGameSceneDelegate> delegate;

@end
