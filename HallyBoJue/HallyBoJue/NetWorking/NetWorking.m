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

-(void)RequestWithAction:(NSString *)action Params:(NSDictionary *)param itemModel:(id)model  result:(RequestResultBlock)block
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kRequestHeader,action];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    manager.responseSerializer = response;
    manager.requestSerializer.timeoutInterval = 20;
    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
  
    [MyProgressHUD showProgress];
    
    [manager POST:url parameters:param  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MyProgressHUD dismiss];
        
  
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            block(NO,nil);
            
//            NSLog(@"url:%@,param:%@",url,param);
            
//            NSLog(@"++++++++++Data is not Dictionary:%@",responseObject);

            return ;
            
        }
        
        int status = [[responseObject objectForKey:@"status"]intValue];
        
        id data = [responseObject objectForKey:@"data"];
        
  
        if (status == 1)
        {
        
        
            
            if ([data isKindOfClass:[NSDictionary class]]) {
                
                NSArray *items = [data objectForKey:@"items"];
            
                
                if (items)
                {
                    
                    DataModel *dataModel = [[DataModel alloc]init];
                    
                    [dataModel setValuesForKeysWithDictionary:data];
                    

                    
                     block(YES,dataModel);
                    
                    
                  }
                else
                {
                    
                    if (model) {
                        
                        [model setValuesForKeysWithDictionary:data];
                        
                        block(YES,model);
                    }
                    else
                    {
                        block(YES,data);
                        
                    }
                  
                    
                    
                  }
                
                
                
              
               }
            else
            {
                    block(YES,nil);
            }
            
    
            
            
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

-(void)RequestWithAction:(NSString*)action Params:(NSDictionary *)param Data:(NSData *)data name:(NSString *)name filename:(NSString *)fileName result:(RequestResultBlock)block
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kRequestHeader,action];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [MyProgressHUD showProgress];
    
    [manager POST:url parameters:param  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (data) {
            
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"png"];
            
        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
      
        
        
        
        int status = [[responseObject objectForKey:@"status"]intValue];
        
        id data = [responseObject objectForKey:@"data"];
        
        
        if (status == 1)
        {
            
            
            
            if ([data isKindOfClass:[NSDictionary class]]) {
                
                NSArray *items = [data objectForKey:@"items"];
                
                
                if (items)
                {
                    
                    DataModel *dataModel = [[DataModel alloc]init];
                    
                    [dataModel setValuesForKeysWithDictionary:data];
                    
                    
                    
                    block(YES,dataModel);
                    
                    
                }
                else
                {
                    
            
                    
                    block(YES,data);
                    
                    
                }
                
                
                
                
            }
            else
            {
                block(YES,data);
            }
            
            
            
            
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
