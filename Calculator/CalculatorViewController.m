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

// Digit button handler (0-9 and decimal dot)
- (IBAction)digitPressed:(UIButton *)sender
{
    if (!userIsTypingCalculation) {
        [statusDisplay setText:@""];
        userIsTypingCalculation = YES;
    }
        
    // Read button label
    NSString *digit = [[sender titleLabel] text];
    
    // Allow decimal dot only once
    if ([digit isEqual:@"."]) {
        if (userIsTypingFloat) {
            return;
        }
        // Flag decimal usage
        userIsTypingFloat = YES;
    }
    
    // Do not allow multiple zeroes in front of the number
    if ([digit isEqual:@"0"] && [[display text] hasPrefix:@"0"]) {
        return;
    }
    
    [statusDisplay setText:[[statusDisplay text] stringByAppendingString:digit]];
    
    // Check if user is typing a longer number
    if (userIsInTheMiddleOfTypingANumber) {
        [display setText:[[display text] stringByAppendingString:digit]];
    } else {
        
        // If user starts with decimal dot, apply 0 for neatness
        if ([digit isEqual:@"."]) {
            [display setText:@"0."];
        } else {
            // Else start with regular digit
            [display setText:digit];
        }
        userIsInTheMiddleOfTypingANumber = YES;
   }
}

// Operation button handler
- (IBAction)operationPressed:(UIButton *)sender
{
    // Read button label text (sender is UIButton which was pressed)
    NSString *operation = [[sender titleLabel] text];
    
    // Check if user is typing a longer number
    if (userIsInTheMiddleOfTypingANumber) {
        [statusDisplay setText:[[statusDisplay text] stringByAppendingString:operation]];
        [[self brain] setOperand:[[display text] doubleValue]];
        
        // Reset number entry bools
        userIsInTheMiddleOfTypingANumber = NO;
        userIsTypingFloat = NO;
    }
    // Init our model if necessary and perform operation
    double result = [[self brain] performOperation:operation];
    
    // Set UILabel text with specified format
    [display setText:[NSString stringWithFormat:@"%g", result]];
    if (userIsInTheMiddleOfTypingANumber || [operation isEqual:@"="]) {
        [statusDisplay setText:[[statusDisplay text] stringByAppendingFormat:@"%g",result]];
    }
    // clear statusDisplay after calculation
    // TODO: single operations need to clear userIsTypingCalculation
    if ([operation isEqual:@"="]) {
        userIsTypingCalculation = NO;
    } else if ([operation isEqual:@"C"]) {
        [statusDisplay setText:@""];
    }
}

@end
