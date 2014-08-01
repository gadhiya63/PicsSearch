//
//  PSFirstViewController.m
//  PicsSearch
//
//  Created by tringapps, Inc. on 7/31/14.
//  Copyright (c) 2014 tringapps, Inc. All rights reserved.
//

#import "PSCollectionViewController.h"
#import "UIImageView+AFNetworking.h"
#import "PSCollectionCell.h"
#import "InstagramKit.h"
#import "InstagramMedia.h"
#import "InstagramUser.h"
#import "PSDetailViewController.h"

@interface PSCollectionViewController (){
    
    NSMutableArray *mediaArray;
    __weak IBOutlet UITextField *textField;
}

@property (nonatomic, strong) InstagramPaginationInfo *currentPaginationInfo;

@end

@implementation PSCollectionViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        mediaArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //enter default string in text field "Selfie"
    textField.text = @"Selfie";
    
    //load media asper search string
    [self loadMediaWithString:textField.text];
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
    [self loadMediaWithString:textField.text];
    
}
- (IBAction)reloadMedia{
    
    //load media asper search string
    [self loadMediaWithString:textField.text];
}


- (void)loadMediaWithString : (NSString *)search{
    
    if (![search length]) {
        //show alert "Enter any #tag in search fild"
    }
    
    //dismiss keyboard
    [textField resignFirstResponder];
    
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
        [self reloadData];
        
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Invalid search or network error"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)reloadData{
    //reload collection view
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mediaArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PSCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThumbCellView" forIndexPath:indexPath];
    
    if (mediaArray.count >= indexPath.row+1) {
        InstagramMedia *media = mediaArray[indexPath.row];
        [cell.imageView setImageWithURL:media.thumbnailURL];
    }
    else
        [cell.imageView setImage:nil];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"PSDetailView"]) {
        // Get destination view
        PSDetailViewController *vc = [segue destinationViewController];
        NSIndexPath *index = [self.collectionView indexPathForCell:sender];
        vc.data = mediaArray[index.row];
    }
}

#pragma mark - UIScrollView Delegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    for (PSCollectionCell *cell in [self.collectionView visibleCells]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        //check if index path is last cell
        if (indexPath.row == [mediaArray count] - 1) {
            //reload data
            [self testGetMediaFromTag:textField.text];
        }
    }
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)tField
{
    if (tField.text.length) {
        //load media asper search string
        [self loadMediaWithString:textField.text];
    }
    return YES;
}

@end
