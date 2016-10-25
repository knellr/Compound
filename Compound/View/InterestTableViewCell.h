//
//  InterestTableViewCell.h
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Table view cell for displaying interest
 */
@interface InterestTableViewCell : UITableViewCell

/**
 Label displaying the number of years for which the interest
 was compounded
 */
@property (weak, nonatomic) IBOutlet UILabel *yearsLabel;

/**
 The total amount once compound interest is applied
 */
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end

NS_ASSUME_NONNULL_END
