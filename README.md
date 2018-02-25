## 使用方式

#### 将ImageCache 文件夹放到自己项目，东西太少，不做pod



#### 在tableView代理计算cell高度时，调用cell方法来获取高度，此时需要记得，如果成功获取到图片则要进行刷新cell
```
// vc.m
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ImageCell cellHeightWithImageUrl:self.dataSource[indexPath.row] successBlock:^{
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}
```


#### cell获取高度的方法中进行高度计算

> cell中图片设置为占满整个cell，且填充模式为AspectFit



```
// cell.m
- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    
    // 去缓存中查找图片信息
    UIImage *image = [ImageCacheManager cacheImageWithImageUrl:imageUrl];
    if (!image) {
        image = [UIImage imageNamed:@"placeholder"];	// 没有图片取占位符
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
```

---

### 逻辑分析

当计算cell时便开始进行网络请求，此时如果发现已有缓存的图片信息，那么便直接取出缓存图片，然后根据图片大小计算cell高度；

如果没有缓存信息，那么便需要进行网络请求获取数据，成功后便将数据进行缓存，之后便要刷新指定的cell。

需要注意的是在设置cell的时候不进行任何处理，只在cell内部进行赋值图片地址时从缓存中读取数据即可。



