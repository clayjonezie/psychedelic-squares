//
//  SSViewController.h
//  Another Scrolling Shooter
//

//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "SSGameScene.h"
#import "SSMenuScene.h"
#import "SSAboutScene.h"
#import "SSHowToScene.h"
#import "SSSimpleScene.h"

@interface SSViewController : UIViewController <SSMenuSceneDelegate, SSGameSceneDelegate, SSSimpleSceneDelegate>

@end
