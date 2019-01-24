//
//  ViewController.m
//  iPhoneImages
//
//  Created by Yilei Huang on 2019-01-24.
//  Copyright © 2019 Joshua Fanng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
   
    
}

-(void)makeRequest:(int)input{
    
    NSMutableArray *urls = [@[@"https://i.imgur.com/y9MIaCS.png",@"https://imgur.com/zdwdenZ.png",
                              @"https://imgur.com/bktnImE.png",@"https://imgur.com/CoQ8aNl.png",
                              @"https://imgur.com/2vQtZBb.png"] mutableCopy];
    NSURL *url = [NSURL URLWithString: urls[input]]; // 1
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.iPhoneImageView.image = image; // 4
        }];
    }]; // 4
    
    [downloadTask resume]; // 5
}
- (IBAction)myButton:(id)sender {
    int  y = arc4random_uniform(3);
    [self makeRequest:y];
    
}

@end
