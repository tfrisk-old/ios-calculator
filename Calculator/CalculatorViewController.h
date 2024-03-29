//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Teemu Frisk on 1.9.2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController
{    
    // Hook to our view
    IBOutlet UILabel *display;
    IBOutlet UILabel *statusDisplay;
    // Pointer to our model
    CalculatorBrain *brain;
    // Status flags
    BOOL userIsInTheMiddleOfTypingANumber;
    BOOL userIsTypingFloat;
    BOOL userIsTypingCalculation;
}

// Action handlers
- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;

@end
