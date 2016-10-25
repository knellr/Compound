//
//  ScenarioSpec.m
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "Scenario.h"

SPEC_BEGIN(ScenarioSpec)

describe(@"Scenario", ^{
    __block Scenario *scenario;
    
    context(@"after initialisation",^{
        beforeEach(^{
            NSDecimalNumber *deposit = [NSDecimalNumber decimalNumberWithString:@"1.23"];
            NSDecimalNumber *interestRate = [NSDecimalNumber decimalNumberWithString:@"0.12"];
            scenario = [[Scenario alloc] initWithDeposit:deposit interestRate: interestRate];
        });
        
        it(@"should set deposit amount", ^{
            [[scenario.deposit should] equal:@1.23];
        });
        
        it(@"should set interest rate", ^{
            [[scenario.interestRate should] equal:@0.12];
        });
    });
});

SPEC_END
