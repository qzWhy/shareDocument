# shareDocument
实现体统的文件分享功能
	UIActivityViewController *activityVc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [self presentViewController:activityVc animated:YES completion:nil];
    
    activityVc.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"分享成功");
        } else {
            NSLog(@"分享取消");
        }
    };
其中activityItems是设置你要分享的内容
如果你想简单的分享个文件可以直接在里面写文件的路径：

  NSData *data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"app" ofType:@"xlsx"]];
 NSURL *url = [self exportLog:data fileName:@"app.xlsx"];

NSArray *activityItems = @[url];// 这是分享文件

详情查看：
https://blog.csdn.net/qq_35144096/article/details/105857070
