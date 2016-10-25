//
//  InterestPresenterSpec.m
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "InterestPresenter.h"
#import "InterestPresenter_Private.h"
#import "InterestTableViewCell.h"
#import "Interest.h"

SPEC_BEGIN(InterestPresenterSpec)

describe(@"InterestPresenter", ^{
    
    __block InterestPresenter *interestPresenter;
    __block UITableView *tableView;
    __block InterestTableViewCell *cell;
    __block UILabel *yearsLabel;
    __block UILabel *amountLabel;
    
    beforeEach(^{
        tableView = [UITableView mock];
        [tableView stub:@selector(setDataSource:)];
        [tableView stub:@selector(insertRowsAtIndexPaths:withRowAnimation:)];
        
        amountLabel = [[UILabel alloc] init];
        yearsLabel = [[UILabel alloc] init];
        
        cell = [InterestTableViewCell mock];
        [cell stub:@selector(yearsLabel) andReturn:yearsLabel];
        [cell stub:@selector(amountLabel) andReturn:amountLabel];
        [tableView stub:@selector(dequeueReusableCellWithIdentifier:) andReturn:cell];
    });
    
    context(@"on initialisation", ^{
        
        it(@"should set table view", ^{
            interestPresenter = [[InterestPresenter alloc] initWithTableView:tableView];
            [[interestPresenter.tableView should] equal:tableView];
        });
        
        it(@"should have no calculations", ^{
            interestPresenter = [[InterestPresenter alloc] initWithTableView:tableView];
            [[theValue(interestPresenter.calculations.count) should] equal:theValue(0)];
        });
        
    });
    
    context(@"price formatter", ^{
        
        beforeEach(^{
            interestPresenter = [[InterestPresenter alloc] initWithTableView:tableView];
        });
        
        it(@"should be a currency price formatter", ^{
            [[theValue(interestPresenter.priceFormatter.numberStyle) should] equal:theValue(NSNumberFormatterCurrencyStyle)];
        });
        
        it(@"should use GBP", ^{
            [[interestPresenter.priceFormatter.currencyCode should] equal:@"GBP"];
        });
        
        it(@"should round down", ^{
            [[theValue(interestPresenter.priceFormatter.roundingMode) should] equal:theValue(NSNumberFormatterRoundDown)];
        });
        
    });
    
    context(@"table view data source", ^{
        
        it(@"should hae one section", ^{
            [[theValue([interestPresenter numberOfSectionsInTableView:tableView]) should] equal:theValue(1)];
        });
        
        it(@"should have one row per calculation", ^{
            Interest *calculation = [[Interest alloc] initWithYears:1 amount:[NSDecimalNumber one]];
            [interestPresenter stub:@selector(calculations) andReturn:@[calculation, calculation]];
            [[theValue([interestPresenter tableView:tableView numberOfRowsInSection:0]) should] equal:theValue(2)];
        });
        
        context(@"calculating deposit", ^{
            
            it(@"should apply interest", ^{
                
                __block BOOL completed = NO;
                [interestPresenter calculateDeposit:@"1" interestRate:@"1" completion:^{
                    completed = YES;
                }];
                
                [[expectFutureValue(theValue(completed)) shouldEventually] equal:theValue(YES)];
                [[interestPresenter.calculations[0].amount should] equal:@1.01];
            });
            
            it(@"Invalid deposit should be parsed as zero", ^{
            
                __block BOOL completed = NO;
                [interestPresenter calculateDeposit:@"nonsense" interestRate:@"1" completion:^{
                    completed = YES;
                }];
                
                [[expectFutureValue(theValue(completed)) shouldEventually] equal:theValue(YES)];
                [[interestPresenter.calculations[0].amount should] equal:@0];
            });
            
            it(@"Invalid interest should applied at zero percent", ^{
                
                __block BOOL completed = NO;
                [interestPresenter calculateDeposit:@"1" interestRate:@"nonsense" completion:^{
                    completed = YES;
                }];
                
                [[expectFutureValue(theValue(completed)) shouldEventually] equal:theValue(YES)];
                [[interestPresenter.calculations[0].amount should] equal:@1];
            });
            
        });
        
        context(@"populating a cell", ^{
            
            it(@"should set interest amount", ^{
                Interest *calculation = [[Interest alloc] initWithYears:2 amount:[NSDecimalNumber one]];
                [interestPresenter stub:@selector(calculations) andReturn:@[calculation]];
                InterestTableViewCell *cell = (InterestTableViewCell *)[interestPresenter tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                [[cell.amountLabel.text should] equal:@"£1.00"];
            });
            
            it(@"should set singular year text for 1 year ", ^{
                Interest *calculation = [[Interest alloc] initWithYears:1 amount:[NSDecimalNumber one]];
                [interestPresenter stub:@selector(calculations) andReturn:@[calculation]];
                InterestTableViewCell *cell = (InterestTableViewCell *)[interestPresenter tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                [[cell.yearsLabel.text should] equal:@"After 1 year"];
            });
            
            it(@"should set plural year text for > 1 year ", ^{
                Interest *calculation = [[Interest alloc] initWithYears:2 amount:[NSDecimalNumber one]];
                [interestPresenter stub:@selector(calculations) andReturn:@[calculation]];
                InterestTableViewCell *cell = (InterestTableViewCell *)[interestPresenter tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                [[cell.yearsLabel.text should] equal:@"After 2 years"];
            });
            
        });
    });
});

SPEC_END
