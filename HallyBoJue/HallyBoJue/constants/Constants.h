//
//  Constants.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/1.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//



#pragma mark - 百度地图APIkey
#define kBaiduMapKey   @"0hr7vuOhcZAkhlAOH52EZuFod0ZzWELm"

#pragma mark - 信鸽推送
#define kXingePush_ACCESSID   2200208163
#define kXingePush_ACCESSKEY   @"IK74R35R4HFE"


#pragma mark - Color

#define RGB(a,b,c,d)              [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]

#define kNavigationTintColor      [UIColor whiteColor]

#define kNavigationBarColor       [UIColor colorWithRed:21/255.0 green:38/255.0 blue:110/255.0 alpha:1]

#define kDarkGrayColor             [UIColor darkGrayColor]

#define kTabbarBarTintColor        RGB(0,0,0,0.9)

#define kBackgroundColor           RGB(222,222,222,1)

#define kLineColor               RGB(220,220,220,1)

#define kOrangeTextColor           RGB(255,105,0,0.9)

#define kBlueBackColor            RGB(68,180,205,1)

#define kHightLightColor          RGB(120,120,120,1)

#define kLightBlueColor          [UIColor colorWithRed:59/255.0 green:157/255.0 blue:231/255.0 alpha:0.9]

#define kRedTextColor             RGB(190,0,0)

#define kOrangeBackColor        RGB(255,115,47,1)
#define kGrayBackColor          RGB(207,207,211,1)

#define kDarkTextColor        RGB(34,34,34,1)
#define kSecondeDarkTextColor  RGB(53,53,53,1)
#define kBorderColor          RGB(207,207,211,1)

#define kLighGrayBackColor      [UIColor colorWithWhite:0.3 alpha:0.1]



/*字体*/
#define FONT_20 [UIFont systemFontOfSize:20]
#define FONT_18 [UIFont systemFontOfSize:18]
#define FONT_17 [UIFont systemFontOfSize:17]
#define FONT_16 [UIFont systemFontOfSize:16]
#define FONT_15 [UIFont systemFontOfSize:15]
#define FONT_14 [UIFont systemFontOfSize:14]
#define FONT_13 [UIFont systemFontOfSize:13]
#define FONT_12 [UIFont systemFontOfSize:12]


//圆角大小
#define kCornerRadous      6.0

//offset
#define kViewOffset      8.0

//每页数量
#define kPageSize      15

/*宽高*/
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


//打印页面的宽度
#define kPrintpageWidth    600
#define kPrintpageHeight    800


//默认头像
#define kDefaultHeadImage   [UIImage imageNamed:@"defaultHead"]




