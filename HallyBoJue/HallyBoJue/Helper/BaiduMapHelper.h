//
//  BaiduMapHelper.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/4.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

typedef void (^MapBlock)(NSString *address);

@interface BaiduMapHelper : NSObject<BMKGeoCodeSearchDelegate>
{
    BMKGeoCodeSearch *_geosearch;
    
    MapBlock addressBlock;
    
    
}

+(BaiduMapHelper*)shareHelper;


-(void)getLocationAddressWithLat:(float)lat Lon:(float)lon resutl:(MapBlock)block;





@end
