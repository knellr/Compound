//
//  InterestPresenter.m
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterestPresenter.h"
#import "InterestPresenter_Private.h"

#import "Scenario.h"
#import "Compounder.h"
#import "Interest.h"
#import "InterestTableViewCell.h"

static const NSInteger kNumberOfYears = 5;

@implementation InterestPresenter

- (instancetype)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    
    if (self)
    {
        self.tableView = tableView;
        self.tableView.dataSource = self;
        self.calculations = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSNumberFormatter *)priceFormatter
{
    if (!_priceFormatter)
    {
        _priceFormatter = [[NSNumberFormatter alloc] init];
        _priceFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        _priceFormatter.currencyCode = @"GBP";
        _priceFormatter.roundingMode = NSNumberFormatterRoundDown;
    }
    
    return _priceFormatter;
}

- (void)calculateDeposit:(NSString *)depositString
            interestRate:(NSString *)interestRateString
              completion:(void (^)())completion
{
    [self.calculations removeAllObjects];
    [self.tableView reloadData];
    
    NSDecimalNumber *deposit = [[NSDecimalNumber alloc] initWithString:depositString];
    NSDecimalNumber *interestRate = [[NSDecimalNumber alloc] initWithString:interestRateString];
    
    if (deposit == [NSDecimalNumber notANumber])
    {
        deposit = [NSDecimalNumber zero];
    }
    
    if (interestRate == [NSDecimalNumber notANumber])
    {
        interestRate = [NSDecimalNumber zero];
    }
    
    Scenario *scenario = [[Scenario alloc] initWithDeposit:deposit interestRate:interestRate];
    Compounder *compounder = [[Compounder alloc] initWithScenario:scenario];
    
    [compounder compoundInterestForYears:kNumberOfYears
                            notification:^(Interest *calculation) {
        [self.calculations addObject:calculation];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.calculations.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                                
    } completion:completion];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.calculations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InterestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Interest"];
    Interest *calculation = self.calculations[indexPath.row];
    
    cell.yearsLabel.text = [NSString stringWithFormat:@"After %ld year", (long)calculation.years];
    if (calculation.years > 1)
    {
        cell.yearsLabel.text = [cell.yearsLabel.text stringByAppendingString:@"s"];
    }
    cell.amountLabel.text = [self.priceFormatter stringFromNumber:calculation.amount];
    
    return cell;
}

@end
