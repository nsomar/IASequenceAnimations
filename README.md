IASequenceAnimations
====================

Perform a sequence of animations one after the other using blocks

IASequenceAnimations allows you to easily create a sequence of animations using blocks

First:
Create the animation object

    IASequenceAnimations *sequenceAnimations = [[IASequenceAnimations alloc] init];

Second:
Add animations to the object
[sequenceAnimations addAnimation:^(){
	//Add your animations here
	//For example you could move a view
	//Change alpha etc...
}
                        duration:1.0 
                           delay:0 
                  andAnimationID:@"Go Left"];

Third:
Call [sequenceAnimations startAnimation];

You will also have a set of delegate functions

//Called when single animation ends
- (void) sequenceAnimations:(IASequenceAnimations*)sequenceAnimations
  didFinishAnimationAtIndex:(int)index;

- (void) sequenceAnimations:(IASequenceAnimations*)sequenceAnimations
  didFinishAnimationWithID:(NSString*)animationID;

//Called when all animations end
- (void) sequenceAnimationsDidFinishAllAnimations:(IASequenceAnimations*)sequenceAnimations;

