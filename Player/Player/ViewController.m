//
//  ViewController.m
//  Player
//
//  Created by 孙苏 on 15/3/31.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "ViewController.h"
#import "CustomMoviePlayerViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"01" ofType:@"mp4"];
    [self playerVideoWithPath:path];
}

-(void)playerVideoWithPath:(NSString*)string{
    
    NSString *path = string;
    NSURL *url = [NSURL fileURLWithPath:path];
    CustomMoviePlayerViewController * customMP = [[CustomMoviePlayerViewController alloc]init];
    customMP.view.frame = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT/4);
    customMP.movieURL = url;
    [self.view addSubview:customMP.view];
    [customMP readyPlayer];
    [self presentViewController:customMP animated:YES completion:nil];
    
}

@end
