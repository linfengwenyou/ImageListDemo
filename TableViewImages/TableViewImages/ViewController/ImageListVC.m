//
//  ImageListVC.m
//  TableViewImages
//
//  Created by fumi on 2018/2/25.
//  Copyright © 2018年 fumi. All rights reserved.
//

#import "ImageListVC.h"
#import "ImageCell.h"

@interface ImageListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ImageListVC

+ (instancetype)instanceListVC
{
    return [[ImageListVC alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = @[@"http://images.gaga.me/photos/ymd/514e3c4f944a8d9defcf388fedd3ac91.jpeg?watermark/1/image/aHR0cDovL3Jlcy5nYWdhLm1lL3dhdGVybWFyay9wYWl4aW4xLnBuZz9pbWFnZVZpZXcyLzIvdy80MDAvaC80MDA=/dissolve/50/gravity/Center/ws/1?imageMogr2/interlace/1",
                    @"http://www.paixin.com/static/img/3.5ed1d4a.jpg",
                    @"http://images.gaga.me/photos/ymd/2de8674b6a4c0d877ebfe61c09d22c82.jpeg?imageView2/2/w/360/h/500",
                    @"http://img.ivsky.com/img/bizhi/t/201801/17/fade_to_silence-004.jpg",
                    @"http://img.ivsky.com/img/bizhi/t/201801/17/fade_to_silence-005.jpg",
                    @"http://img.ivsky.com/img/bizhi/t/201801/17/fade_to_silence-006.jpg",
                    @"http://img.ivsky.com/img/bizhi/t/201801/17/fade_to_silence-007.jpg",
                    @"http://images.gaga.me/photos/ymd/8ccbeefd559ef283b01a7325098d691e.jpg?imageView2/2/w/360/h/500",
                    @"http://images.gaga.me/photos/ymd/c99111cc06a197e8b63618494491e450.jpg?imageView2/2/w/360/h/500",
                    @"http://images.gaga.me/avatars/ymd/cdbb326fbba60852d2200faf487488ab.jpeg",
                    @"http://images.gaga.me/photos/ymd/f24791806174699db577f2b2180e0f78.jpeg?imageView2/2/w/360/h/500"
                    ];
    
    
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ImageCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ImageCell class])];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


#pragma mark - delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ImageCell cellHeightWithImageUrl:self.dataSource[indexPath.row] successBlock:^{
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ImageCell class])];
    cell.imageUrl = self.dataSource[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did selected index: %@",indexPath);
}

@end
