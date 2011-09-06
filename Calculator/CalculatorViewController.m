//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Teemu Frisk on 1.9.2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Calculator functions

// Init our model if necessary
- (CalculatorBrain *)brain
{
    if (!brain) {
        brain = [[CalculatorBrain alloc] init];
    }
    return brain;
}

// IBAction handlers
- (IBAction)digitPressed:(UIButton *)sender
{
    // Read button label
    NSString *digit = [[sender titleLabel] text];
    
    // Allow '.' only once
    if ([digit isEqual:@"."]) {
        if (userIsTypingFloat) {
            return;
        }
        userIsTypingFloat = YES;
    }
    
    // Check if user is typing a longer number
    if (userIsInTheMiddleOfTypingANumber) {
        [display setText:[[display text] stringByAppendingString:digit]];
         } else {
             [display setText:digit];
             userIsInTheMiddleOfTypingANumber = YES;
         }
}

- (IBAction)operationPressed:(UIButton *)sender
{
    // Check if user is typing a longer number
    if (userIsInTheMiddleOfTypingANumber) {
        [[self brain] setOperand:[[display text] doubleValue]];
        
        // Reset number entry bools
        userIsInTheMiddleOfTypingANumber = NO;
        userIsTypingFloat = NO;
    }
    // Read button label text (sender is UIButton which was pressed)
    NSString *operation = [[sender titleLabel] text];
    // Init our model if necessary and perform operation
    double result = [[self brain] performOperation:operation];
    
    // Set UILabel text with specified format
    [display setText:[NSString stringWithFormat:@"%g", result]];
}

@end
