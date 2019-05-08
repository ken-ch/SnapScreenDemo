//
//  UIView+KSnap.m
//  KSnapShotDemo
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 mac. All rights reserved.
//

#import "UIView+KSnap.h"

@implementation UIView (KSnap)

-(UIImage *)screenShotImage{
    CGSize size = self.bounds.size;
    UIImage *screenShotImage;
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
        
    }
    UIGraphicsEndImageContext();
    screenShotImage = screenShotImage ? screenShotImage :[UIImage new];
    
    return screenShotImage;
}

@end
