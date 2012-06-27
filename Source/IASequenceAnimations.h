//
//  IASequenceAnimations.h
//  AppleSlideView
//
//  Created by Omar Abdelhafith on 6/23/12.
//  Copyright (c) 2012 Infusion Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AnimationBlock)();
@interface IASequenceAnimationsItem : NSObject

@property (strong, nonatomic) AnimationBlock animationBlock;
@property (strong, nonatomic) NSString *animationID;
@property (nonatomic) float duration;
@property (nonatomic) float delay;

@end

@class IASequenceAnimations;

@protocol IASequenceAnimationsDelegate <NSObject>

- (void) sequenceAnimations:(IASequenceAnimations*)sequenceAnimations
  didFinishAnimationAtIndex:(int)index;

- (void) sequenceAnimations:(IASequenceAnimations*)sequenceAnimations
  didFinishAnimationWithID:(NSString*)animationID;

- (void) sequenceAnimationsDidFinishAllAnimations:(IASequenceAnimations*)sequenceAnimations;

@end

@interface IASequenceAnimations : NSObject

@property (nonatomic, weak) id<IASequenceAnimationsDelegate> delegate;

- (void) addAnimation:(AnimationBlock) animationBlock
             duration:(float)duration
                delay:(float)delay
       andAnimationID:(NSString*)animationID;

- (void) startAnimation;

@end
