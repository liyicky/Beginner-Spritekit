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
@property (strong, nonatomic) SKAction *trait1;
@property (strong, nonatomic) SKAction *trait2;
@property (strong, nonatomic) SKAction *trait3;
@property (nonatomic) CGPoint position;
@property (nonatomic) CGSize size;
@end

@implementation LIYChromosome
@synthesize geneFitness;
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
        
        [self createOrganism];

    }
    return self;
}

//- (NSDictionary *)gene
//{
//    CGFloat position_x = self.position.x;
//    self.gene = @{@"trait1" : self.trait1, @"trait2" : self.trait2, @"position_x" : position_x, @"position_y" : self.position.y, @"size" : self.size};
//    return self.gene;
//}

- (void)createOrganism
{
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screen.size.width;
    CGFloat screenHeigh = screen.size.height;
    
    NSInteger rand = arc4random() % 20 + 1;
    NSInteger xRand = arc4random() % 20 + 1;
    NSInteger yRand = arc4random() % 20 + 1;
    NSInteger xRandAction = (arc4random() % 2 ? 1 : -1) * (arc4random() % 600);
    NSInteger yRandAction = (arc4random() % 2 ? 1 : -1) * (arc4random() % 600);
    CGFloat hue = ( arc4random() % 256 / 256.0);
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    NSDate *startLife = [NSDate date];
    self.lifeTime = [startLife timeIntervalSinceNow];
    self.geneFitness = 0;
    self.color = color;
    self.position = CGPointMake(skRand(0, screenWidth), skRand(0, screenHeigh));
    self.size = CGSizeMake(xRand, yRand);
    self.name = @"chromosome";
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = YES;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.restitution = 1.0;
    self.physicsBody.categoryBitMask = chromosomeCategory;
    self.physicsBody.collisionBitMask = chromosomeCategory | sceneCategory;
    self.physicsBody.contactTestBitMask = chromosomeCategory | sceneCategory;
    
    self.physicsBody.velocity = CGVectorMake(xRandAction, yRandAction);

//    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(die) userInfo:nil repeats:NO];
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

- (void)die
{
    [self runAction:[SKAction sequence:@[[SKAction fadeAlphaTo:0 duration:0.2],
                                         [SKAction removeFromParent]]]];
}
- (void)mutate
{
    
}



@end