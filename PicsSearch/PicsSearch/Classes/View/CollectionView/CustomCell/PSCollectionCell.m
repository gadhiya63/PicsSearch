//
//  PSThumbCell.m
//  PicsSearch
//
//  Created by tringapps, Inc. on 7/31/14.
//  Copyright (c) 2014 tringapps, Inc. All rights reserved.
//

#import "PSCollectionCell.h"

@implementation PSCollectionCell
@synthesize imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    
}

@end
