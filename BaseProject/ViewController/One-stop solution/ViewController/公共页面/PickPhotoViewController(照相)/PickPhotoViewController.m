//
//  PickPhotoViewController.m
//  BaseProject
//
//  Created by Swift liu on 2018/11/5.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "PickPhotoViewController.h"
#import "TZImagePickerController.h"
#import "UIView+Block.h"

@interface PickPhotoViewController ()<TZImagePickerControllerDelegate>
{
    UIImageView *imageName;
}
@end

@implementation PickPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    imageName = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    imageName.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:imageName];
    
    __weak __typeof(self)weakSelf = self;
    
    [imageName addClickedBlock:^(id  _Nonnull obj) {
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:weakSelf];
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            DebugLog(@"%@", photos);
            [weakSelf setupUINSArray:photos];
        }];
        
        
        [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
        
    }];
}

- (void)setupUINSArray:(NSArray<UIImage *> *)photos {
    imageName.image = photos.firstObject;
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
