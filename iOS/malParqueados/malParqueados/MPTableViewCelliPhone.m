//
//  MPTableViewCelliPhone.m
//  malParqueados
//
//  Created by Oscar Robayo on 27/10/13.
//  Copyright (c) 2013 Oscar Robayo. All rights reserved.
//

#import "MPTableViewCelliPhone.h"

@implementation MPTableViewCelliPhone
@synthesize placeCase, imageCase;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
