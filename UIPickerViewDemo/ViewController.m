//
//  ViewController.m
//  UIPickerViewDemo
//
//  Created by YJunxiao on 16/1/11.
//  Copyright © 2016年 袁俊晓. All rights reserved.
//

#import "ViewController.h"
#import "AbstractActionSheetPicker+Interface.h"//这个是定义取消和确定按钮
#import "ActionSheetPicker.h"
#import "XKPEActionPickersDelegate.h"
#import "XKPEWeightAndHightActionPickerDelegate.h"
#define kScreenSize [UIScreen mainScreen].bounds.size
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,XKPEDocPopoDelegate,XKPEWeigthAndHightDelegate>
{
    int a;
}
@property (nonatomic ,strong) UITableView   *tableview;
@property (nonatomic , strong) NSDate         *selectedDate;
@property (nonatomic ,strong) XKPEActionPickersDelegate *actionPicker; //三列
@property (nonatomic , strong) XKPEWeightAndHightActionPickerDelegate *weightAndHight;//列组
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creattableview];
     self.selectedDate = [NSDate date];//日期时用
    // Do any additional setup after loading the view, typically from a nib.
}
//Tableview
-(void)creattableview{
    
    _tableview                 = [[UITableView alloc]initWithFrame:CGRectMake(0, 100,kScreenSize.width, kScreenSize.height-64) style:UITableViewStylePlain];
    
    _tableview.delegate        = self;
    _tableview.dataSource      = self;//设置代理
    //允许多项选择 默认是no；默认是单选
    _tableview.allowsMultipleSelection = YES;
    
    _tableview.tableFooterView  =[[UIView alloc]initWithFrame:CGRectZero];//取消多余行数
    _tableview.backgroundColor = [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:1.0];
    [self.view addSubview:_tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titleArr     = @[@"一列pick",@"三列pick",@"六列pick",@"日期pick"];
    
    static NSString *str=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = titleArr[indexPath.row];
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消了一直高亮
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {//一组
            NSMutableArray *dataArr = [[NSMutableArray alloc]init];
            for (NSInteger i=50; i<=150; i++) {
                NSString *datastr = [NSString stringWithFormat:@"%ldcm",i];
                [dataArr addObject:datastr];
            }
            ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc]initWithTitle:@"录入腹围" rows:dataArr initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                //*********一组点击确认按钮做处理************
                NSLog(@"选择的腹围%@",selectedValue);
               
                
            } cancelBlock:^(ActionSheetStringPicker *picker) {
                
            } origin:self.view];
            [actionPicker customizeInterface];
            [actionPicker showActionSheetPicker];
            
        }
            break;
        case 1:
        {//两组  需要自定义一些delegate
            NSMutableArray *arr1 = [[NSMutableArray alloc]init];
            for (NSInteger i=30; i<=150; i++) {
                NSString *datastr = [NSString stringWithFormat:@"%ld",i];
                [arr1 addObject:datastr];
            }
            NSMutableArray *arr3 = [[NSMutableArray alloc]init];
            for (NSInteger i=0; i<=9; i++) {
                NSString *datastr = [NSString stringWithFormat:@"%ldKg",i];
                [arr3 addObject:datastr];
            }
            NSArray *arr2 =@[@"."];
            
            _actionPicker = [[XKPEActionPickersDelegate alloc]initWithArr1:arr1 Arr2:arr2 arr3:arr3 title:@"体重"];
            _actionPicker.delegates = self;
            
            ActionSheetCustomPicker *action = [[ActionSheetCustomPicker alloc]initWithTitle:@"录入体重" delegate:_actionPicker showCancelButton:YES origin:self.view];
            [action customizeInterface];
            [action showActionSheetPicker];

        }
            break;
        case 2:
        {//三组   需要自定义一些delegate
            NSMutableArray *arr1 = [[NSMutableArray alloc]init];
            for (NSInteger i=130; i<=200; i++) {
                NSString *datastr = [NSString stringWithFormat:@"%ld",i];
                [arr1 addObject:datastr];
            }
            NSMutableArray *arr3 = [[NSMutableArray alloc]init];
            for (NSInteger i=0; i<=9; i++) {
                NSString *datastr = [NSString stringWithFormat:@"%ldcm",i];
                [arr3 addObject:datastr];
            }
            NSArray *arr2 =@[@"."];
            NSMutableArray *arr4 = [[NSMutableArray alloc]init];
            for (NSInteger i=30; i<=150; i++) {
                NSString *datastr = [NSString stringWithFormat:@"%ld",i];
                [arr4 addObject:datastr];
            }
            NSMutableArray *arr6 = [[NSMutableArray alloc]init];
            for (NSInteger i=0; i<=9; i++) {
                NSString *datastr = [NSString stringWithFormat:@"%ldKg",i];
                [arr6 addObject:datastr];
            }
            NSArray *arr5 =@[@"."];
            _weightAndHight = [[XKPEWeightAndHightActionPickerDelegate alloc]initWithArr1:arr1 Arr2:arr2 arr3:arr3 Arr4:arr4 Arr5:arr5 arr6:arr6];
            _weightAndHight.delegates = self;
            ActionSheetCustomPicker *action = [[ActionSheetCustomPicker alloc]initWithTitle:@"录入身高和体重" delegate:_weightAndHight showCancelButton:YES origin:self.view];
            [action customizeInterface];
            [action showActionSheetPicker];
            
        }
            break;
        case 3:
        {//日期
            a= 1;
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *minimumDateComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay  fromDate:[NSDate date]];
            [minimumDateComponents setYear:2000];//最小日期
            NSDate *minDate = [calendar dateFromComponents:minimumDateComponents];
            NSDate *maxDate = [NSDate date];//最大日期，今天
            ActionSheetDatePicker *actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"请选择日期" datePickerMode:UIDatePickerModeDate selectedDate:self.selectedDate                                                              target:self action:@selector(dateWasSelected:element:) origin:self.view];
            [actionSheetPicker customizeInterface];
            [actionSheetPicker setMinimumDate:minDate];
            [actionSheetPicker setMaximumDate:maxDate];
            [actionSheetPicker showActionSheetPicker];
        }
            break;
            
        default:
            break;
    }
}
//选择时间
- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    if (a == 0) {
        NSLog(@"aa");
    }
    else
    {
        NSLog(@"选择的时间%@",selectedDate);
    }
    
}
//三组数据的点击事件
-(void)xkactionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin{
    if ([_actionPicker.title isEqualToString:@"体重"]) { //体重处理 当出现弹框但是没有滑动选择就点确认时，获取的数据时空，所以分情况处理
        if (!_actionPicker.selectedKey1  && !_actionPicker.selectedkey3) {
            NSLog(@"选择的体重是：30.0Kg");
            
        }
        else if (!_actionPicker.selectedKey1 && _actionPicker.selectedkey3) {
            
            NSLog(@"选择的体重是：30.%@",_actionPicker.selectedkey3);
          
            
        }else if (!_actionPicker.selectedkey3 && _actionPicker.selectedKey1) {
        
            NSLog(@"选择的体重是：%@.0Kg",_actionPicker.selectedKey1);
        }
        else{
            NSLog(@"选择的体重是：%@.%@",_actionPicker.selectedKey1,_actionPicker.selectedkey3);

        }
        
    }
}
//六组数据的点击事件
-(void)xkwightactionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin{
//当没有选择就点击确认时，获取的是空，所以要做不同的处理
    if (!_weightAndHight.selectedKey1 && _weightAndHight.selectedkey3 && _weightAndHight.selectedKey4 && _weightAndHight.selectedkey6) {
        
        NSLog(@"选中的身高体重：130.%@ %@.%@",_weightAndHight.selectedkey3,_weightAndHight.selectedKey4,_weightAndHight.selectedkey6);
        
    }else if (_weightAndHight.selectedKey1 && !_weightAndHight.selectedkey3 && _weightAndHight.selectedKey4 && _weightAndHight.selectedkey6){
    
        NSLog(@"选中的身高体重：%@.0cm %@.%@",_weightAndHight.selectedKey1,_weightAndHight.selectedKey4,_weightAndHight.selectedkey6);
        
    }else if (_weightAndHight.selectedKey1 && _weightAndHight.selectedkey3 && !_weightAndHight.selectedKey4 && _weightAndHight.selectedkey6){
    
        NSLog(@"选中的身高体重：%@.%@ 30.%@",_weightAndHight.selectedKey1,_weightAndHight.selectedkey3,_weightAndHight.selectedkey6);
    }
    else if (_weightAndHight.selectedKey1 && _weightAndHight.selectedkey3 && _weightAndHight.selectedKey4 && !_weightAndHight.selectedkey6){
        
        NSLog(@"选中的身高体重：%@.%@ %@.0Kg",_weightAndHight.selectedKey1,_weightAndHight.selectedkey3,_weightAndHight.selectedKey4);
    }
    ///////////////
    else if (!_weightAndHight.selectedKey1 && !_weightAndHight.selectedkey3 && _weightAndHight.selectedKey4 && _weightAndHight.selectedkey6){
       
        NSLog(@"选中的身高体重：130.0cm %@.%@",_weightAndHight.selectedKey4,_weightAndHight.selectedkey6);
    }
    else if (!_weightAndHight.selectedKey1 && _weightAndHight.selectedkey3 && !_weightAndHight.selectedKey4 && _weightAndHight.selectedkey6){
        
        NSLog(@"选中的身高体重：130.%@ 30.%@",_weightAndHight.selectedkey3,_weightAndHight.selectedkey6);
    }
    else if (!_weightAndHight.selectedKey1 && _weightAndHight.selectedkey3 && _weightAndHight.selectedKey4 && !_weightAndHight.selectedkey6){
        
        NSLog(@"选中的身高体重：130.%@ %@.0Kg",_weightAndHight.selectedkey3,_weightAndHight.selectedKey4);
    }
    ////////////
    else if (_weightAndHight.selectedKey1 && !_weightAndHight.selectedkey3 && !_weightAndHight.selectedKey4 && _weightAndHight.selectedkey6){
        
        NSLog(@"选中的身高体重：%@.0cm 30.%@",_weightAndHight.selectedKey1,_weightAndHight.selectedkey6);
    }else if (_weightAndHight.selectedKey1 && !_weightAndHight.selectedkey3 && _weightAndHight.selectedKey4 && !_weightAndHight.selectedkey6){
        
        NSLog(@"选中的身高体重：%@.0cm %@.0Kg",_weightAndHight.selectedKey1,_weightAndHight.selectedKey4);
    }
    //////////
    else if (_weightAndHight.selectedKey1 && _weightAndHight.selectedkey3 && !_weightAndHight.selectedKey4 && !_weightAndHight.selectedkey6){
        
        NSLog(@"选中的身高体重：%@.%@ 30.0Kg",_weightAndHight.selectedKey1,_weightAndHight.selectedkey3);
    }
    //////////
    else if (_weightAndHight.selectedKey1 && !_weightAndHight.selectedkey3 && !_weightAndHight.selectedKey4 && !_weightAndHight.selectedkey6){
        NSLog(@"选中的身高体重：%@.0cm 30.0Kg",_weightAndHight.selectedKey1);
    }else if (!_weightAndHight.selectedKey1 && _weightAndHight.selectedkey3 && !_weightAndHight.selectedKey4 && !_weightAndHight.selectedkey6){
        
        NSLog(@"选中的身高体重：130.%@ 30.0Kg",_weightAndHight.selectedkey3);
    }else if (!_weightAndHight.selectedKey1 && !_weightAndHight.selectedkey3 && _weightAndHight.selectedKey4 && !_weightAndHight.selectedkey6){
        
        NSLog(@"选中的身高体重：130.0cm %@.0Kg",_weightAndHight.selectedKey4);
    }else if (!_weightAndHight.selectedKey1 && !_weightAndHight.selectedkey3 && !_weightAndHight.selectedKey4 && _weightAndHight.selectedkey6){
        
        NSLog(@"选中的身高体重：130.0cm 30.%@",_weightAndHight.selectedkey6);
    }
    ///////////
    else if (_weightAndHight.selectedKey1 && _weightAndHight.selectedkey3 && _weightAndHight.selectedKey4 && _weightAndHight.selectedkey6){
    
        NSLog(@"选中的身高体重：%@.%@ %@.%@",_weightAndHight.selectedKey1,_weightAndHight.selectedkey3,_weightAndHight.selectedKey4,_weightAndHight.selectedkey6);
    }
    //////////
    else {
       
        NSLog(@"选中的身高体重：130.0cm 30.0Kg");
    }



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
