//
//  ViewController.m
//  TableViewImages
//
//  Created by fumi on 2018/2/25.
//  Copyright © 2018年 fumi. All rights reserved.
//

#import "ViewController.h"
#import "ImageListVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)showListView:(id)sender
{
    ImageListVC *listVC = [ImageListVC instanceListVC];
    [self.navigationController pushViewController:listVC animated:YES];
}


@end
