//
//  ImageCacheManager.m
//  TableViewImages
//
//  Created by fumi on 2018/2/25.
//  Copyright © 2018年 fumi. All rights reserved.
//

#import "ImageCacheManager.h"
#import<CommonCrypto/CommonDigest.h>

@interface ImageCacheManager()
/** 并发处理 */
@property (nonatomic, strong) NSOperationQueue *queue;

/** 用来存放队列信息，防止重复创建 */
@property (nonatomic, strong) NSMutableDictionary *ops;
@end;

@implementation ImageCacheManager

// ? 为什么要使用单例模式
#pragma mark - initialize
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [super allocWithZone:zone];
}

+ (instancetype)shareCacheManager
{
    static ImageCacheManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ImageCacheManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.ops = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - public
+ (UIImage *)cacheImageWithImageUrl:(NSString *)imageUrl
{
    NSString *filePath = [[ImageCacheManager shareCacheManager] getFilePathName:imageUrl];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];   // 通过缓存获取图片，获取不到就重新下载
    return image;
}

+ (void)cacheImageUrl:(NSString *)imageUrl withHandle:(void (^)(void))handler
{
    [[ImageCacheManager shareCacheManager] cacheImageUrl:imageUrl withBlock:handler];
}

#pragma mark - private
- (void)cacheImageUrl:(NSString *)imageUrl withBlock:(void (^)(void))successBlock
{
    NSString *filePath = [self getFilePathName:imageUrl];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
    if (!image) {
        NSOperation *tmpOperation = [self.ops objectForKey:imageUrl];
        if (!tmpOperation) {
            NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//                [NSThread sleepForTimeInterval:5]; // 模拟网络延迟，看效果
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [data writeToFile:filePath atomically:YES];   // 写入缓存文件
                    @try {  // 防止对象释放导致问题
                        successBlock();
                    } @catch (NSException *e) {
                        NSLog(@"捕获到异常，需要调试下处理");
                    }
                    [self.ops removeObjectForKey:imageUrl];
                }];
            }];
            
            [self.ops setObject:operation forKey:imageUrl];
            [self.queue addOperation:operation];
        } else {
            NSLog(@"已经创建了操作，不需要再次创建了");
        }
    }
}

- (NSString *)getFilePathName:(NSString *)imageUrl
{
    // 写入沙盒
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 获取文件名
    NSString *fileName = [self md5:imageUrl]; // MD5来操作文件名，保证唯一性
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    return filePath;
}

- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

#pragma mark - setter & getter
- (NSOperationQueue *)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 3;
    }
    return _queue;
}

@end
