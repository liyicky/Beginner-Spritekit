//
//  LIYViewController.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 7/21/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYViewController.h"

@interface LIYViewController ()
{
    CGRect screenSize;
}
@property (strong, nonatomic) SKScene *currentScene;
@property (strong, nonatomic) SKView *spriteView;
@end

@implementation LIYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.spriteView = (SKView *) self.view;
    self.spriteView.showsDrawCount = YES;
    self.spriteView.showsNodeCount = YES;
    self.spriteView.showsFPS = YES;
    screenSize = [[UIScreen mainScreen] bounds];
    self.currentScene = [[LIYMainMenuScene alloc] initWithSize:CGSizeMake((screenSize.size.width)*4, (screenSize.size.height)*4)];
    [self.spriteView presentScene:self.currentScene];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// this happens every time this view will appear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end
