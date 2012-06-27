//
//  ViewController.h
//  SequenceAnimationsDemo
//
//  Created by Omar Subhi on 6/27/12.
//  Copyright (c) 2012 Infusion Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IASequenceAnimations.h"

@interface ViewController : UIViewController <IASequenceAnimationsDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)animateLabel:(id)sender;
@end
