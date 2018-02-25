//
//  UIImage+rect.h
//  TableViewImages
//
//  Created by fumi on 2018/2/25.
//  Copyright © 2018年 fumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (rect)

/**
 调整图片尺寸，用于图片太大导致自动布局异常时
 - 为了保护原始图片，一般只有在特定展示时才需要去进行处理
 @param size 需要调整到的尺寸
 @return 返回一个新的图片
 */
- (UIImage *)resizeToSize:(CGSize)size;
@end
