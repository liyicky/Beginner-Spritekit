//
//  LIYGeneticAlgoViewController.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYGeneticAlgoViewController.h"

@interface LIYGeneticAlgoViewController ()
{
    CGRect screenSize;
}
@property (strong, nonatomic) SKScene *scene;
@property (strong, nonatomic) SKView *spriteView;
@end

@implementation LIYGeneticAlgoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.spriteView = (SKView *) self.view;
    self.spriteView.showsDrawCount = YES;
    self.spriteView.showsNodeCount = YES;
    self.spriteView.showsFPS = YES;
    screenSize = [[UIScreen mainScreen] bounds];
    self.scene = [[LIYGeneticAlgoScene alloc] initWithSize:CGSizeMake(screenSize.size.width, screenSize.size.height)];
    [self.spriteView presentScene:self.scene];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
