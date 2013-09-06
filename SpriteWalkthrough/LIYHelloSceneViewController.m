//
//  LIYHelloSceneViewController.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/5/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYHelloSceneViewController.h"

@interface LIYHelloSceneViewController ()
{
    CGRect screenSize;
}
@property (strong, nonatomic) SKScene *scene;
@property (strong, nonatomic) SKView *spriteView;
@end

@implementation LIYHelloSceneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.spriteView = (SKView *) self.view;
    screenSize = [[UIScreen mainScreen] bounds];
    self.scene = [[LIYHelloScene alloc] initWithSize:CGSizeMake((screenSize.size.width)*4, (screenSize.size.height)*4)];
    [self.spriteView presentScene:self.scene];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
@end
