//
//  ViewController.m
//  shareBtnControl
//
//  Created by 范庆忠 on 2020/4/30.
//  Copyright © 2020 qingzhou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)btnClick:(id)sender {
    NSData *data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app" ofType:@"xlsx"]];
    NSURL *url = [self creatLocalPath:data fileName:@"app.xlsx"];
    
    NSString *text = @"我是～轻舟～，欢迎关注我！";
    UIImage *image = [UIImage imageNamed:@"dog.jpeg"];
    NSURL *urlStr = [NSURL URLWithString:@"https://mp.csdn.net/console/article"];
    
    NSArray *activityItems = @[text,image,urlStr];//分享标题、图片、网页
    
    //    NSArray *activityItems = @[url];// 这是分享文件
    
    UIActivityViewController *activityVc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [self presentViewController:activityVc animated:YES completion:nil];
    
    activityVc.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"分享成功");
        } else {
            NSLog(@"分享取消");
        }
    };
}

///创建沙盒文件 设置你要分享文件的名称
-(NSURL *)creatLocalPath:(NSData *)localData fileName:(NSString *)fileName{
    NSString *finalPath;
    //形成一个完整沙盒路径
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    finalPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:finalPath]){
        [ fileManager removeItemAtPath:finalPath error:NULL];
    }
    [fileManager createFileAtPath:finalPath contents:nil attributes:nil];
    NSFileHandle * fileHandle = [NSFileHandle fileHandleForWritingAtPath:finalPath];
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:localData];
    [fileHandle closeFile];
    return [ NSURL fileURLWithPath:finalPath];
}


@end
