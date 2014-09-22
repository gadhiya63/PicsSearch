//
//  PSSecondViewController.m
//  PicsSearch
//
//  Created by tringapps, Inc. on 7/31/14.
//  Copyright (c) 2014 tringapps, Inc. All rights reserved.
//

#import "PSListViewController.h"
#import "UIImageView+AFNetworking.h"
#import "PSListCell.h"
#import "InstagramKit.h"
#import "InstagramMedia.h"
#import "InstagramUser.h"
#import "PSDetailViewController.h"

@interface PSListViewController (){
    NSMutableArray *mediaArray;
}

@property (nonatomic, strong) InstagramPaginationInfo *currentPaginationInfo;

@end

@implementation PSListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    mediaArray = [[NSMutableArray alloc] init];
    
    //enter default string in text field "Selfie"
    self.textField.text = @"Selfie";
    
    //load media asper search string
    [self loadMediaWithString:_textField.text];
    self.tableListView.delegate =self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Action Event

- (IBAction)searchMedia{
    
    //load media asper search string
    [self loadMediaWithString:_textField.text];
    
}
- (IBAction)reloadMedia{
    
    //remove all data and reload table view
    [mediaArray removeAllObjects];
    
    //reload table view
    [self.tableListView reloadData];
    
    //load media asper search string
    [self loadMediaWithString:_textField.text];
}

- (void)loadMediaWithString : (NSString *)search{
    
    if (![search length]) {
        //show alert "Enter any #tag in search fild"
    }
    
    //dismiss keyboard
    [_textField resignFirstResponder];
    
    self.currentPaginationInfo = nil;
    
    //remove all media objects
    [mediaArray removeAllObjects];
    
    //load media asper search string
    [self testGetMediaFromTag:search];
    
}

- (void)testGetMediaFromTag:(NSString *)tag
{
    [[InstagramEngine sharedEngine] getMediaWithTagName:tag count:100 maxId:self.currentPaginationInfo.nextMaxId withSuccess:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
        self.currentPaginationInfo = paginationInfo;
        [mediaArray addObjectsFromArray:media];
        [self.tableListView reloadData];
        
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid search or network error." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)reloadData{
    //reload collection view
    [self.tableListView reloadData];
}

#pragma mark -
#pragma mark - Table View Delegate Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [mediaArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 300.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"ListImageCell";
    
    PSListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[PSListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (mediaArray.count >= indexPath.row+1) {
        InstagramMedia *media = mediaArray[indexPath.row];
        //set thumb image & resolution
        [cell.thumbImageView setImageWithURL:media.thumbnailURL];
        //cell.lblThumbResolution.text = [NSString stringWithFormat:@"%.0f X %.0f", media.thumbnailFrameSize.width, media.thumbnailFrameSize.height];
        
        //set standard img and resolution
        [cell.standardImageView setImageWithURL:media.standardResolutionImageURL];
        //cell.lblStandardResolution.text = [NSString stringWithFormat:@"%.0f X %.0f", media.standardResolutionImageFrameSize.width, media.standardResolutionImageFrameSize.height];
        
        //set low img and resolution
        [cell.lowImageView setImageWithURL:media.lowResolutionImageURL];
        //cell.lblLowResolution.text = [NSString stringWithFormat:@"%.0f X %.0f", media.lowResolutionImageFrameSize.width, media.lowResolutionImageFrameSize.height];
        
    }
    
    return cell;

}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //do nothing
    return;
}


// This will get called too before the view appears
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
//    if ([[segue identifier] isEqualToString:@"PSDetailView"]) {
//        // Get destination view
//        PSDetailViewController *vc = [segue destinationViewController];
//        NSIndexPath *index = [self.tableListView indexPathForCell:sender];
//        vc.data = mediaArray[index.row];
//    }
//}

#pragma mark - UIScrollView Delegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    for (PSListCell *cell in [self.tableListView visibleCells]) {
        NSIndexPath *indexPath = [self.tableListView indexPathForCell:cell];
        //check if index path is last cell
        if (indexPath.row == [mediaArray count] - 1) {
            //reload data
            [self testGetMediaFromTag:_textField.text];
        }
    }
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)tField
{
    if (tField.text.length) {
        //load media asper search string
        [self loadMediaWithString:_textField.text];
    }
    return YES;
}


@end
