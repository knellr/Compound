//
//  InterestSpec.m
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "Interest.h"

SPEC_BEGIN(InterestSpec)

describe(@"Interest", ^{
    __block Interest *calculation;
    
    context(@"after initialisation",^{
        beforeEach(^{
            NSDecimalNumber *amount = [[NSDecimalNumber alloc] initWithString:@"10.0"];
            calculation = [[Interest alloc] initWithYears:1 amount:amount];
        });
        
        it(@"should set years", ^{
            [[theValue(calculation.years) should] equal:theValue(1)];
        });
        
        it(@"should set amount", ^{
            [[calculation.amount should] equal:@10];
        });
    });
});

SPEC_END
