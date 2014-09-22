//
//  PSListViewCell.m
//  PicsSearch
//
//  Created by tringapps, Inc. on 8/1/14.
//  Copyright (c) 2014 tringapps, Inc. All rights reserved.
//

#import "PSListCell.h"

@implementation PSListCell

@synthesize standardImageView;
@synthesize lowImageView;
@synthesize thumbImageView;

//@synthesize lblStandardResolution;
//@synthesize lblLowResolution;
//@synthesize lblThumbResolution;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self.standardImageView setBackgroundColor:[UIColor whiteColor]];
    [self.standardImageView.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [self.standardImageView.layer setBorderWidth:0.7f];
    
    //self.lblStandardResolution.transform = CGAffineTransformMakeRotation((-M_PI)/2);
    
    [self.lowImageView setBackgroundColor:[UIColor whiteColor]];
    [self.lowImageView.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [self.lowImageView.layer setBorderWidth:0.7f];
    
    //self.lblLowResolution.transform = CGAffineTransformMakeRotation((-M_PI)/2);
    
    [self.thumbImageView setBackgroundColor:[UIColor whiteColor]];
    [self.thumbImageView.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [self.thumbImageView.layer setBorderWidth:0.7f];

    //self.lblThumbResolution.transform = CGAffineTransformMakeRotation((-M_PI)/2);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
