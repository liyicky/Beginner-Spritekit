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
@property (nonatomic) NSMutableArray *population;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) LIYChromosome *chromo;

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
    LIYChromosome *mom, *dad, *child;
    NSInteger index1, index2, deadIndex;
    NSInteger count = self.population.count;
    BOOL keepFirst;
    
    for (int i = 0; i < count; i += 2) {
        index1 = i;
        index2 = i +1;
        mom = [self.population objectAtIndex:index1];
        dad = [self.population objectAtIndex:index2];
        keepFirst = [mom isFitterThanChromosom:dad];
        deadIndex = keepFirst ? index2 : index1;
        child = [mom mateWithChromosome:dad];

        [self.population replaceObjectAtIndex:deadIndex withObject:child];
    }
}

@end