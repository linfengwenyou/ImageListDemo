//
//  ImageCell.m
//  TableViewImages
//
//  Created by fumi on 2018/2/25.
//  Copyright © 2018年 fumi. All rights reserved.
//

#import "ImageCell.h"
#import "ImageCacheManager.h"
#import "UIImage+rect.h"

@interface ImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *picView;

@end

@implementation ImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    
    // 去缓存中查找图片信息
    UIImage *image = [ImageCacheManager cacheImageWithImageUrl:imageUrl];
    if (!image) {
        image = [UIImage imageNamed:@"placeholder"];
    }
    self.picView.image = image;
}

+ (CGFloat)cellHeightWithImageUrl:(NSString *)imageUrl successBlock:(void (^)(void))successblock
{
    UIImage *image = [ImageCacheManager cacheImageWithImageUrl:imageUrl];
    if (!image) {
        [ImageCacheManager cacheImageUrl:imageUrl withHandle:^ {
            successblock();
        }];
        return 300;
    } else {
        return  image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width + 20 ;
    }
}

@end
