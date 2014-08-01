//
//  PSListViewCell.h
//  PicsSearch
//
//  Created by tringapps, Inc. on 8/1/14.
//  Copyright (c) 2014 tringapps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *standardImageView;
@property (strong, nonatomic) IBOutlet UIImageView *lowImageView;
@property (strong, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (strong, nonatomic) IBOutlet UILabel *lblStandardResolution;
@property (strong, nonatomic) IBOutlet UILabel *lblLowResolution;
@property (strong, nonatomic) IBOutlet UILabel *lblThumbResolution;

@end
