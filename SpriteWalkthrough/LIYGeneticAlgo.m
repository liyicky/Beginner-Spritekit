//
//  LIYGeneticAlgo.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYGeneticAlgo.h"
#import "LIYGeneticAlgoScene.h"

@interface LIYGeneticAlgo()
@property (nonatomic) SKScene *scene;
@property (nonatomic, readwrite, assign) NSInteger generations;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) LIYChromosome *chromo;
@property (nonatomic) NSArray *categories;

- (void)breedNextGeneration;
- (void)shufflePopulation;

@end

@implementation LIYGeneticAlgo
@synthesize generations;

- (id)initWithScene:(SKScene *)scene
{
    self = [super init];
    if (self) {
        self.scene = scene;
        self.chromosome1  = [[LIYChromosome alloc] init];
        self.chromosome2  = [[LIYChromosome alloc] init];
        self.chromosome3  = [[LIYChromosome alloc] init];
        self.chromosome4  = [[LIYChromosome alloc] init];
        self.chromosome5  = [[LIYChromosome alloc] init];
        self.chromosome6  = [[LIYChromosome alloc] init];
        self.chromosome7  = [[LIYChromosome alloc] init];
        self.chromosome8  = [[LIYChromosome alloc] init];
        self.chromosome9  = [[LIYChromosome alloc] init];
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
        
        for (int i=0;i<self.population.count;i++) {
            self.chromo = [self.population objectAtIndex:i];
            if (i == 0)
                self.chromo.physicsBody.categoryBitMask = chromosome1Category;
            if (i == 1)
                self.chromo.physicsBody.categoryBitMask = chromosome2Category;
            if (i == 2)
                self.chromo.physicsBody.categoryBitMask = chromosome3Category;
            if (i == 3)
                self.chromo.physicsBody.categoryBitMask = chromosome4Category;
            if (i == 4)
                self.chromo.physicsBody.categoryBitMask = chromosome5Category;
            if (i == 5)
                self.chromo.physicsBody.categoryBitMask = chromosome6Category;
            if (i == 6)
                self.chromo.physicsBody.categoryBitMask = chromosome7Category;
            if (i == 7)
                self.chromo.physicsBody.categoryBitMask = chromosome8Category;
            if (i == 8)
                self.chromo.physicsBody.categoryBitMask = chromosome9Category;
            if (i == 9)
                self.chromo.physicsBody.categoryBitMask = chromosome10Category;
        }


    }
    return self;
}

- (void)execute
{
    [self populate];
    [self shufflePopulation];
    [self breedNextGeneration];
}

- (void)populate
{
    
    for (int i=0;i<self.population.count;i++) {
        self.chromo = [self.population objectAtIndex:i];
        [self.scene addChild:self.chromo];
        [self.chromo die];
    }

}

- (void)run
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:6.2 target:self selector:@selector(execute) userInfo:nil repeats:YES];
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
        [mom changePosition];
        [dad changePosition];
        
        mom.geneFitness = 0;
        dad.geneFitness = 0;
    }
}

- (void)shufflePopulation
{
    LIYChromosome *last = [self.population lastObject];
    [self.population removeLastObject];
    [self.population insertObject:last atIndex:0];
}

@end