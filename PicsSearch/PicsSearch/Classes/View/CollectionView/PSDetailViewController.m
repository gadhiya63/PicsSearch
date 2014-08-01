//
//  PSDetailViewController.m
//  PicsSearch
//
//  Created by tringapps, Inc. on 7/31/14.
//  Copyright (c) 2014 tringapps, Inc. All rights reserved.
//

#import "PSDetailViewController.h"
#import "UIImageView+AFNetworking.h"

#import "InstagramKit.h"
#import "InstagramMedia.h"
#import "InstagramUser.h"


@interface PSDetailViewController (){
    __strong IBOutlet UIScrollView *scrollView;
    __strong IBOutlet UIImageView *imageView;
    __weak IBOutlet UILabel *resolution;
    __weak IBOutlet UILabel *tagString;
}
@property (nonatomic, unsafe_unretained) CGFloat currentScale;

@end

@implementation PSDetailViewController
@synthesize data;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //set image view
    [imageView setImageWithURL:data.standardResolutionImageURL];
    
    //set user name in navigation bar
    self.navigationItem.title = data.user.username;
    
    //set image resolution
    resolution.text = [NSString stringWithFormat:@"%.0f X %.0f", data.standardResolutionImageFrameSize.width, data.standardResolutionImageFrameSize.height];
    
    //set image tags
    NSMutableString *tags = [[NSMutableString alloc] init];
    for (NSString *tag in data.tags) {
        [tags appendString:[NSString stringWithFormat:@"#%@ ", tag]];
    }
    tagString.text = tags;
    [tagString sizeToFit];
    
    //set scroll view property for zoom image
    //******** CATiledLayer is best prectice to implement zoom in/out functionality
    scrollView.userInteractionEnabled = true;
    imageView.userInteractionEnabled = true;
    scrollView.minimumZoomScale = 0.5;
    scrollView.maximumZoomScale = 2.0;
    
    // Tell the scrollView how big its subview is
    scrollView.contentSize = imageView.frame.size; // Important
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

#pragma mark -
#pragma mark Button Action
- (IBAction)saveImage:(id)sender{
    //save image in galary
    NSData *pngData = UIImagePNGRepresentation(imageView.image);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [NSDate date]]]; //Add the file name
    [pngData writeToFile:filePath atomically:YES]; //Write the file
    
    //show file sucessfully save alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sucess" message:@"Image sucessfully save in library." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
