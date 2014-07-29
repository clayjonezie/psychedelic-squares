//
//  SSMyScene.m
//  Another Scrolling Shooter
//
//  Created by Clay on 7/27/14.
//  Copyright (c) 2014 Clay Jones. All rights reserved.
//

#import "SSGameScene.h"
#import "SSColor.h"

const CGFloat SSPlayerY = 140.0f;
const CGFloat SSHealthBarHeight = 40.0f;
const NSInteger SSMaxHealth = 200;
static const uint32_t rockCollisionMask = 0x1 << 0;

@implementation SSGameScene

-(id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    /* Setup your scene here */
    
    _gameDifficulty = 1;
    _gameSpeed = 10.0f;
    _gameElements = [[NSMutableArray alloc] initWithCapacity:100];
    _gamePoints = 0;
    _contentCreated = NO;
    _updateMod = 0;
    _playerHealth = SSMaxHealth;
    
    [self.physicsWorld setGravity:CGVectorMake(0, -.5)];
    self.physicsWorld.contactDelegate = self;
    _bgColorChangeMod = 1;
  }
  return self;
}

- (void)didMoveToView:(SKView *)view {
  if (!self.contentCreated) {
    [self createContent];
  }
  _gameIsActive = YES;
  [self runAction:[SKAction playSoundFileNamed:@"B.mp3" waitForCompletion:NO]];
}

- (void)createContent {
  _pointsLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
  [_pointsLabel setText:[NSString stringWithFormat:@"%d", _gamePoints]];
  [_pointsLabel setPosition:CGPointMake((_pointsLabel.frame.size.width / 2) + 30, 110)];
  [self addChild:_pointsLabel];
  
  _player = [[SKSpriteNode alloc] initWithColor:[SSColor randomColor] size:CGSizeMake(10, 10)];
  [_player setPosition:CGPointMake(self.size.width / 2, SSPlayerY)];
  _player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_player.size];
  _player.physicsBody.dynamic = NO;
  _player.physicsBody.contactTestBitMask = rockCollisionMask;
  [self addChild:_player];
  
  _healthBar = [[SKSpriteNode alloc] initWithColor:_player.color size:CGSizeMake(self.size.width, SSHealthBarHeight)];
  [self updateHealthBar];
  [self addChild:_healthBar];
  
  [self updateMakeRocks];
  
  _contentCreated = YES;
  _gameStartTime = [NSDate date];
}

- (void)updateMakeRocks {
  [self removeActionForKey:@"rocks-forever"];
  SKAction *makeRocks = [SKAction sequence: @[
                                              [SKAction performSelector:@selector(addRock) onTarget:self],
                                              [SKAction waitForDuration:1.50 * (10.0f / _gameSpeed) withRange:0.15]
                                              ]];
  [self runAction:[SKAction repeatActionForever:makeRocks] withKey:@"rocks-forever"];
}

- (void)addRock {
  CGFloat rockSize = skRand(10, _gameSpeed);
  rockSize = fminf(rockSize, 75);
  SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[SSColor randomColor] size:CGSizeMake(rockSize, rockSize)];
  rock.position = CGPointMake(skRand(0, self.size.width),
                              self.size.height + 50);
  rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
  rock.physicsBody.contactTestBitMask = rockCollisionMask;
  rock.physicsBody.usesPreciseCollisionDetection = YES;
  [self addChild:rock];
  
  if (!(_updateMod % 25)) {
    rock.name  = @"rock-disco";
    [rock runAction:[SKAction customActionWithDuration:4.0f actionBlock:^(SKNode *node, CGFloat elapsedTime) {
      NSInteger elapsedTimeInt = elapsedTime * 100;
      if (!(elapsedTimeInt % 7)) {
        [(SKSpriteNode*)node setColor:[SSColor oppositeColor:[(SKSpriteNode*)node color]]];
      }
    }]];
  } else {
    rock.name = @"rock";
  }

  [_gameElements addObject:rock];
}

- (void)movePlayerTo:(CGPoint)position {
  // 25 to 175 scale to 75 to 500
  CGFloat inMaxY = 175.0f;
  CGFloat inMinY = 75.0f;
  CGFloat outMaxY = 500.0f;
  CGFloat outMinY = 75.0f;
  CGFloat y = position.y;
  y = fminf(y, inMaxY);
  y = fmaxf(y, inMinY);
  y = (y / inMaxY) * outMaxY - outMinY;
  [_player setPosition:CGPointMake(position.x, y)];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  /* Called when a touch begins */
  UITouch *touch = [touches allObjects][0];
  if (_gameIsActive) {
    [self movePlayerTo:[touch locationInNode:self]];
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  if (!_gameIsActive) {
    SKNode *touchedNode = [self nodeAtPoint:[touch locationInNode:self]];
    if ([touchedNode.name isEqualToString:@"menu"]) {
      [self.delegate gameSceneDidEndGame:self];
    } else if ([touchedNode.name isEqualToString:@"retry"]) {
      [self.delegate gameSceneDidRetry:self];
    }
  }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches allObjects][0];
  if (_gameIsActive) {
    [self movePlayerTo:[touch locationInNode:self]];
  }
}

- (void)updateColors {
  [self setBackgroundColor:[SSColor rotateColor:self.backgroundColor]];
  [_player setColor:[SSColor oppositeColor:self.backgroundColor]];
  [_healthBar setColor:_player.color];
}

- (void)updateHealthBar {
  CGFloat width = ((CGFloat)_playerHealth / (CGFloat)SSMaxHealth) * self.size.width;
  _healthBar.size = CGSizeMake(width, SSHealthBarHeight);
  _healthBar.position = CGPointMake(width / 2, self.size.height - SSHealthBarHeight/2);
}

-(void)update:(CFTimeInterval)currentTime {
  if (!(_updateMod % _bgColorChangeMod)) {
    [self updateColors];
  }
  
  if (!(_updateMod % 100)) {
    [self updateGameSpeed];
  }

  if (_updateMod == NSIntegerMax) {
    _updateMod = 0;
  }
  _updateMod++;
}

- (void)updateGameSpeed {
  NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:_gameStartTime];
  
  // scale elapsed time from 10 to 180 to gameSpeed 10 to 150
  _gameSpeed = (elapsedTime / 250) * 120;
  _gameSpeed = fmaxf(_gameSpeed, 10);
  _gameSpeed = fminf(_gameSpeed, 120);
  
  CGFloat gravity = _gameSpeed / 9;
  [self.physicsWorld setGravity:CGVectorMake(0, -gravity)];
  
  _bgColorChangeMod = 10 - ((NSInteger) _gameSpeed / 10);
  [self updateMakeRocks];
}

- (void)changePointsBy:(NSInteger)delta {
  if (delta < 0) {
    _playerHealth += delta;
    [self updateHealthBar];
    
    if (_playerHealth < 0) {
      [self playerDidLose];
    }
    
  } else {
    _gamePoints += delta;
    [self.pointsLabel setText:[NSString stringWithFormat:@"%d", _gamePoints]];
    [_pointsLabel setPosition:CGPointMake((_pointsLabel.frame.size.width / 2) + 30, 110)];
  }
  
  CGFloat playerSize = floorf(_gamePoints / 10);
  playerSize = fmaxf(playerSize, 10);
  playerSize = fminf(playerSize, 50);
  [_player setSize:CGSizeMake(playerSize, playerSize)];
  
  _player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_player.size];
  _player.physicsBody.dynamic = NO;
  _player.physicsBody.contactTestBitMask = rockCollisionMask;
}

- (void)collidedWithRock:(SKSpriteNode *)rock {
  SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
  
  [self runAction:[SKAction playSoundFileNamed:[SSHelper randomNote] waitForCompletion:NO]];

  if ([rock.name isEqualToString: @"rock"]) {
    CGFloat colorDiff = [SSColor colorDifference:rock.color from:_player.color];
    // less diff the better
    
    colorDiff *= 100; // scale of 0 to 50
    NSInteger pointsDiff = -colorDiff + 25;
    if (colorDiff < 0) {
      colorDiff *= 3;
    }
    [self changePointsBy:pointsDiff];
    label.text = [NSString stringWithFormat:@"%@%d",(pointsDiff > 0 ? @"+" : @""),pointsDiff];
  } else if ([rock.name isEqualToString:@"rock-disco"]) {
    label.text = [NSString stringWithFormat:@"disco!"];
    _playerHealth += 50.0f;
    [self updateHealthBar];
  }

  CGFloat labelX = rock.position.x;
  labelX = fminf(labelX, self.size.width - 50);
  labelX = fmaxf(labelX, 50);
  [label setPosition:CGPointMake(labelX, rock.position.y)];
  label.alpha = 0.0f;
  label.fontColor = rock.color;
  [self addChild:label];
  SKAction *showLabel = [SKAction sequence:
                          @[[SKAction group:@[[SKAction fadeAlphaTo:1.0f duration:.3f],
                                              [SKAction moveToY:self.size.height + 50 duration:1.1f]]],
                            [SKAction removeFromParent]]];
  [label runAction:showLabel];
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
  SKSpriteNode *rock = nil;
  if ([contact.bodyA.node.name hasPrefix:@"rock"]
      && contact.bodyB.node == _player) {
    rock = (SKSpriteNode *)contact.bodyA.node;
  } else if ([contact.bodyB.node.name hasPrefix:@"rock"]
             && contact.bodyA.node == _player) {
    rock = (SKSpriteNode *)contact.bodyB.node;
  }
  
  if ([rock isKindOfClass:[SKSpriteNode class]]) {
    if (_gameIsActive) {
      [self collidedWithRock:rock];
    }
    [rock removeFromParent];
  }
}

- (void) playerDidLose {
  NSInteger score = _gamePoints;
  NSInteger highscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"];
  
  [self runAction:[SKAction playSoundFileNamed:@"FAIL.mp3" waitForCompletion:NO]];
  
  _gameIsActive = NO;
  SKNode *loseNode = [SKNode new];
  SKShapeNode *border = [SKShapeNode node];
  [border setPosition:CGPointMake(50, 150)];
  CGRect rect = CGRectMake(0, 0, self.size.width - 100, self.size.height - 300);
  [border setPath:CGPathCreateWithRoundedRect(rect, 30.0f, 30.0f, nil)];
  [border setStrokeColor:_player.color];
  [border setFillColor:_player.color];
  
  SKLabelNode *messageLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
  [border addChild:messageLabelNode];
  [messageLabelNode setText:@"you are dead"];
  [messageLabelNode setPosition:CGPointMake(messageLabelNode.parent.frame.size.width / 2, messageLabelNode.parent.frame.size.height - 50)];
  [messageLabelNode setZPosition:12];
  [messageLabelNode setFontColor:[SSColor oppositeColor:border.fillColor]];
  
  SKLabelNode *retryLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
  [border addChild:retryLabelNode];
  retryLabelNode.name = retryLabelNode.text = @"retry";
  [retryLabelNode setZPosition:13];
  [retryLabelNode setFontColor:[SSColor oppositeColor:border.fillColor]];
  [retryLabelNode setPosition:CGPointMake(retryLabelNode.parent.frame.size.width * (2.0f / 3.0f) + 20, 50)];
  
  SKLabelNode *menuLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
  [border addChild:menuLabelNode];
  menuLabelNode.name = menuLabelNode.text = @"menu";
  [menuLabelNode setPosition:CGPointMake(menuLabelNode.parent.frame.size.width * (1.0f / 3.0f) - 20, 50)];
  [menuLabelNode setZPosition:13];
  [menuLabelNode setFontColor:[SSColor oppositeColor:border.fillColor]];
  
  if (score > highscore) {
    SKLabelNode *highscoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    [border addChild:highscoreLabel];
    [highscoreLabel setZPosition:13];
    [highscoreLabel setPosition:CGPointMake(menuLabelNode.parent.frame.size.width / 2 , 150)];
    [highscoreLabel setFontColor:[SSColor oppositeColor:border.fillColor]];
    [highscoreLabel setFontSize:18.0f];
    [highscoreLabel setText:[NSString stringWithFormat:@"new highscore: %d!", score]];
    [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"highscore"];
  }
  
  [loseNode addChild:border];
  [loseNode setZPosition:100];
  [loseNode setAlpha:0.0f];
  [self addChild:loseNode];
  [loseNode runAction:[SKAction fadeAlphaTo:1.0f duration:.5]];
}

@end
