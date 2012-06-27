//
//  IASequenceAnimations.m
//  AppleSlideView
//
//  Created by Omar Abdelhafith on 6/23/12.
//  Copyright (c) 2012 Infusion Apps. All rights reserved.
//

#import "IASequenceAnimations.h"

@implementation IASequenceAnimationsItem
@synthesize animationBlock = _animationBlock;
@synthesize delay = _delay;
@synthesize duration = _duration;
@synthesize animationID = _animationID;

- (id)initWithAnimationBlock:(AnimationBlock)animationBlock
                   withDelay:(float)delay
                    duration:(float)duration
              andAnimationID:(NSString*)animationID
{
    self = [super init];
    if (self) {
        self.animationBlock = animationBlock;
        self.delay = delay;
        self.duration = duration;
        self.animationID = animationID;
    }
    return self;
}

@end

@interface IASequenceAnimations()
@property(strong, nonatomic) NSMutableArray *animations;

- (void) doAnimationAtIndex:(int)index;

@end

@implementation IASequenceAnimations
@synthesize animations;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        self.animations = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addAnimation:(AnimationBlock) animationBlock
             duration:(float)duration
                delay:(float)delay
       andAnimationID:(NSString*)animationID
{
    IASequenceAnimationsItem *animationItem = [[IASequenceAnimationsItem alloc]
                                              initWithAnimationBlock:animationBlock 
                                               withDelay:delay 
                                               duration:duration
                                               andAnimationID:animationID];
    
    [self.animations addObject:animationItem];
}

- (void)animationDidStop:(NSString *)animationID 
                finished:(NSNumber *)finished 
                 context:(void *)context 
{
    int currentIndex = (int) context;
    
    if([delegate respondsToSelector:@selector(sequenceAnimations:didFinishAnimationAtIndex:)])
    {
        [delegate sequenceAnimations:self didFinishAnimationAtIndex:currentIndex];
    }
    
    if([delegate respondsToSelector:@selector(sequenceAnimations:didFinishAnimationWithID:)])
    {
        IASequenceAnimationsItem *item = [animations objectAtIndex:currentIndex];
        [delegate sequenceAnimations:self didFinishAnimationWithID:item.animationID];
    }
    
    [self doAnimationAtIndex:currentIndex + 1];
}

- (void) doAnimationAtIndex:(int)index
{
    if (index >= animations.count) {
        
        if([delegate respondsToSelector:@selector(sequenceAnimations:didFinishAnimationWithID:)])
        {
            [delegate sequenceAnimationsDidFinishAllAnimations:self];
        }
             
        return;
    }
    
    IASequenceAnimationsItem *item = [animations objectAtIndex:index];
    
    [UIView beginAnimations:nil context:(void*)index];
    [UIView setAnimationDuration:item.duration];
    [UIView setAnimationDelay:item.delay];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    item.animationBlock();
    
    [UIView commitAnimations];
}

- (void) startAnimation
{
    [self doAnimationAtIndex:0];
}

@end
