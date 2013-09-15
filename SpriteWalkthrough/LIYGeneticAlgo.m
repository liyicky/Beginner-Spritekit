//
//  LIYGeneticAlgo.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYGeneticAlgo.h"

@interface LIYGeneticAlgo()
@property (nonatomic) SKScene *scene;
@property (nonatomic, readwrite, assign) NSInteger generations;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) LIYChromosome *chromo;

@property (nonatomic) LIYChromosome *chromosome1;
@property (nonatomic) LIYChromosome *chromosome2;
@property (nonatomic) LIYChromosome *chromosome3;
@property (nonatomic) LIYChromosome *chromosome4;
@property (nonatomic) LIYChromosome *chromosome5;
@property (nonatomic) LIYChromosome *chromosome6;
@property (nonatomic) LIYChromosome *chromosome7;
@property (nonatomic) LIYChromosome *chromosome8;
@property (nonatomic) LIYChromosome *chromosome9;
@property (nonatomic) LIYChromosome *chromosome10;

- (void)breedNextGeneration;
- (void)populate;
@end

@implementation LIYGeneticAlgo
@synthesize generations;

- (id)initWithScene:(SKScene *)scene
{
    self = [super init];
    if (self) {
        self.scene = scene;
        self.chromosome1 = [[LIYChromosome alloc] init];
        self.chromosome2 = [[LIYChromosome alloc] init];
        self.chromosome3 = [[LIYChromosome alloc] init];
        self.chromosome4 = [[LIYChromosome alloc] init];
        self.chromosome5 = [[LIYChromosome alloc] init];
        self.chromosome6 = [[LIYChromosome alloc] init];
        self.chromosome7 = [[LIYChromosome alloc] init];
        self.chromosome8 = [[LIYChromosome alloc] init];
        self.chromosome9 = [[LIYChromosome alloc] init];
        self.chromosome10 = [[LIYChromosome alloc] init];
        
        self.population = [NSMutableArray arrayWithArray:@[self.chromosome1,
                                                           self.chromosome2,
                                                           self.chromosome3,
                                                           self.chromosome4,
                                                           self.chromosome5,
                                                           self.chromosome6,
                                                           self.chromosome7,
                                                           self.chromosome8,
                                                           self.chromosome9,
                                                           self.chromosome10]];


    }
    return self;
}

- (void)execute
{
    [self populate];
    [self breedNextGeneration];
}

- (void)populate
{
    
    for (int i=0;i<self.population.count;i++) {
        self.chromo = [self.population objectAtIndex:i];
        [self.scene addChild:self.chromo];
        [self.chromo die];
        NSLog(@"%i - %@", i, self.chromo);
    }

}

- (void)run
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:6.2 target:self selector:@selector(execute) userInfo:nil repeats:YES];
    NSLog(@"CHILDREN COUNT %i", self.scene.children.count);
}

-(void)breedNextGeneration
{
    LIYChromosome *mom, *dad;
    NSInteger momIndex, dadIndex;
    
    for (int i = 0; i < self.population.count; i += 2) {
        momIndex = i;
        dadIndex = i +1;
        mom = [self.population objectAtIndex:momIndex];
        dad = [self.population objectAtIndex:dadIndex];
        [mom mateWithChromosome:dad];
    }
}

@end