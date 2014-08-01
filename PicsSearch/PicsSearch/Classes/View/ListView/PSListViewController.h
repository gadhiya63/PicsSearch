//
//  PSSecondViewController.h
//  PicsSearch
//
//  Created by tringapps, Inc. on 7/31/14.
//  Copyright (c) 2014 tringapps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
}

@property (nonatomic, weak) IBOutlet UITableView *tableListView;
@property (nonatomic, weak) IBOutlet UITextField *textField;


@end
