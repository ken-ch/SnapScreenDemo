//
//  UIImage+KSnap.h
//  KSnapShotDemo
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KSnap)

// 拼接上下两张图片
+ (UIImage *)composeTopImg:(UIImage *)topImg andBottomImg:(UIImage *)bottomImg;

// 拼接左右两张图片
+ (UIImage *)composeLeftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage;


- (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
