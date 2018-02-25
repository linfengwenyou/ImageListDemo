//
//  UIImage+rect.m
//  TableViewImages
//
//  Created by fumi on 2018/2/25.
//  Copyright © 2018年 fumi. All rights reserved.
//

#import "UIImage+rect.h"

@implementation UIImage (rect)
- (UIImage *)resizeToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
