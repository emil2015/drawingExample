//
//  SetCardView.h
//  drawing
//
//  Created by David Gross on 10/29/14.
//  Copyright (c) 2014 GrossProfitEnterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) NSUInteger count;
@property (nonatomic, strong) NSString *shade;

+ (NSArray *)validSymbols;
+ (NSArray *)validShades;
+ (NSArray *)validColors;
+ (NSUInteger)maxCount;
@end
