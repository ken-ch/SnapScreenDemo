//
//  UIImage+KSnap.m
//  KSnapShotDemo
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 mac. All rights reserved.
//

#import "UIImage+KSnap.h"
@implementation UIImage (KSnap)

// 拼接上下两张图片
+(UIImage *)composeTopImg:(UIImage *)topImg andBottomImg:(UIImage *)bottomImg
{
    
    //1.创建上下文尺寸
    CGSize size = CGSizeMake(topImg.size.width, topImg.size.height+bottomImg.size.height);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    //2.先把topImage 画到上下文中
    [topImg drawInRect:CGRectMake(0, 0, topImg.size.width, topImg.size.height)];
    //3.再把小图放在上下文中
    [bottomImg drawInRect:CGRectMake(0, topImg.size.height, bottomImg.size.width, bottomImg.size.height)];
    
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
    UIGraphicsEndImageContext();//关闭上下文
    
    return resultImg;
}


// 拼接左右两张图片
+ (UIImage *)composeLeftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage
{
    //1.创建上下文尺寸
    CGSize size = CGSizeMake(leftImage.size.width+rightImage.size.width, rightImage.size.height);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    //2.先把leftImage 画到上下文中
    [leftImage drawInRect:CGRectMake(0, 0, leftImage.size.width, leftImage.size.height)];
    //3.再把rightImage放在上下文中
    [rightImage drawInRect:CGRectMake(leftImage.size.width, 0, rightImage.size.width, leftImage.size.height)];
    
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
    UIGraphicsEndImageContext();//关闭上下文
    
    return resultImg;
}

- (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


@end
