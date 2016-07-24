//
//  CarCheckViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/9.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "CarCheckViewController.h"
#import "ChoseWorkPlaceView.h"
#import "UserInfo.h"



@interface CarCheckViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ChoseWorkPlaceDelegate>
{
    __block NSInteger summitCount;
    NSMutableArray *car_check_result;
    
    
}

@property (nonatomic,strong) NSMutableArray *leftDataArray;
@property (nonatomic,strong) NSMutableArray *rightDataArray;

@property (nonatomic,assign) NSInteger leftSelectedindex;
@property (nonatomic,assign) NSInteger rightSelectedindex;

@property (nonatomic,strong) NSMutableArray *descArray;

@property (nonatomic,strong) ChoseWorkPlaceView *choseWorkPlaceView;





@end

@implementation CarCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *dismisButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismisactin)];
    
    self.navigationItem.leftBarButtonItem = dismisButton;
    
    
    _descArray = [[NSMutableArray alloc]init];
    
    
    _firstTableView.delegate = self;
    _firstTableView.dataSource = self;
    _secondTableView.delegate = self;
    _secondTableView.dataSource =self;
    
    _suggestTextView.delegate = self;
    
    _rightView.hidden = YES;
    
    
    
    [self getchecklist];
    
    
    
}

-(ChoseWorkPlaceView*)choseWorkPlaceView
{
    if (!_choseWorkPlaceView) {
        
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ChoseWorkPlaceView" owner:self options:nil];
        
        _choseWorkPlaceView = [views firstObject];
        
        _choseWorkPlaceView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        
        _choseWorkPlaceView.type = 1;
        
        [_choseWorkPlaceView show];
        
        
        _choseWorkPlaceView.delegate = self;
        
        
    }
    
    return _choseWorkPlaceView;
    
    
    
}


-(void)getchecklist
{
    [[NetWorking shareNetWorking] RequestWithAction:kChecklist Params:nil itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            DataModel *datamodel = (DataModel*)data;
            
            _leftDataArray = [[NSMutableArray alloc]init];
            
            [_leftDataArray addObjectsFromArray:datamodel.items];
            
            
            NSMutableArray *temleftArray = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < _leftDataArray.count; i++) {
                
                NSDictionary *dict = [_leftDataArray objectAtIndex:i];
                
                NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:dict];
                
                [mudict setObject:@(0) forKey:@"seleted"];
                
            
                
                NSArray *subchecks = [dict objectForKey:@"subchecks"];
                
                NSMutableArray *musubchecks = [[NSMutableArray alloc]init];
                
                for (int d = 0; d < subchecks.count; d++) {
                    
                    NSDictionary *subdict = [subchecks objectAtIndex:d];
                    
                    NSMutableDictionary *musubdict = [[NSMutableDictionary alloc]initWithDictionary:subdict];
                    
                    [musubdict setObject:@(0) forKey:@"selected"];
                    
                    [musubchecks addObject:musubdict];
                    
                }
                
                
                [mudict setObject:musubchecks forKey:@"subchecks"];
                
                
                [temleftArray addObject:mudict];
                
            
                
            }
            
            _leftDataArray = temleftArray;
            
        
            
            _leftSelectedindex = 0;
            
            [_firstTableView reloadData];
            
            NSDictionary *first = [_leftDataArray firstObject];
            
            
            _rightDataArray = [[NSMutableArray alloc]init];
            
            [_rightDataArray addObjectsFromArray:[first objectForKey:@"subchecks"]];
            
        
            
            [_secondTableView reloadData];
            
            
            
        }
        
    }];
}



#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    
    view.backgroundColor = [UIColor clearColor];
    
    
    return view;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _firstTableView) {
        
        return  _leftDataArray.count;
    
    }
    else if (tableView == _secondTableView)
    {
        return _rightDataArray.count;
    }
    else
    {
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    if (!cell) {
        
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    if (tableView == _firstTableView) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        if (_leftDataArray.count > indexPath.section) {
            
            NSDictionary *dict = [_leftDataArray objectAtIndex:indexPath.section];
            
            cell.textLabel.text = [dict objectForKey:@"desc"];
            
            
        }
        
        
        
        //选中背景颜色
        if (indexPath.section == _leftSelectedindex) {
            
            cell.backgroundColor = kLightBlueColor;
            
            cell.textLabel.textColor = [UIColor whiteColor];
            
        }
        else
        {
            cell.backgroundColor = [UIColor whiteColor];
            
            cell.textLabel.textColor = kDarkTextColor;
            
            
            
        }
        
        
        
        
    }
    
    else if (tableView == _secondTableView)
    {
        
        if (_rightDataArray.count > indexPath.section) {
           
            
            NSDictionary *dict = [_rightDataArray objectAtIndex:indexPath.section];
            
            cell.textLabel.text = [dict objectForKey:@"desc"];
            
            
             cell.textLabel.textColor = kDarkTextColor;
            
            BOOL selected = [[dict objectForKey:@"selected"]boolValue];
            
            if (selected) {
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
            
        }
        
    }
    else
    {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    cell.textLabel.textColor = kDarkTextColor;
    cell.textLabel.font = FONT_14;
    
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _firstTableView) {
        
        
        NSDictionary *dict = [_leftDataArray objectAtIndex:indexPath.section];
        
        _rightDataArray  = [dict objectForKey:@"subchecks"];
        
        [_secondTableView reloadData];
        
        
        
        _leftSelectedindex = indexPath.section;
        
        [_firstTableView reloadData];
        
         [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        
        
    }
    
    if (tableView == _secondTableView) {
        
        
        _rightSelectedindex = indexPath.section;
        
        
        NSDictionary *dict = [_rightDataArray objectAtIndex:indexPath.section];
        
        NSMutableDictionary *mudict = [[ NSMutableDictionary alloc]initWithDictionary:dict];
        
        BOOL selected = [[mudict objectForKey:@"selected"]boolValue];
     
        
        [mudict setObject:@(!selected) forKey:@"selected"];
        
        
        [_rightDataArray replaceObjectAtIndex:indexPath.section withObject:mudict];
        
        [_secondTableView reloadData];
        
        
        [self saveleftdata];
        
        
        [self setproblemView:mudict];
        
        
    }
    
    
   
    
}


#pragma mark - 设置右边问题界面
-(void)setproblemView:(NSDictionary *)dict
{
    

    if (![[dict objectForKey:@"selected"]boolValue]) {
        
        _rightView.hidden =YES;
        
    }
    else{
        _rightView.hidden = NO;
        
        
        NSDictionary *leftdict = [_leftDataArray objectAtIndex:_leftSelectedindex];
        
        NSString *lefttitle = [leftdict objectForKey:@"desc"];
        
        NSString *righttitle = [dict objectForKey:@"desc"];
        
        _problemNameLabel.text = [NSString stringWithFormat:@" %@-%@",lefttitle,righttitle];
        
        
        NSString *advise = [dict objectForKey:@"advise"];
        
        NSString *suggest = [dict objectForKey:@"suggest"];
        
        NSData *photo = [dict objectForKey:@"photo"];
        
        if (advise.length >0) {
            
            [_advisButton setTitle:advise forState:UIControlStateNormal];
            
            
        }
        else
        {
            [_advisButton setTitle:@"点击添加" forState:UIControlStateNormal];
            
        }
        
        if (suggest.length > 0) {
            
            _suggestLabel.hidden = YES;
            
            _suggestTextView.text = suggest;
            
        }
        else{
            
            _suggestTextView.text = nil;
            
            _suggestLabel.hidden = NO;
            
        }
        
        if (photo) {
            
            [_photoButton setBackgroundImage:[UIImage imageWithData:photo] forState:UIControlStateNormal];
            [_photoButton setTitle:nil forState:UIControlStateNormal];
        }
        else
        {
            
            [_photoButton setBackgroundImage:nil forState:UIControlStateNormal];
            
            [_photoButton setTitle:@"点击添加" forState:UIControlStateNormal];
        }
    
        
        
    }

    
    
    
    
    
}



- (IBAction)photoAction:(id)sender {
    
    
    UIActionSheet *  _pickPhotoActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    [_pickPhotoActionSheet addButtonWithTitle:@"相册图片描述"];
    
    [_pickPhotoActionSheet addButtonWithTitle:@"手机拍照描述"];
    
    [_pickPhotoActionSheet addButtonWithTitle:@"取消"];
    
    _pickPhotoActionSheet.cancelButtonIndex = 2;
    
    _pickPhotoActionSheet.tag = 99;
    
    
    
    [_pickPhotoActionSheet showInView:self.view];
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag ==99) {
        
        
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 2:
                {
                    return;
                }
                    break;
                    
                    
                case 1: //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 0: //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 1) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        picker.delegate = self;
        picker.sourceType = sourceType;
        
        
    
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
    
        [popover presentPopoverFromRect:CGRectMake(0, 0, 600, 800) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        
        
        
        

        
  

    }
    
    
}


#pragma mark - UITextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _suggestLabel.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        


        self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 300);
        
//        _rightView.center = CGPointMake(_rightView.center.x
//                                        , _rightView.center.y - 300);
//        
        
        
    }];
    
    
  
}

-(void)textViewDidChange:(UITextView *)textView
{
    

    
    NSString *suggest = textView.text;
    
    NSDictionary *rightdict = [_rightDataArray objectAtIndex:_rightSelectedindex];
    
    NSMutableDictionary *muRightDict = [[NSMutableDictionary alloc]initWithDictionary:rightdict];
    
    [muRightDict setObject:suggest forKey:@"suggest"];
    
    
    [_rightDataArray replaceObjectAtIndex:_rightSelectedindex withObject:muRightDict];
    
     [self saveleftdata];
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    if (textView.text.length == 0) {
        
        _suggestLabel.hidden = NO;
        
    }
    else
    {
        
    }
    
    
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 300);
    

}


#pragma mark -  UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    image = [CommonMethods autoSizeImageWithImage:image];
    
    [_photoButton setTitle:nil forState:UIControlStateNormal];
    [_photoButton setBackgroundImage:image forState:UIControlStateNormal];
    
    
    NSDictionary *dict = [_rightDataArray objectAtIndex:_rightSelectedindex];
    
    NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    
    
    NSData *imagedata = UIImagePNGRepresentation(image);
    
    [mudict setObject:imagedata forKey:@"photo"];
    
    [_rightDataArray replaceObjectAtIndex:_rightSelectedindex withObject:mudict];
    
    
       [self saveleftdata];
    
    
    
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    

    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}




-(void)dismisactin
{
     [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)adviseAction:(id)sender {
    

    
    NSDictionary *dict = [_leftDataArray objectAtIndex:_leftSelectedindex];
    
    NSArray *advises  = [dict objectForKey:@"advises"];
    
    
    if (advises.count == 0) {
        
        [CommonMethods showDefaultErrorString:@"暂无系统默认服务建议"];
        
        return;
        
    }
    
    
    self.choseWorkPlaceView.type = 3;
    
    self.choseWorkPlaceView.workDataSource = advises;
    
    self.choseWorkPlaceView.titleLabel.text = @"服务建议";
    
    
    self.choseWorkPlaceView.selectedDict = [_rightDataArray objectAtIndex:_rightSelectedindex];
    

    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.choseWorkPlaceView];
    
}


-(void)didChoseItems:(NSArray*)items
{
    
    NSDictionary *selectedDict = [items firstObject];
    
    NSString *advise = [selectedDict objectForKey:@"advise"];
    
    NSInteger advise_id = [[selectedDict objectForKey:@"advise_id"]integerValue];
    
    NSDictionary *rightdict = [_rightDataArray objectAtIndex:_rightSelectedindex];
    
    NSMutableDictionary *muRightDict = [[NSMutableDictionary alloc]initWithDictionary:rightdict];
    
    [muRightDict setObject:advise forKey:@"advise"];
    
    [muRightDict setObject:@(advise_id) forKey:@"advise_id"];
    
    
    [_rightDataArray replaceObjectAtIndex:_rightSelectedindex withObject:muRightDict];
    
    [self saveleftdata];
    
    
    [_advisButton setTitle:advise forState:UIControlStateNormal];
    
    
    
    
}


#pragma mark - 更新左边数据
-(void)saveleftdata
{
    NSDictionary *leftdict = [_leftDataArray objectAtIndex:_leftSelectedindex];
    
    NSMutableDictionary *muleftdict = [[NSMutableDictionary alloc]initWithDictionary:leftdict];
    
    [muleftdict setObject:_rightDataArray forKey:@"subchecks"];
    
    [_leftDataArray replaceObjectAtIndex:_leftSelectedindex withObject:muleftdict];
}


- (IBAction)summitAction:(id)sender {
    
    
    [self.view endEditing:YES];
    
    car_check_result = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _leftDataArray.count; i++) {
        
        NSDictionary *leftDict = [_leftDataArray objectAtIndex:i];
        NSString *position = [leftDict objectForKey:@"desc"];
        
        NSArray *subchecks = [leftDict objectForKey:@"subchecks"];
        
        for (int d = 0; d < subchecks.count; d++) {
            
            NSDictionary *subcheck = [subchecks objectAtIndex:d ];
            
            BOOL selected = [[subcheck objectForKey:@"selected"]boolValue];
            
            if (selected) {
                
//                if (![subcheck objectForKey:@"photo"]) {
//                    
//                    [CommonMethods showDefaultErrorString:[NSString stringWithFormat: @"请上传 %@-%@ 的描述图片",position,[subcheck objectForKey:@"desc"]]];
//                    
//                    return;
//                    
//                    
//                    
//                }
                
                
                NSMutableDictionary *musubcheck = [[NSMutableDictionary alloc]initWithDictionary:subcheck];
                
                [musubcheck setObject:position forKey:@"position"];
                
                
                [car_check_result addObject:musubcheck];
                
            }
        }
    }
    
    
    
    NSLog(@"car_check_result:%ld",(long)car_check_result.count);
    
    
    if (car_check_result.count == 0) {
        
        [CommonMethods showDefaultErrorString:@"请选择环检问题"];
        
        return;
    }
    
    
    summitCount = 0;
    
    
    [self summitdataindex:0];
    

    
}

-(void)summitdataindex:(NSInteger)index
{
    NSDictionary *orderinfodict = [[NSUserDefaults standardUserDefaults] objectForKey:kOrderInfo];
    
    NSDictionary *firstproblem = [car_check_result objectAtIndex:index];
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setDictionary:orderinfodict];
    
    int keeper_id = [UserInfo getkeeperid];
    
    NSString *position = [firstproblem objectForKey:@"position"];
    NSString *position_problem = [firstproblem objectForKey:@"desc"];
    NSString *advise = [firstproblem objectForKey:@"advise"];
    NSString *suggest = [firstproblem objectForKey:@"suggest"];
    
    
    if (advise.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请选择服务建议"];
        return;
        
    }
    
    if (suggest.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请填写管家建议"];
        
        return;
        
    }
    
    [params setObject:@(keeper_id) forKey:@"keeper_id"];
    
    [params setObject:position forKey:@"position"];
    [params setObject:position_problem forKey:@"position_problem"];
    [params setObject:advise forKey:@"advise"];
    [params setObject:suggest forKey:@"suggest"];
    
    
    
    
    NSData *photo = [firstproblem objectForKey:@"photo"];
    
    
    [[NetWorking shareNetWorking] RequestWithAction:kSummitcarcheck Params:params Data:photo name:@"photo" filename:@"photo.png" result:^(BOOL isSuccess, id data) {
        
        if (isSuccess) {
            
            summitCount ++;
            
            if (summitCount < car_check_result.count) {
                
                [self summitdataindex:summitCount];
                
                
            }
            else
            {
                  [MyProgressHUD dismiss];
                
                [CommonMethods showDefaultErrorString:@"环车检查报告提交成功"];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
            
           
        }
        else
        {
              [MyProgressHUD dismiss];
        }
    }];
}
@end
