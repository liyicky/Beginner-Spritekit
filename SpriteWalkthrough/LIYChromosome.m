//
//  LIYChromosome.m
//  SpriteWalkthrough
//
//  Created by Jason Cheladyn on 9/7/13.
//  Copyright (c) 2013 Jason Cheladyn. All rights reserved.
//

#import "LIYChromosome.h"

#define ARC4RANDOM_MAX (0x100000000)
#define MUTATION_DELTA_MAX (6)
#define MUTATION_RATE (0.20f)
#define MUTATION_THRESHOLD (ARC4RANDOM_MAX * MUTATION_RATE)
#define RANDOM() (arc4random())
#define RANDOM_MOD(_MOD) (arc4random_uniform(_MOD))

@interface LIYChromosome ()
@property (nonatomic) NSInteger *fitness;
@property (strong, nonatomic) SKAction *trait1;
@property (strong, nonatomic) SKAction *trait2;
@property (nonatomic) CGPoint position;
@property (nonatomic) CGSize size;
@property (nonatomic) double lifeTime;
@end

@implementation LIYChromosome
@synthesize fitness;
@synthesize behavior;

static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}


- (id)init
{
    self = [super init];
    if (self) {
        CGFloat rand = skRand(arc4random(), arc4random());
        self.trait1 = [SKAction moveBY:CGVectorMake(skRand(rand, rand), skRand(rand, rand)) duration:rand];
        self.trait2 = [SKAction rotateByAngle:rand duration:rand];
        
        self.color = [SKColor greenColor];
        
        NSDate *startLife = [NSDate date];
        self.lifeTime = [startLife timeIntervalSinceNow];
        
        self.position = CGPointMake(CGRectGetMidX(self.scene.frame), CGRectGetMidY(self.scene.frame));
        self.size = CGSizeMake(20, 20);
//        [self runAction:[SKAction sequence:@[self.trait1,
//                                             self.trait2]]];
    
    }
    return self;
}

//- (NSDictionary *)gene
//{
//    CGFloat position_x = self.position.x;
//    self.gene = @{@"trait1" : self.trait1, @"trait2" : self.trait2, @"position_x" : position_x, @"position_y" : self.position.y, @"size" : self.size};
//    return self.gene;
//}

- (NSInteger *)geneFitness
{
    return self.fitness;
}

- (LIYChromosome *)mateWithChromosome:(LIYChromosome *)other
{
    LIYChromosome *child = [[LIYChromosome alloc] init];
    LIYChromosome *champ;
    
    if (self.lifeTime > other.lifeTime) {
        child.trait1 = self.trait1;
        child.trait2 = self.trait2;
        child.position = self.position;
        child.size = self.size;
    } else {
        child.trait1 = other.trait1;
        child.trait2 = other.trait2;
        child.position = other.position;
        child.size = other.size;
    }
    
    if (RANDOM() < MUTATION_THRESHOLD) {
        [child mutate];
    }
    
    return child;
}

- (void)mutate
{
    
}

@end