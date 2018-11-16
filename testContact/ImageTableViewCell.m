//
//  ImageTableViewCell.m
//  testContact
//
//  Created by East Agile on 8/28/18.
//  Copyright © 2018 IMac. All rights reserved.
//

#import "ImageTableViewCell.h"

@implementation ImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    NSLog(@"prepareForReuse %@",self);
}
@end
