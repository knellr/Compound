//
//  InterestViewController.m
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import "InterestViewController.h"
#import "InterestPresenter.h"
#import "DecimalTextField.h"

@interface InterestViewController ()

@property (weak, nonatomic) IBOutlet DecimalTextField *depositTextField;
@property (weak, nonatomic) IBOutlet DecimalTextField *interestTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) InterestPresenter *presenter;

@end

const CGFloat kMaximumDeposit = 1000000000;
const CGFloat kMaximumDepositDecimalPlaces = 2;
const CGFloat kMaximumInterest = 100;
const CGFloat kMaximumInterestDecimalPlaces = 2;

@implementation InterestViewController

- (InterestPresenter *)presenter
{
    if (!_presenter)
    {
        _presenter = [[InterestPresenter alloc] initWithTableView:self.tableView];
    }
    
    return _presenter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.depositTextField.maximum = kMaximumDeposit;
    self.depositTextField.maximumDecimalPlaces = kMaximumDepositDecimalPlaces;
    self.interestTextField.maximum = kMaximumInterest;
    self.interestTextField.maximumDecimalPlaces = kMaximumInterestDecimalPlaces;
}

- (IBAction)calculateButtonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    [self.view endEditing:YES];
    
    [self.presenter calculateDeposit:self.depositTextField.text
                        interestRate:self.interestTextField.text completion:^{
                            sender.enabled = YES;
                        }];
}

@end
