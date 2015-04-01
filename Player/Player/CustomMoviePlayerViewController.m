//
//  CustomMoviePlayerViewController.m
//  Player
//
//  Created by 孙苏 on 15/3/31.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "CustomMoviePlayerViewController.h"

@interface CustomMoviePlayerViewController ()

@end

@implementation CustomMoviePlayerViewController

@synthesize movieURL;
static CustomMoviePlayerViewController   *sharedCustomMPVC;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadWaitEffect];
}



//+(CustomMoviePlayerViewController*)sharedCustomMoviePlayerVC{
//    @synchronized ([CustomMoviePlayerViewController class]) {
//        if (sharedCustomMPVC == nil) {
//            [[CustomMoviePlayerViewController alloc] init];
//            return sharedCustomMPVC;
//        }
//    }
//    return sharedCustomMPVC;
//}
//
//+ (id) alloc {
//    
//    @synchronized ([CustomMoviePlayerViewController class]) {
//        sharedCustomMPVC = [super alloc];
//        return sharedCustomMPVC;
//    }
//    
//    return nil;
//}

-(void)loadWaitEffect{
    float loadingX = SCREEN_WIDTH/2-15;
    float loadingY = SCREEN_HEIGHT/8-15;
    loadingAni = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(loadingX, loadingY, 37,37)];
    loadingAni.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:loadingAni];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(loadingX-10,loadingY+30, 80, 40)];
    label.text = @"加载中...";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    
    [[self view] setBackgroundColor:[UIColor blackColor]];
    
    [loadingAni startAnimating];
    [self.view addSubview:label];
}



- (void) moviePlayerLoadStateChanged:(NSNotification*)notification
{
    [loadingAni stopAnimating];
    [label removeFromSuperview];
    
    
    if ([mp loadState] != MPMovieLoadStateUnknown)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        
        //设置横屏
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
        
        [[self view] setBounds:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
        [[self view] setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/6)];

        
        //选中当前view
        //[[self view] setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
        [[self view] setTransform:CGAffineTransformMakeRotation(0)];

        // Set frame of movieplayer
        [[mp view] setFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT/3)];
        
        // Add movie player as subview
        [[self view] addSubview:[mp view]];
        
        // Play the movie
        [mp play];
    }
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    //还原状态栏为默认状态
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    // Remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    //[self dismissModalViewControllerAnimated:NO];
}


- (void) readyPlayer
{
    mp =  [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    NSLog(@"%@",movieURL);
    //mp.shouldAutoplay = NO;

    if ([mp respondsToSelector:@selector(loadState)])
    {
        [mp setControlStyle:MPMovieControlStyleEmbedded];
        //[mp setControlStyle:MPMovieControlStyleEmbedded];
        //MPMovieControlStyleFullscreen
        //MPMovieControlStyleEmbedded
        //满屏
        [mp setFullscreen:YES];
        // 有助于减少延迟
        [mp prepareToPlay];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerLoadStateChanged:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        
    }
    else
    {
        [mp play];
       
    }
    
    // Register to receive a notification when the movie has finished playing.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
