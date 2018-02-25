//
//  ImageCell.h
//  TableViewImages
//
//  Created by fumi on 2018/2/25.
//  Copyright © 2018年 fumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UITableViewCell
@property (nonatomic, copy) NSString *imageUrl;
+ (CGFloat)cellHeightWithImageUrl:(NSString *)imageUrl successBlock:(void (^)(void))successblock;
@end
