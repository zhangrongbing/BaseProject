//
//  BlockViewController.m
//  BaseProject
//
//  Created by Swift liu on 2018/11/5.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController (){
    int (^blockName) (int);
}

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1
    //__block没有，捕获的是实现时候的栈值，加__block，是拷贝栈的副本
    __block int val = 10;
    void (^blk)(void) = ^{ printf("val=%d\n",val);
    };
    val = 2;
    blk();
    
    ///////////////
    
    //2
    
    blockName = ^int (int index){
        return index;
    };
    
    
    blockName(4);
    
    //////////////
    
    //3
    
#pragma mark -- block类型
    
    
    
    
}

- (void)test{
    [BlockViewController jiafangfa];
}

+ (void)jiafangfa{
    
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
