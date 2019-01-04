//
//  PopoverController.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/8/9.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "PopoverViewController.h"
#import "UIColor+Addition.h"

@implementation PopoverViewController

-(instancetype)init{
    if(self = [super init]){
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.delegate = self;
        self.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        self.popoverPresentationController.backgroundColor = RGB(0x282C34);
        
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

#pragma mark - Getter and Setter
-(void)setSourceView:(UIView *)sourceView{
    _sourceView = sourceView;
    self.popoverPresentationController.sourceView = self.sourceView;
    self.popoverPresentationController.sourceRect = self.sourceView.bounds;
    
}

-(void)setBarItem:(UIBarButtonItem *)barItem{
    _barItem = barItem;
    self.popoverPresentationController.barButtonItem = self.barItem;
}

#pragma mark - Public
-(void)setContentSize:(CGSize)contentSize{
    _contentSize = contentSize;
    
    self.preferredContentSize = contentSize;
}

#pragma mark - UIPopoverPresentationControllerDelegate
- (BOOL) popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
}

- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView  * __nonnull * __nonnull)view{
}
@end
