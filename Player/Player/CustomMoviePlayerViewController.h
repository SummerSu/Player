//
//  CustomMoviePlayerViewController.h
//  Player
//
//  Created by 孙苏 on 15/3/31.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)

@interface CustomMoviePlayerViewController : UIViewController
{
    MPMoviePlayerController *mp;
    NSURL *movieURL;                        //视频地址
    UIActivityIndicatorView *loadingAni;    //加载动画
    UILabel *label;                            //加载提醒
}

@property (nonatomic,strong) NSURL *movieURL;

//+(CustomMoviePlayerViewController*)sharedCustomMoviePlayerVC;

//准备播放
- (void)readyPlayer;


@end
