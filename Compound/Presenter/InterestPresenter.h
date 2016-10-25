//
//  InterestPresenter.h
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Presenter for interest calculations
 */
@interface InterestPresenter : NSObject

/**
 Create a new interest presenter

 @param tableView The table view to use to present 
                  interest calculations
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/**
 Respond to requests to calculate a deposit

 @param depositString String representing the deposit amount
 @param interestRateString String representing the interest rate
 @param completion Block to call on completion
 */
- (void)calculateDeposit:(NSString *)depositString
            interestRate:(NSString *)interestRateString
              completion:(void (^)())completion;

@end

NS_ASSUME_NONNULL_END
