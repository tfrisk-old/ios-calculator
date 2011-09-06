//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Teemu Frisk on 1.9.2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
{
    // Instance variables here
    double operand;
    double waitingOperand;
    NSString *waitingOperation;
    
    double memOperand;
}

// Method declarations here

- (void)setOperand:(double)anOperand;

- (double)performOperation:(NSString *)operation;

@end
