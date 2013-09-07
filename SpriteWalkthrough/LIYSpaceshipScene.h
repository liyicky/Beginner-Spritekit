//
//  LIYSpaceshipScene.h
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 7/22/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LIYSpaceshipScene : SKScene <SKPhysicsContactDelegate, UIGestureRecognizerDelegate>
- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer;
- (IBAction)handleRotation:(UIRotationGestureRecognizer *)recognizer;
@end
