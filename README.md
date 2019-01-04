# DialogController 使用方法
导包：import "DialogController.h"

## Dialog初始化方法：
说明：Title为Dialog标题，Message为Dialog消息
DialogController *dialog = [DialogController dialogControllerWithTitle:@"Title" message:@"Message"];

## 按钮初始化方法：
说明：Action为按钮文字
DialogAction *action = [DialogAction actionWithTitle:@"Action" handler:^(DialogAction * _Nonnull action) {
//这里是点击按钮执行的逻辑
}];

## 加入按钮（Action）方法：
说明：dialog为DialogController实例化的对象，action为DialogAction实例化对象。
[dialog addAction:action];

## 加入文本数据框方法；
说明：dialog为DialogController实例化对象，textField为输入框对象，回调块是为了自定义输入框样式等操作。
[dialog addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//textField可以自定义
}];

##展示 Dialog方法
说明：self为所在的视图控制器 dialog为DialogController实例化的对象
[self presentViewController:dialog animated:YES completion:nil];

## 使用案例
DialogController *dialog = [DialogController dialogControllerWithTitle:@"Title" message:@"Message"];

DialogAction *action = [DialogAction actionWithTitle:@"Action" handler:^(DialogAction * _Nonnull action) {

}];
[dialog addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {

}];
[dialog addAction:action];
[self presentViewController:dialog animated:YES completion:^(){

}];
