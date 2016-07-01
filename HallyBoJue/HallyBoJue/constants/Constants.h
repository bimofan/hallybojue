//
//  Constants.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/1.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#pragma mark - Color

#define RGB(a,b,c,d)              [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]

#define kNavigationTintColor      [UIColor whiteColor]

#define kNavigationBarColor       [UIColor colorWithRed:8/255.0 green:43/255.0 blue:107/255.0 alpha:0.9]

#define kDarkGrayColor             [UIColor darkGrayColor]

#define kTabbarBarTintColor        RGB(0,0,0,0.9)

#define kBackgroundColor           RGB(240,240,240,1)

#define kLineColor               RGB(220,220,220,1)

#define kOrangeTextColor           RGB(255,105,0,0.9)

#define kBlueBackColor            RGB(68,180,205,1)

#define kHightLightColor          RGB(120,120,120,1)

#define kLightBlueColor           RGB(64,158,222)

#define kRedTextColor             RGB(190,0,0)


/*字体*/
#define FONT_20 [UIFont systemFontOfSize:20]
#define FONT_18 [UIFont systemFontOfSize:18]
#define FONT_17 [UIFont systemFontOfSize:17]
#define FONT_16 [UIFont systemFontOfSize:16]
#define FONT_15 [UIFont systemFontOfSize:15]
#define FONT_14 [UIFont systemFontOfSize:14]
#define FONT_13 [UIFont systemFontOfSize:13]
#define FONT_12 [UIFont systemFontOfSize:12]



/*宽高*/
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height