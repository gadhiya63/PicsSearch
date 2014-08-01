//
//  PSDetailViewController.h
//  PicsSearch
//
//  Created by tringapps, Inc. on 7/31/14.
//  Copyright (c) 2014 tringapps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstagramMedia.h"

@class InstagramMedia;

@interface PSDetailViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic, strong) InstagramMedia *data;

- (IBAction)saveImage:(id)sender;

@end
