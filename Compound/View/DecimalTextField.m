//
//  DecimalTextField.m
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DecimalTextField.h"

@interface DecimalTextField() <UITextFieldDelegate>

@end

@implementation DecimalTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.delegate = self;
    }
    
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray<NSString *> *components = [newString componentsSeparatedByString:@"."];
    
    if (components.count > 2)
    {
        // Too many decimal points
        return NO;
    }
    else if (components.count > 1 && components[1].length > self.maximumDecimalPlaces)
    {
        // Too many digits after the decimal point
        return NO;
    }
    else if ([[NSDecimalNumber decimalNumberWithString:newString] compare:@(self.maximum)] == NSOrderedDescending)
    {
        // Too big
        return NO;
    }
    
    return YES;
}

@end
