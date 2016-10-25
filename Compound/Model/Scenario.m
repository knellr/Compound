//
//  Scenario.m
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import "Scenario.h"

@interface Scenario ()

@property (nonatomic, strong, readwrite) NSDecimalNumber *deposit;
@property (nonatomic, strong, readwrite) NSDecimalNumber *interestRate;

@end

@implementation Scenario

- (instancetype)initWithDeposit:(NSDecimalNumber *)deposit
                   interestRate:(NSDecimalNumber *)interestRate
{
    self = [super init];
    
    if (self)
    {
        self.deposit = deposit;
        self.interestRate = interestRate;
    }
    
    return self;
}

@end
