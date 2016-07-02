//
//  NetWorking.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/2.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "NetWorking.h"
#import "MyProgressHUD.h"
#import "CommonMethods.h"




@implementation NetWorking

NetWorking *netWorking;

+(NetWorking*)shareNetWorking
{
    
    static dispatch_once_t once;
    
    dispatch_once(&once,^{
    
        netWorking = [[NetWorking alloc]init];
        
        
    });
    
    return netWorking;
    
}

-(void)RequestWithAction:(NSString *)action Params:(NSDictionary *)param result:(RequestResultBlock)block
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kRequestHeader,action];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [MyProgressHUD showProgress];
    
    [manager POST:url parameters:param  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MyProgressHUD dismiss];
        
  
        
        int status = [[responseObject objectForKey:@"status"]intValue];
        
        id data = [responseObject objectForKey:@"data"];
        
  
        if (status == 1)
        {
        
            
            block(YES,data);
            
            
        }
        else
        {
            NSString *err_str = [responseObject objectForKey:@"msg"];
            
            
            [CommonMethods showDefaultErrorString:err_str];
            
            
            block(NO,data);
        }
        
        
        
        NSLog(@"url:%@,param:%@",url,param);
        
        NSLog(@"success:%@",responseObject);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MyProgressHUD dismiss];
        
        block(NO,nil);
        
        NSLog(@"url:%@,param:%@",url,param);
        NSLog(@"fail:%@,%@",error,operation.responseString);
    }];
    

    
    
}
@end
