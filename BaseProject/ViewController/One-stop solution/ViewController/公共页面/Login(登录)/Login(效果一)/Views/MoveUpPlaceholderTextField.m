//
//  MoveUpPlaceholderTextField.m
//  BaseProject
//
//  Created by 张熔冰 on 2018/9/12.
//  Copyright © 2018年 Lovcreate. All rights reserved.
//

#import "MoveUpPlaceholderTextField.h"
#import "ColorLineView.h"

#define RGB(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0    \
green:((c>>8)&0xFF)/255.0    \
blue:(c&0xFF)/255.0         \
alpha:1]

#define kLineHeight 2.f
#define kPlaceholderOriginalFont [UIFont systemFontOfSize:15.f]
#define kPlaceholderShownFont [UIFont systemFontOfSize:12.f]

@interface MoveUpPlaceholderTextField()<UITextFieldDelegate, CAAnimationDelegate>

@property(nonatomic, strong) UILabel *placeholderLabel;
@property(nonatomic, strong) ColorLineView *lineView;
@property(nonatomic, strong) CATextLayer *myTextLayer;
@property(nonatomic, assign) BOOL on;

@end

@implementation MoveUpPlaceholderTextField

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSString *str = self.myTextLayer.string;
    CGSize strSize = [str sizeWithAttributes:@{NSFontAttributeName:kPlaceholderOriginalFont}];
    
    if (self.textField) {
        self.textField.frame = CGRectMake(0, strSize.height, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - strSize.height - kLineHeight);
        
        self.placeholderLabel.frame = CGRectMake(0, CGRectGetHeight(self.textField.frame)/2.f - strSize.height/2.f, strSize.width, strSize.height);
    }
    if (self.lineView) {
        self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.textField.frame), CGRectGetWidth(self.textField.frame), kLineHeight);
    }
}

-(void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    
    CGSize strSize = [self.placeholder sizeWithAttributes:@{NSFontAttributeName:kPlaceholderOriginalFont}];
    self.myTextLayer.frame = CGRectMake(0, 0, strSize.width, strSize.height);
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.text.length == 0 && !self.on) {
        [self moveUp];
        self.on = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length == 0 && self.on) {
        [self moveDown];
        self.on = NO;
    }
}

#pragma mark - Getter and Setter
-(void)setStyle:(VerificationStyle)style{
    _style = style;
    if (style == VerificationStyleNormal) {
        
    }
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.myTextLayer.string = (NSString*)placeholder;
}

#pragma mark - Action
-(void)textChanged:(UITextField*)textField{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regex];
    BOOL isValidate = [predicate evaluateWithObject:textField.text];
    if (textField.text.length == 0) {
        [self.lineView setStatus:ColorLineNormal];
    }else if (isValidate) {
        [self.lineView setStatus:ColorLineEnable];
    }else{
        [self.lineView setStatus:ColorLineUnable];
    }
    if (self.textChangedBlock) {
        self.textChangedBlock(textField.text, isValidate);
    }
}

#pragma mark - Public
-(void)setup{
    self.on = NO;
    
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.font = kPlaceholderOriginalFont;
    self.placeholderLabel.userInteractionEnabled = NO;
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.fontSize = kPlaceholderOriginalFont.pointSize;
    textLayer.foregroundColor = RGB(0xD3D3D3).CGColor;
    [self.placeholderLabel.layer addSublayer:textLayer];
    self.myTextLayer = textLayer;
    
    _textField = [[UITextField alloc] init];
    [self.textField addSubview:self.placeholderLabel];
    self.textField.font = kPlaceholderOriginalFont;
    self.textField.textColor = self.textColor;
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.keyboardType = UIKeyboardTypeURL;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    self.textField.delegate = self;
    
    self.lineView = [[ColorLineView alloc] init];
    self.lineView.backgroundColor = [UIColor lightGrayColor];
    self.lineView.normalColor = [UIColor lightGrayColor];
    self.lineView.enableColor = [UIColor greenColor];
    self.lineView.unableColor = [UIColor redColor];
    
    [self addSubview:self.textField];
    [self addSubview:self.lineView];
}

-(void)moveUp{
    [self.placeholderLabel.layer removeAllAnimations];
    [self.placeholderLabel.layer.sublayers respondsToSelector:@selector(removeAllAnimations)];
    
    CABasicAnimation *zoomFontAni = [CABasicAnimation animationWithKeyPath:@"fontSize"];
    zoomFontAni.removedOnCompletion = NO;
    zoomFontAni.fillMode = kCAFillModeForwards;
    zoomFontAni.fromValue = @(kPlaceholderOriginalFont.pointSize);
    zoomFontAni.toValue = @(kPlaceholderShownFont.pointSize);
    zoomFontAni.duration = .3f;
    [self.myTextLayer addAnimation:zoomFontAni forKey:@"FontSize"];
    
    CGRect frame = self.placeholderLabel.frame;
    [UIView animateWithDuration:.3 animations:^{
        self.placeholderLabel.frame = CGRectMake(CGRectGetMinX(frame), -CGRectGetHeight(frame)/2 - self.myTextLayer.frame.size.height/2+2, CGRectGetWidth(frame), CGRectGetHeight(frame));
    }];
}

-(void)moveDown{
    CABasicAnimation *zoomFontAni = [CABasicAnimation animationWithKeyPath:@"fontSize"];
    zoomFontAni.removedOnCompletion = NO;
    zoomFontAni.fillMode = kCAFillModeForwards;
    zoomFontAni.fromValue = @(kPlaceholderShownFont.pointSize);
    zoomFontAni.toValue = @(kPlaceholderOriginalFont.pointSize);
    zoomFontAni.duration = .3f;
    [self.myTextLayer addAnimation:zoomFontAni forKey:@"FontSize"];
    
    NSString *str = self.myTextLayer.string;
    CGSize strSize = [str sizeWithAttributes:@{NSFontAttributeName:kPlaceholderOriginalFont}];
    [UIView animateWithDuration:.3f animations:^{
        self.placeholderLabel.frame = CGRectMake(0, CGRectGetHeight(self.textField.frame)/2.f - strSize.height/2.f, strSize.width, strSize.height);
    }];
}
@end
