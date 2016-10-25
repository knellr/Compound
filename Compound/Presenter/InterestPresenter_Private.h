//
//  InterestPresenter_Private.h
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import "InterestPresenter.h"

@class Interest;

@interface InterestPresenter() <UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<Interest *> *calculations;
@property (nonatomic, strong) NSNumberFormatter *priceFormatter;
@end
