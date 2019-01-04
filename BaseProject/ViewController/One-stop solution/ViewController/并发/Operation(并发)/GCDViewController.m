//
//  GCDViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/10/9.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "GCDViewController.h"

#define klabel "www.lovcreate.com"
@interface GCDViewController ()

@property(nonatomic, weak) IBOutlet UITextView *textView;

@property(nonatomic, assign) NSInteger status;
@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.status = 0;
    //创建串行队列
//    dispatch_queue_t serialQueue = dispatch_queue_create(klabel, DISPATCH_QUEUE_SERIAL);
    //创建并行队列
//    dispatch_queue_t concurrent = dispatch_queue_create(klabel, DISPATCH_QUEUE_CONCURRENT);
    //获取主队列
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //获取全局并发队列
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Once" style:UIBarButtonItemStylePlain target:self action:@selector(pressRightItem1:)];
    
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(pressRightItem2:)];
    self.navigationItem.rightBarButtonItems = @[rightItem1, rightItem2];
}

//同步执行 + 并发队列
-(IBAction)pressSync_concurrentButton:(id)sender{
    self.textView.text = [self.textView.text stringByAppendingString:@"同步执行 + 并发队列--start\n"];
    dispatch_queue_t concurrentQueue = dispatch_queue_create(klabel, DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSString *str = [NSString stringWithFormat:@"-1- %@\n", [NSThread currentThread]];
            self.textView.text = [self.textView.text stringByAppendingString:str];
        }
    });
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSString *str = [NSString stringWithFormat:@"-2- %@\n", [NSThread currentThread]];
            self.textView.text = [self.textView.text stringByAppendingString:str];
        }
    });
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSString *str = [NSString stringWithFormat:@"-3- %@\n", [NSThread currentThread]];
            self.textView.text = [self.textView.text stringByAppendingString:str];
        }
    });
    self.textView.text = [self.textView.text stringByAppendingString:@"同步执行 + 并发队列--end\n"];
}
//异步执行 + 并发队列
-(IBAction)pressAsync_concurrentButton:(id)sender{
    self.textView.text = [self.textView.text stringByAppendingString:@"异步执行 + 并发队列--start\n"];
    dispatch_queue_t concurrentQueue = dispatch_queue_create(klabel, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSString *str = [NSString stringWithFormat:@"-1- %@\n", [NSThread currentThread]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textView.text = [self.textView.text stringByAppendingString:str];
            });
        }
    });
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSString *str = [NSString stringWithFormat:@"-2- %@\n", [NSThread currentThread]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textView.text = [self.textView.text stringByAppendingString:str];
            });
        }
    });
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSString *str = [NSString stringWithFormat:@"-3- %@\n", [NSThread currentThread]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textView.text = [self.textView.text stringByAppendingString:str];
            });
        }
    });
    self.textView.text = [self.textView.text stringByAppendingString:@"异步执行 + 并发队列--end\n"];
}
//同步执行 + 串行队列
-(IBAction)pressSync_serialButton:(id)sender{
    self.textView.text = [self.textView.text stringByAppendingString:@"同步执行 + 串行队列--start\n"];
    dispatch_queue_t concurrentQueue = dispatch_queue_create(klabel, DISPATCH_QUEUE_SERIAL);
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSString *str = [NSString stringWithFormat:@"-1- %@\n", [NSThread currentThread]];
            self.textView.text = [self.textView.text stringByAppendingString:str];
        }
    });
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSString *str = [NSString stringWithFormat:@"-2- %@\n", [NSThread currentThread]];
            self.textView.text = [self.textView.text stringByAppendingString:str];
        }
    });
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSString *str = [NSString stringWithFormat:@"-3- %@\n", [NSThread currentThread]];
            self.textView.text = [self.textView.text stringByAppendingString:str];
        }
    });
    self.textView.text = [self.textView.text stringByAppendingString:@"同步执行 + 串行队列--end\n"];
}
//异步执行 + 串行队列
-(IBAction)pressAsync_serialButton:(id)sender{
    self.textView.text = [self.textView.text stringByAppendingString:@"异步执行 + 串行队列--start\n"];
    dispatch_queue_t concurrentQueue = dispatch_queue_create(klabel, DISPATCH_QUEUE_SERIAL);
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSString *str = [NSString stringWithFormat:@"-1- %@\n", [NSThread currentThread]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textView.text = [self.textView.text stringByAppendingString:str];
            });
        }
    });
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSString *str = [NSString stringWithFormat:@"-2- %@\n", [NSThread currentThread]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textView.text = [self.textView.text stringByAppendingString:str];
            });
        }
    });
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSString *str = [NSString stringWithFormat:@"-3- %@\n", [NSThread currentThread]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textView.text = [self.textView.text stringByAppendingString:str];
            });
        }
    });
    self.textView.text = [self.textView.text stringByAppendingString:@"异步执行 + 串行队列--end\n"];
}

#pragma mark - Action
-(void)pressRightItem1:(UIBarButtonItem*)item{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.textView.text = [self.textView.text stringByAppendingString:@"我就执行一次\n"];
    });
    
    NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7"];
    dispatch_apply(arr.count, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        DebugLog(@"arr[%ld]=%@", index, arr[index]);
    });
}
-(void)pressRightItem2:(UIBarButtonItem*)item{
    self.textView.text = @"";
}
@end
