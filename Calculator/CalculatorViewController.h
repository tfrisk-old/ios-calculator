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
    // Text label IBOutlet
    IBOutlet UILabel *display;
    CalculatorBrain *brain;
}

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;

@end
