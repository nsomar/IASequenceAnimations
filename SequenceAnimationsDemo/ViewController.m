//
//  ViewController.m
//  SequenceAnimationsDemo
//
//  Created by Omar Abdelhafith on 6/27/12.
//  Copyright (c) 2012 Infusion Apps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize label;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)animateLabel:(id)sender 
{
    //Create the sequence Animation object
    IASequenceAnimations *sequenceAnimations = [[IASequenceAnimations alloc] init];
    sequenceAnimations.delegate = self;
    
    //Add animations to the objects using blocks
    [sequenceAnimations addAnimation:^(){
        CGRect rect = label.frame;
        rect.origin.x -= 100;
        label.frame = rect;
    }
                            duration:1.0 
                               delay:0 
                      andAnimationID:@"Go Left"];
    
    [sequenceAnimations addAnimation:^(){
        CGRect rect = label.frame;
        rect.origin.x += 200;
        label.frame = rect;
    }
                            duration:1.0 
                               delay:0 
                      andAnimationID:@"Go Right"];
    
    [sequenceAnimations addAnimation:^(){
        label.alpha = .3;
    }
                            duration:1.0 
                               delay:0 
                      andAnimationID:@"Change Alpha"];
    
    [sequenceAnimations addAnimation:^(){
        label.center = self.view.center;
        label.alpha = 1;
    }
                            duration:1.0 
                               delay:0 
                      andAnimationID:@"Go To Center and Chnage Alpha"];
    
    //Then start the animation
    [sequenceAnimations startAnimation];
}

- (void)sequenceAnimations:(IASequenceAnimations *)sequenceAnimations 
  didFinishAnimationWithID:(NSString *)animationID
{
    NSLog(@"Animation with id %@ finished", animationID);    
}

- (void)sequenceAnimations:(IASequenceAnimations *)sequenceAnimations 
 didFinishAnimationAtIndex:(int)index
{
    NSLog(@"Animation at index %d finished", index);
}

- (void)sequenceAnimationsDidFinishAllAnimations:(IASequenceAnimations *)sequenceAnimations
{
    NSLog(@"All animations finished");    
    label.text = @"Done";
}

@end
