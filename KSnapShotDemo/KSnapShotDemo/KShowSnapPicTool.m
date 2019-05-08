//
//  KShowSnapPicTool.m
//  KSnapShotDemo
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 mac. All rights reserved.
//

#import "KShowSnapPicTool.h"
#import <Photos/Photos.h>

@interface KShowSnapPicTool(){
    NSInteger _scrollBgWidth;
    NSInteger _scrollBgHeight;
}
@property (nonatomic, strong) UIView *screenShowView;
@property (nonatomic, strong) UIScrollView *imageContent;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *window;
@property (nonatomic, strong) UIImage *baseImage;
@end

@implementation KShowSnapPicTool
-(instancetype)init{
    if (self = [super init]) {
        //改frame为bounds
        NSInteger screenWith = self.window.bounds.size.width;
        NSInteger screenHeight = self.window.bounds.size.height;
        
        _scrollBgWidth = screenWith * 0.7;
        _scrollBgHeight = screenHeight * 0.7;
        
        UIView *screenShowView = [[UIView alloc]initWithFrame:self.window.bounds];
        screenShowView.alpha = 0.0;
        screenShowView.userInteractionEnabled = YES;
        
        UIView *bgContent = [[UIView alloc]init];
        bgContent.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        bgContent.frame = screenShowView.bounds;
        
        UIView *contentView = [[UIView alloc]init];
        contentView.frame = CGRectMake(screenWith * 0.15, screenHeight * 0.15, _scrollBgWidth, _scrollBgHeight);
        contentView.layer.cornerRadius = 5.0f;
        contentView.layer.masksToBounds = YES;
        contentView.backgroundColor = [UIColor whiteColor];
        
        [screenShowView addSubview:bgContent];
        [screenShowView addSubview:contentView];
        
        UIButton *saveBtn = [UIButton new];
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor colorWithRed:35/255.0 green:168/255.0 blue:249/255.0 alpha:1] forState:UIControlStateNormal];
        [saveBtn setBackgroundColor:[UIColor whiteColor]];
        
        UIButton *cancelBtn = [UIButton new];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [contentView addSubview:self.imageContent];
        [contentView addSubview:saveBtn];
        [contentView addSubview:cancelBtn];
        NSInteger btnW = self.imageContent.frame.size.width / 2;
        
        cancelBtn.frame = CGRectMake(self.imageContent.frame.origin.x, self.imageContent.frame.size.height + self.imageContent.frame.origin.y, btnW, 44);
        saveBtn.frame = CGRectMake(cancelBtn.frame.size.width + cancelBtn.frame.origin.x, cancelBtn.frame.origin.y, btnW, 44);
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.imageContent.frame.size.width, self.imageContent.frame.size.height)];
        [self.imageContent addSubview:imageView];
        
        self.imageView = imageView;
        self.screenShowView = screenShowView;
        
        [cancelBtn addTarget:self action:@selector(HiddenFromScreenShot) forControlEvents:UIControlEventTouchUpInside];
        [saveBtn addTarget:self action:@selector(saveFromScreenShot) forControlEvents:UIControlEventTouchUpInside];

        
    }
    return self;
}

-(void)showSnapPicWithImage:(UIImage *)image{
    self.baseImage = image;
    CGSize imageSize = image.size;
    CGFloat newHeight = 0;
    if (imageSize.height > self.imageContent.frame.size.height) {
        newHeight = (self.imageContent.frame.size.height / self.imageContent.frame.size.width)*imageSize.width;
    }else{
        newHeight = imageSize.height;
    }
    //CGFloat newHeight = image.size.height;
    //CGFloat newHeight = ((self.imageContent.ys_height- 44) * imageSize.width)/self.imageContent.ys_width;
    self.imageView.image = [image scaleToSize:image size:CGSizeMake(self.imageContent.frame.size.width, newHeight)];
    
    //self.imageView.image = image;
    
    self.imageContent.contentSize = self.imageView.image.size;
    [self.window addSubview:self.screenShowView];
    [UIView animateWithDuration:0.3 animations:^{
        self.screenShowView.alpha = 1;
    }];
}

-(void)HiddenFromScreenShot{
    [UIView animateWithDuration:0.3 animations:^{
        self.screenShowView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.screenShowView removeFromSuperview];
        self.baseImage = nil;
        self.imageView.image = nil;
    }];
}

-(void)saveFromScreenShot{
    if (self.baseImage) {
        UIImageWriteToSavedPhotosAlbum(self.baseImage, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    }
    [self HiddenFromScreenShot];
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSString *errorStr = [NSString stringWithFormat:@"%@",error];
        NSLog(@"error = %@",errorStr);
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.screenShowView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.screenShowView removeFromSuperview];
        }];
        image = nil;
    }
}


- (UIScrollView *)imageContent{
    if (!_imageContent) {
        _imageContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _scrollBgWidth, _scrollBgHeight-44)];
        _imageContent.backgroundColor = [UIColor whiteColor];
    }
    return _imageContent;
}

- (UIView *)window{
    if (!_window) {
        _window = [[UIApplication sharedApplication].windows lastObject];
    }
    return _window;
}

@end
