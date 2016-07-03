//
//  BaiduMapHelper.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/4.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaiduMapHelper.h"



@implementation BaiduMapHelper


BaiduMapHelper *helper;

+(BaiduMapHelper*)shareHelper
{
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
       
        helper = [[BaiduMapHelper alloc]init];
        
       
      
        
        
        
    });
    
    return helper;
    
}


-(void)getLocationAddressWithLat:(float)lat Lon:(float)lon resutl:(MapBlock)block
{
    
    if (block) {
        
        addressBlock = block;
        
    }
    CLLocationCoordinate2D pt  = CLLocationCoordinate2DMake(lat, lon);
    
      _geosearch = [[BMKGeoCodeSearch alloc]init];
    
    _geosearch.delegate = self;
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geosearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }

    
}

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (addressBlock) {
        
        addressBlock(result.address);
        
    }
}

@end
