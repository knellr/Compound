//
//  Compounder.h
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Scenario;
@class Interest;

NS_ASSUME_NONNULL_BEGIN

/**
 The class responsible for calculating compound interest
 */
@interface Compounder : NSObject

/**
 The compound interest scenario
 */
@property (nonatomic, strong, readonly) Scenario *scenario;

/**
 Create a new compounder

 @param scenario The compound interest scenario
 */
- (instancetype)initWithScenario:(Scenario *)scenario;

/**
 Compound interest for the specified number of years.
 The notification block will be called as soon as each result
 is calculated, on the understanding that it may (artificially)
 take a long time.

 @param years The number of years for which to compound interest
 @param notification The block called with each result
 @param completion The block called when all results are returned
 */
- (void)compoundInterestForYears:(NSInteger)years
                    notification:(void (^)(Interest *))notification
                      completion:(void (^)())completion;

@end

NS_ASSUME_NONNULL_END
