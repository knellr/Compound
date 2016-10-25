//
//  Scenario.h
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A compound interest scenario (deposit and rate)
 */
@interface Scenario : NSObject

/**
 The deposit amount in pounds
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *deposit;

/**
 The interest rate as a percentage
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *interestRate;
    
/**
 Create a new compound interest scenario

 @param deposit Initial deposit
 @param interestRate Interest rate as a percentage
 */
- (instancetype)initWithDeposit:(NSDecimalNumber *)deposit
                   interestRate:(NSDecimalNumber *)interestRate;

@end

NS_ASSUME_NONNULL_END
