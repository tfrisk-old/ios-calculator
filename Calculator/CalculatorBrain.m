//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Teemu Frisk on 1.9.2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain

// Clean up our mess
- (void) dealloc {
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)setOperand:(double)anOperand
{
    // Set operand
    operand = anOperand;
}

- (void) performWaitingOperation
{
    if ([@"+" isEqual:waitingOperation]) {
        operand = waitingOperand + operand;
    } else if ([@"-" isEqual:waitingOperation]) {
        operand = waitingOperand - operand;
    } else if ([@"*" isEqual:waitingOperation]) {
        operand = waitingOperand * operand;
    } else if ([@"/" isEqual:waitingOperation]) {
        if (operand) { // Prevent divided-by-zero
            operand = waitingOperand / operand;
        }
    }
}

- (double)performOperation:(NSString *)operation
{
    // Perform operations, first try to do single action operations
    
    // Send message to 'operation', ask if you are equal to "sqrt"
    // Remember to add @!
    if ([operation isEqual:@"sqrt"]) {
        operand = sqrt(operand);
    } else if ([operation isEqual:@"1/x"]) {
        if (operand) {
            operand = 1 / operand;
        }
    } else if ([operation isEqual:@"+/-"]) {
        operand = 0 - operand;
    } else if ([operation isEqual:@"sin()"]) {
        operand = sin(operand);
    } else if ([operation isEqual:@"cos()"]) {
        operand = cos(operand);
    } else if ([operation isEqual:@"store"]) {
        memOperand = operand;
    } else if ([operation isEqual:@"recall"]) {
        operand = memOperand;
    } else if ([operation isEqual:@"mem+"]) {
        memOperand = memOperand + operand;
    } else if ([operation isEqual:@"C"]) {
        memOperand = 0;
        operand = 0;
        waitingOperand = 0;
    }
    // If operation requires two numbers, we have to go extra round
    else {
        [self performWaitingOperation];
        waitingOperation = operation;
        waitingOperand = operand;
    }
    return operand;
}

@end
