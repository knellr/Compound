//
//  Interest.h
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Interest : NSObject

/**
 The number of years for which this calculation is valid
 */
@property (nonatomic, readonly) NSInteger years;

/**
 The amount available after the specified number of years
 */
@property (nonatomic, readonly) NSDecimalNumber *amount;

/**
 Create a new interest calculation

 @param years The number of years the calculation is for
 @param amount The amount of money after the specified number of years
 */
- (instancetype)initWithYears:(NSInteger)years
                       amount:(NSDecimalNumber *)amount;

@end

NS_ASSUME_NONNULL_END
