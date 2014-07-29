//
//  SSMenuScene.m
//  Another Scrolling Shooter
//
//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import "SSMenuScene.h"
#import "SSColor.h"

NSString *SSMenuSceneLabelFont = @"Helvetica";

@implementation SSMenuScene

-(id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    _updateMod = 0;
    
    CGFloat width, height;
    
    UIColor *fgColor = [SSColor randomColor];
    UIColor *bgColor = [SSColor oppositeColor:fgColor];
    
    [self setBackgroundColor:bgColor];
    
    _playButton = [SKLabelNode labelNodeWithFontNamed:SSMenuSceneLabelFont];
    [_playButton setText:@"play!"];
    [_playButton setPosition:CGPointMake(self.size.width / 2, self.size.height * (2.0f/3.0f))];
    [_playButton setFontColor:fgColor];
    [self addChild:_playButton];
    
    _howToButton = [SKLabelNode labelNodeWithFontNamed:SSMenuSceneLabelFont];
    [_howToButton setText:@"how to?"];
    [_howToButton setPosition:CGPointMake(self.size.width / 2, self.size.height * (1.0/2.0))];
    [_howToButton setFontColor:fgColor];
    [self addChild:_howToButton];

    _aboutButton = [SKLabelNode labelNodeWithFontNamed:SSMenuSceneLabelFont];
    [_aboutButton setText:@"about..."];
    [_aboutButton setPosition:CGPointMake(self.size.width / 2, self.size.height * (1.0f/3.0f))];
    [_aboutButton setFontColor:fgColor];
    [self addChild:_aboutButton];
    
    width = _howToButton.frame.size.width + 100;
    height = _howToButton.frame.size.height + 30;
    
    _playButtonBorder = [[SKShapeNode alloc] init];
    _playButtonBorder.position = _playButton.position;
    _playButtonBorder.path = CGPathCreateWithRoundedRect(CGRectMake(-(width / 2), -(height / 3), width, height),
                                                         20.0f, 20.0f, nil);
    _playButtonBorder.fillColor = [UIColor clearColor];
    [_playButtonBorder setStrokeColor:fgColor];
    [self addChild:_playButtonBorder];
    
    _howToButtonBorder = [[SKShapeNode alloc] init];
    _howToButtonBorder.position = _howToButton.position;
    _howToButtonBorder.path = CGPathCreateWithRoundedRect(CGRectMake(-(width / 2), -(height / 3), width, height),
                                                          20.0f, 20.0f, nil);
    _howToButtonBorder.fillColor = [UIColor clearColor];
    [_howToButtonBorder setStrokeColor:fgColor];
    [self addChild:_howToButtonBorder];
    
    _aboutButtonBorder = [[SKShapeNode alloc] init];
    _aboutButtonBorder.position = _aboutButton.position;
    _aboutButtonBorder.path = CGPathCreateWithRoundedRect(CGRectMake(-(width / 2), -(height / 3), width, height),
                                                        20.0f, 20.0f, nil);
    _aboutButtonBorder.fillColor = [UIColor clearColor];
    [_aboutButtonBorder setStrokeColor:fgColor];
    [self addChild:_aboutButtonBorder];
    
    
    NSInteger highscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"];
    if (highscore) {
      SKLabelNode *highScoreLabel = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
      [highScoreLabel setText:[NSString stringWithFormat:@"highscore: %d", highscore]];
      [self addChild:highScoreLabel];
      [highScoreLabel setPosition:CGPointMake(self.size.width / 2, 50)];
      [highScoreLabel setFontColor:fgColor];
    }
  }
  return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  
  SKNode *touchedNode = [self nodeAtPoint:[touch locationInNode:self]];
  
  if (touchedNode == _playButtonBorder) {
    [self.delegate menuScene:self didPressButton:SSMenuSceneButtonPlay];
  } else if (touchedNode == _aboutButtonBorder) {
    [self.delegate menuScene:self didPressButton:SSMenuSceneButtonAbout];
  } else if (touchedNode == _howToButtonBorder) {
    [self.delegate menuScene:self didPressButton:SSMenuSceneHowToButton];
  }
}

-(void)updateColors {
  UIColor *fgColor = [SSColor rotateColor:_playButton.fontColor];
  
  [_playButton setFontColor:fgColor];
  [_playButtonBorder setStrokeColor:fgColor];
  [_howToButton setFontColor:fgColor];
  [_howToButtonBorder setStrokeColor:fgColor];
  [_aboutButton setFontColor:fgColor];
  [_aboutButtonBorder setStrokeColor:fgColor];
  
  [self setBackgroundColor:[SSColor oppositeColor:fgColor]];
}

-(void)update:(NSTimeInterval)currentTime {
  if (!(_updateMod % 2)) {
    [self updateColors];
  }
  
  if (_updateMod == NSIntegerMax) {
    _updateMod = 0;
  }
  _updateMod++;
}

@end
