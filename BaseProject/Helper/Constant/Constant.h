//
//  Header.h
//  BaseProject
//
//  Created by Swift liu on 2018/10/25.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#ifndef Header_h
#define Header_h

///------------链接--------------
#define kLongConnection @"http://www.baidu.com"
#define kBaseUrlString_DEV @"http://v.juhe.cn/historyWeather/province"//开发
#define kBaseUrlString_TEST @""//测试
#define kBaseUrlString_DIS @""//生产
///------------end--------------

///------------通知--------------
#define kNotification_NetworkChanged = @"_Notifiation_NetworkChanged"
#define kNotification_Logout @"_Notifiation_Logout"//登出通知
///------------end--------------
///------------三方--------------
#define kJuheAppKey @"9cdcc40c6539948c64fb80d98d7bddb8"
///------------end--------------

///------------常量--------------
#define kAdjustFontWithScreentWidth 0//当前字体适配的屏幕宽度，有效区间：[320, 414]；等于0时，不自适应
///------------end--------------

///------------国际化------------
#define Localizable_Name @"Localizable"
#define Localizable_zh_Hans @"zh-Hans"
#define Localizable_en @"en"
///------------end--------------

#define kMAP_KEY @"7380bbf360560fcbc5899286c5390ba1"
#endif /* Header_h */
