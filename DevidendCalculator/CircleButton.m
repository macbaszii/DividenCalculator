//
//  CircleButton.m
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import "CircleButton.h"

@implementation CircleButton

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
    
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
