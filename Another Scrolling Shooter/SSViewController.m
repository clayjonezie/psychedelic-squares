//
//  SSViewController.m
//  Another Scrolling Shooter
//
//  Created by Clay on 7/27/14.
//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import "SSViewController.h"

@implementation SSViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  SKView *skView = (SKView *)self.view;
  
  SSMenuScene *menuScene = [SSMenuScene sceneWithSize:skView.bounds.size];
  menuScene.scaleMode = SKSceneScaleModeAspectFill;
  menuScene.delegate = self;
  
  [skView presentScene:menuScene];
}

- (BOOL)shouldAutorotate
{
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

-(void)gameSceneDidEndGame:(SSGameScene *)gameScene {
  SKTransition *tranny = [SKTransition crossFadeWithDuration:0.15];
  SSMenuScene *menuScene = [[SSMenuScene alloc] initWithSize:self.view.bounds.size];
  [menuScene setScaleMode:SKSceneScaleModeAspectFill];
  menuScene.delegate = self;
  [(SKView*)self.view presentScene:menuScene transition:tranny];
}

-(void)gameSceneDidRetry:(SSGameScene *)gameScene {
  SKTransition *tranny = [SKTransition crossFadeWithDuration:0.15];
  SSGameScene *newGameScene = [[SSGameScene alloc] initWithSize:self.view.bounds.size];
  [newGameScene setScaleMode:SKSceneScaleModeAspectFill];
  newGameScene.delegate = self;
  [(SKView*)self.view presentScene:newGameScene transition:tranny];
}

-(void)menuScene:(SSMenuScene *)menuScene didPressButton:(SSMenuSceneButton)button {
  SKTransition *tranny = [SKTransition crossFadeWithDuration:0.15];
  if (button == SSMenuSceneButtonAbout) {
    SSAboutScene *aboutScene = [[SSAboutScene alloc] initWithSize:self.view.bounds.size];
    [aboutScene setScaleMode:SKSceneScaleModeAspectFill];
    aboutScene.delegate = self;
    [(SKView*)self.view presentScene:aboutScene transition:tranny];
  } else if (button == SSMenuSceneButtonPlay) {
    SSGameScene *gameScene = [SSGameScene sceneWithSize:self.view.bounds.size];
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    gameScene.delegate = self;
    [(SKView*)self.view presentScene:gameScene transition:tranny];
  } else if (button == SSMenuSceneHowToButton) {
    SSHowToScene *howToScene = [[SSHowToScene alloc] initWithSize:self.view.bounds.size];
    [howToScene setScaleMode:SKSceneScaleModeAspectFill];
    howToScene.delegate = self;
    [(SKView*)self.view presentScene:howToScene transition:tranny];
  }
}

-(void)simpleSceneDidEnd:(SSSimpleScene *)simpleScene {
  SKTransition *tranny = [SKTransition crossFadeWithDuration:0.15];
  SSMenuScene *menuScene = [[SSMenuScene alloc] initWithSize:self.view.bounds.size];
  [menuScene setScaleMode:SKSceneScaleModeAspectFill];
  menuScene.delegate = self;
  [(SKView*)self.view presentScene:menuScene transition:tranny];
}

@end
