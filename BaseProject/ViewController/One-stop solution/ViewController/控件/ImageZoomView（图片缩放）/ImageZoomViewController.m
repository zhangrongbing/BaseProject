//
//  ImageZoomViewController.m
//  BaseProject
//
//  Created by Swift liu on 2018/11/2.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "ImageZoomViewController.h"
#import "LCImageZoomHelp.h"

@interface ImageZoomViewController ()
@property(strong,nonatomic)UIImageView *myImageView;

@end

@implementation ImageZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 150, 100, 100)];
    self.myImageView.image = [UIImage imageNamed:@"intro_0.jpg"];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];

    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imglongTapClick:)];

    [_myImageView addGestureRecognizer:longTap];
    [_myImageView addGestureRecognizer:tapGestureRecognizer];
    [_myImageView setUserInteractionEnabled:YES];
    [self.view addSubview:_myImageView];
    
    // Do any additional setup after loading the view.
}

#pragma mark - 浏览大图点击事件
- (void)scanBigImageClick:(UITapGestureRecognizer *)tap {
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [LCImageZoomHelp _imageZoomWithImageView:clickedImageView];
}

#pragma mark 长按手势弹出警告视图确认
-(void)imglongTapClick:(UILongPressGestureRecognizer*)gesture {
    
    if(gesture.state==UIGestureRecognizerStateBegan) {
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"保存图片" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
            // 保存图片到相册
            UIImageWriteToSavedPhotosAlbum(self.myImageView.image,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
            
        }];
        
        [alertControl addAction:cancel];
        [alertControl addAction:confirm];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    }
    
}

#pragma mark 保存图片后的回调
- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(id)contextInfo {
    
    NSString *message;
    
    if(!error) {
        
        message =@"成功保存到相册";
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertControl addAction:action];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    } else{
        
        message = [error description];
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertControl addAction:action];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
