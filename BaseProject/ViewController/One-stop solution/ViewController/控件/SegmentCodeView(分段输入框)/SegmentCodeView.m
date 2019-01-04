//
//  SegmentCodeView.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/9/11.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "SegmentCodeView.h"

@interface SegmentCodeView()<UITextFieldDelegate>

@property(nonatomic, strong) UIStackView *mainStackView;
@property(nonatomic, strong) UITextField *firstTextField;

@end

@implementation SegmentCodeView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

+(instancetype)viewForFrame:(CGRect)frame{
    SegmentCodeView *view = [[SegmentCodeView alloc] initWithFrame:frame];
    [view setup];
    return view;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.mainStackView.frame = self.bounds;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.text = @"";
    return YES;
}
#pragma mark - Action
-(void)textChanged:(UITextField*)textField{
    NSInteger tag = textField.tag;
    if (textField.text.length > 0) {
        [self setEditingAtIndex:++tag];
    }
    self.value = [self getValues];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - Public
-(void)setup{
    self.mainStackView = [[UIStackView alloc] initWithFrame:self.bounds];
    self.mainStackView.axis = UILayoutConstraintAxisHorizontal;
    self.mainStackView.spacing = 10.f;
    self.mainStackView.distribution = UIStackViewDistributionFillEqually;
    for (int i = 0; i < 4; i++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width/4, CGRectGetHeight(self.bounds) - 1)];
        textField.tag = i;
        if (i == 0) {
            self.firstTextField = textField;
        }
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.borderStyle = UITextBorderStyleNone;
        textField.textColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1];
        textField.font = [UIFont boldSystemFontOfSize:16.f];
        [textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds)/4, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:230.f/255.f green:230.f/255.f blue:230.f/255.f alpha:1];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:1];
        [lineView addConstraint:heightConstraint];
        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[textField, lineView]];
        stackView.axis = UILayoutConstraintAxisVertical;
        stackView.distribution = UIStackViewDistributionFill;
        [self.mainStackView addArrangedSubview:stackView];
    }
    [self addSubview:self.mainStackView];
}

-(void)setEditingAtIndex:(NSInteger)index{
    if (index >= self.mainStackView.arrangedSubviews.count) {
        [self endEditing:YES];
    }else{
        [self.mainStackView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIStackView *stackView = (UIStackView*)obj;
            if (idx == index) {
                UITextField *textField = [stackView.arrangedSubviews objectAtIndex:0];
                [textField becomeFirstResponder];
                [textField setEnabled:YES];
                textField.text = @"";
            }
        }];
    }
}

-(void)becomeFirstTextFieldResponder{
    [self.firstTextField becomeFirstResponder];
}

-(NSString *)getValues{
    __block NSString *value = @"";
    [self.mainStackView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIStackView *stackView = (UIStackView*)obj;
        UITextField *textField = (UITextField*)[stackView.arrangedSubviews firstObject];
        value = [value stringByAppendingString:textField.text];
    }];
    return value;
}
@end
