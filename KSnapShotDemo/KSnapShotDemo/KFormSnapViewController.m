//
//  KFormSnapViewController.m
//  KSnapShotDemo
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 mac. All rights reserved.
//

#import "KFormSnapViewController.h"
//#import "UIImage+KSnap.m"
#import <NerdyUI.h>

@interface KFormSnapViewController ()
@property(nonatomic,strong)KShowSnapPicTool *snapShotTool;

@end

@implementation KFormSnapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)configScreenShotBtn:(void (^)(void))actionCallBack{
    
    UIButton *snapBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [snapBtn setTitle:@"截屏" forState:UIControlStateNormal];
    [snapBtn setBackgroundColor:[UIColor clearColor]];
   
    snapBtn.onClick(^{
        !actionCallBack?:actionCallBack();
    });
    
    self.snapBtn = snapBtn;
}


-(void)showScreenShotWithTopImg:(UIImage *)topImg andBottomImg:(UIImage *)bottomImg{
    UIImage *image = [UIImage composeTopImg:topImg andBottomImg:bottomImg];
    [self.snapShotTool showSnapPicWithImage:image];
}


- (KShowSnapPicTool *)snapShotTool{
    if (!_snapShotTool) {
        _snapShotTool = [KShowSnapPicTool new];
    }
    return _snapShotTool;
}


@end
