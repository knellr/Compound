//
//  CompounderSpec.m
//  CompoundTests
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "Scenario.h"
#import "Compounder.h"
#import "Interest.h"

SPEC_BEGIN(CompounderSpec)

describe(@"Compound", ^{
    
    __block NSDecimalNumber *interestRate;
    __block NSDecimalNumber *deposit;
    
    context(@"over one year", ^{
    
        it(@"interest on nothing should leave nothing", ^{
            interestRate = [NSDecimalNumber one];
            deposit = [NSDecimalNumber zero];
            Scenario *scenario = [[Scenario alloc] initWithDeposit:deposit interestRate:interestRate];
            Compounder *compounder = [[Compounder alloc] initWithScenario:scenario];
            
            __block BOOL complete = NO;
            __block Interest *calculation;
            
            [compounder compoundInterestForYears:1 notification:^(Interest *result) {
                calculation = result;
            } completion:^{
                complete = YES;
            }];
            
            [[expectFutureValue(theValue(complete)) shouldEventually] equal:theValue(YES)];
            [[expectFutureValue(theValue(calculation.years)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(calculation.amount) shouldEventually] equal:@0];
        });
        
        it(@"interest should be applied", ^{
            deposit = [NSDecimalNumber one];
            interestRate = [NSDecimalNumber one];
            Scenario *scenario = [[Scenario alloc] initWithDeposit:deposit interestRate:interestRate];
            Compounder *compounder = [[Compounder alloc] initWithScenario:scenario];
            
            __block BOOL complete = NO;
            __block Interest *calculation;
            
            [compounder compoundInterestForYears:1 notification:^(Interest *result) {
                calculation = result;
            } completion:^{
                complete = YES;
            }];
            
            [[expectFutureValue(theValue(complete)) shouldEventually] equal:theValue(YES)];
            [[expectFutureValue(calculation) shouldEventually] beNonNil];
            [[expectFutureValue(theValue(calculation.years)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(calculation.amount) shouldEventually] equal:@1.01];
        });
        
        it(@"interest of zero should have no effect", ^{
            deposit = [NSDecimalNumber one];
            interestRate = [NSDecimalNumber zero];
            Scenario *scenario = [[Scenario alloc] initWithDeposit:deposit interestRate:interestRate];
            Compounder *compounder = [[Compounder alloc] initWithScenario:scenario];
            
            __block BOOL complete = NO;
            __block Interest *calculation;
            
            [compounder compoundInterestForYears:1 notification:^(Interest *result) {
                calculation = result;
            } completion:^{
                complete = YES;
            }];
            
            [[expectFutureValue(theValue(complete)) shouldEventually] equal:theValue(YES)];
            [[expectFutureValue(calculation) shouldEventually] beNonNil];
            [[expectFutureValue(theValue(calculation.years)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(calculation.amount) shouldEventually] equal:@1];
        });
    });
    
    context(@"over multiple years", ^{
        
        it(@"interest should successfully compound", ^{
            deposit = [NSDecimalNumber one];
            interestRate = [NSDecimalNumber one];
            Scenario *scenario = [[Scenario alloc] initWithDeposit:deposit interestRate:interestRate];
            Compounder *compounder = [[Compounder alloc] initWithScenario:scenario];
            
            __block BOOL complete = NO;
            __block NSMutableArray<Interest *> *calculations = [[NSMutableArray alloc] init];
            
            [compounder compoundInterestForYears:2 notification:^(Interest *result) {
                [calculations addObject:result];
            } completion:^{
                complete = YES;
            }];
            
            [[expectFutureValue(theValue(complete)) shouldEventually] equal:theValue(YES)];
            [[expectFutureValue(theValue(calculations.count)) shouldEventually] equal:theValue(2)];
            
            [[expectFutureValue(theValue(calculations[0].years)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(calculations[0].amount) shouldEventually] equal:@1.01];
            
            [[expectFutureValue(theValue(calculations[1].years)) shouldEventually] equal:theValue(2)];
            [[expectFutureValue(calculations[1].amount) shouldEventually] equal:@1.0201];
        });
    });
});

SPEC_END
