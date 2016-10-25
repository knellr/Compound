//
//  Compounder.m
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import "Compounder.h"
#import "Scenario.h"
#import "Interest.h"

@interface Compounder()

@property (nonatomic, strong, readwrite) Scenario *scenario;

@end

@implementation Compounder

- (instancetype)initWithScenario:(Scenario *)scenario
{
    self = [super init];
    
    if (self)
    {
        self.scenario = scenario;
    }
    
    return self;
}

- (void)compoundInterestForYears:(NSInteger)years
                    notification:(void (^)(Interest *))notification
                      completion:(void (^)())completion
{
    Interest *initialInterest = [[Interest alloc] initWithYears:0
                                                         amount:self.scenario.deposit];
    
    [self compoundInterestForYears:years
                   currentInterest:initialInterest
                      notification:notification
                        completion:completion];
}

- (void)compoundInterestForYears:(NSInteger)years
                 currentInterest:(Interest *)currentInterest
                    notification:(void (^)(Interest *))notification
                      completion:(void (^)())completion
{
    [self compoundInterest:currentInterest
                completion:^(Interest *newInterest) {
        
        notification(newInterest);
        
        if (newInterest.years < years)
        {
            [self compoundInterestForYears:years
                           currentInterest:newInterest
                              notification:notification
                                completion:completion];
        }
        else
        {
            completion();
        }
    }];
}

- (void)compoundInterest:(Interest *)calculation
              completion:(void (^)(Interest *))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSInteger years = calculation.years + 1;
        NSDecimalNumber *aHundred = [NSDecimalNumber decimalNumberWithString:@"100"];
        NSDecimalNumber *multiplier = [[self.scenario.interestRate decimalNumberByDividingBy:aHundred] decimalNumberByAdding:[NSDecimalNumber one]];
        
        NSDecimalNumber *amount = [multiplier decimalNumberByMultiplyingBy:calculation.amount];
        
        Interest *result = [[Interest alloc] initWithYears:years amount:amount];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            completion(result);
        });
    });
}

@end
