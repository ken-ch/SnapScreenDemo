//
//  KFormSnapViewController.h
//  KSnapShotDemo
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KShowSnapPicTool.h"


NS_ASSUME_NONNULL_BEGIN

@interface KFormSnapViewController : UIViewController

@property(nonatomic,strong)UIButton *snapBtn;
- (void)configScreenShotBtn:(void(^)(void))actionCallback;

-(void)showScreenShotWithTopImg:(UIImage *)topImg andBottomImg:(UIImage *)bottomImg;
@end

NS_ASSUME_NONNULL_END
