//
//  Interest.m
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import "Interest.h"

@interface Interest()

@property (nonatomic, readwrite) NSInteger years;
@property (nonatomic, strong, readwrite) NSDecimalNumber *amount;

@end

@implementation Interest

- (instancetype)initWithYears:(NSInteger)years
                       amount:(NSDecimalNumber *)amount
{
    self = [super init];
    
    if (self)
    {
        self.years = years;
        self.amount = amount;
    }
    
    return self;
}

@end
