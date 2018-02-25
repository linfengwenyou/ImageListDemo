//
//  ImageCacheManager.h
//  TableViewImages
//
//  Created by fumi on 2018/2/25.
//  Copyright © 2018年 fumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// 缓存图片信息，如果缓存好了会通知
@interface ImageCacheManager : NSObject

/**
 缓存图片信息，成功后需要进行一个回调处理

 @param imageUrl 要获取的图片链接
 @param handler 回调事件，一般为刷新指定cell indexPath
 */
+ (void)cacheImageUrl:(NSString *)imageUrl withHandle:(void (^)(void))handler;


/**
 获取缓存到的图片信息，如果成功缓存则返回，否则返回nil

 @param imageUrl 要获取的图片链接
 @return 返回一个缓存的图片对象
 */
+ (UIImage *)cacheImageWithImageUrl:(NSString *)imageUrl;
@end
/**
 使用方式：
 1. 在tableView代理计算cell高度时，调用cell方法来获取高度，此时需要记得，如果成功获取到图片则要进行刷新cell
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return [ImageCell cellHeightWithImageUrl:self.dataSource[indexPath.row] successBlock:^{
 [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
 }];
 }
 
 2. cell获取高度的方法中进行高度计算
    - cell中图片设置为占满整个cell，且填充模式为AspectFit
 + (CGFloat)cellHeightWithImageUrl:(NSString *)imageUrl successBlock:(void (^)(void))successblock
 {
 UIImage *image = [ImageCacheManager cacheImageWithImageUrl:imageUrl];  // 获取图片信息，如果获取到那么就展示出来，如果没有获取到便去通过网络获取
 if (!image) {
 [ImageCacheManager cacheImageUrl:imageUrl withHandle:^ {
 successblock();
 }];
 return 300;    // 临时返回一个占位的高度
 } else {
 return  image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width ;
 }
 }
 
 */
