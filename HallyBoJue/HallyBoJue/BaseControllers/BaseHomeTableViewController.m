//
//  BaseTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/7/31.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseHomeTableViewController.h"





@interface BaseHomeTableViewController ()
{
    UITapGestureRecognizer *_tapResign;
  
    BOOL hadShowedPullView;
    
    
}
@end

@implementation BaseHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //去掉底部黑线
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navbar_return_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
    
    
    self.view.backgroundColor = kBackgroundColor;
    
    //    self.tabBarController.tabBar.tintColor = TabbarTintColor;
    
    _tapResign = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    
    
    //    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"leftArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
    //
    ////    self.navigationItem.backBarButtonItem = leftButton;
    

    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showPullView)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    

    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarddidShow) name:UIKeyboardDidShowNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
   
    
}

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)keyboarddidShow
{
    [self.view addGestureRecognizer:_tapResign];
    
    
}
-(void)hideKeyboard
{
    [self.view endEditing:YES];
    
    [self.view removeGestureRecognizer:_tapResign];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)addHeaderRefresh
{
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    
    
    
    
}
-(void)headerRefresh
{
    
    
}

-(void)addFooterRefresh
{
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    
}
-(void)footerRefresh
{
    
}

-(void)endHeaderRefresh
{
    [self.tableView.header endRefreshing];
    
}
-(void)endFooterRefresh
{
    [self.tableView.footer endRefreshing];
    
}

-(void)removeHeaderRefresh
{
    [self.tableView removeHeader];
    
}
-(void)removeFooterRefresh
{
    [self.tableView removeFooter];
    
}







-(void)tapResgin
{
    
    hadShowedPullView = NO;
    
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
