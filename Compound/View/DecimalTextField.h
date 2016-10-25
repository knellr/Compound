//
//  DecimalTextField.h
//  Compound
//
//  Created by Jon Kneller on 25/10/2016.
//  Copyright © 2016 Jon Kneller. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A text field that restricts the user to decimal input
 with the specified maximum and number of decimal places.
 */
@interface DecimalTextField : UITextField

/**
 Maximum number
 */
@property (nonatomic) NSInteger maximum;

/**
 Maximum number of decimal places allowed
 */
@property (nonatomic) NSInteger maximumDecimalPlaces;

@end

NS_ASSUME_NONNULL_END
