//
//  ViewController.m
//  MJDADSDemo
//
//  Created by 袁兴杨 on 2019/7/11.
//  Copyright © 2019 袁兴杨. All rights reserved.
//

#import "ViewController.h"
#import "MJDADS.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
@interface ViewController ()<MJDADSDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView* tableView;
@property (nonatomic , strong) NSMutableArray* dataArray;


@property (nonatomic , strong) UITextField* vinTextField;
@property (nonatomic , strong) UIButton* vinParseButton;
@property (nonatomic , strong) UIButton* showVcButton;

@property (nonatomic , strong) NSDictionary* selected;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //多车型配置vin:LVHFR1826F6066613
    //单车型配置vin:LBV5S1106ESH78688
    
    [[MJDADS sharedSDK] startSDKComplete:^(BOOL success) {
        
    }];
    [MJDADS sharedSDK].delegate = self;
    
    [self.view addSubview:self.vinParseButton];
    [self.view addSubview:self.vinTextField];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.showVcButton];
    [self.vinTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(90);
        make.right.mas_equalTo(self.vinParseButton.mas_left).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    [self.vinParseButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view);
        make.centerY.height.mas_equalTo(self.vinTextField);
        make.width.mas_equalTo(90);
    }];
    [self.showVcButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.vinTextField.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.showVcButton.mas_top);
    }];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UITextField *)vinTextField
{
    if (!_vinTextField) {
        _vinTextField = [[UITextField alloc]init];
        _vinTextField.placeholder = @"请输入VIN";
        _vinTextField.layer.borderWidth = 0.5;
        _vinTextField.text = @"LVHFR1826F6066613";
        _vinTextField.clearButtonMode = UITextFieldViewModeAlways;
        _vinTextField.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    }
    return _vinTextField;
}

- (UIButton *)vinParseButton
{
    if (!_vinParseButton) {
        _vinParseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_vinParseButton setTitle:@"vin定型" forState:UIControlStateNormal];
        [_vinParseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_vinParseButton setBackgroundColor:[UIColor lightGrayColor]];
        _vinParseButton.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            [[MJDADS sharedSDK]vinParseWithVinCode:self.vinTextField.text complete:^(id  _Nullable response, BOOL success, NSError * _Nullable error) {
                if (success) {
                    self.dataArray = [response objectForKey:@"data"];
                    [self.tableView reloadData];
                }
            }];
            return [RACSignal empty];
        }];
    }
    
    return _vinParseButton;
}

- (UIButton *)showVcButton
{
    if (!_showVcButton) {
        _showVcButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showVcButton setTitle:@"vin定型" forState:UIControlStateNormal];
        [_showVcButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showVcButton setBackgroundColor:[UIColor lightGrayColor]];
        _showVcButton.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            if (self.selected) {
                [[MJDADS sharedSDK] getDrawCircleControllerWithVinCode:[self.selected objectForKey:@"vinCode"] optionCode:[self.selected objectForKey:@"optionCode"]  complete:^(id  _Nullable response, BOOL success, NSError * _Nullable error) {
                    if (success) {
                        [self presentViewController:response animated:YES completion:nil];
                    }
                }];
            }
            else
            {
                //...
            }
            return [RACSignal empty];
        }];
    }
    return _showVcButton;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellid"];
    }
    NSDictionary* d = self.dataArray[indexPath.row];
    cell.textLabel.text = [[[[[d objectForKey:@"subBrand"]stringByAppendingString:[d objectForKey:@"vehicleChn"]]stringByAppendingString:[d objectForKey:@"displacement"]]stringByAppendingString:[d objectForKey:@"transmission"]]stringByAppendingString:[d objectForKey:@"year"]];
    cell.detailTextLabel.text = [d objectForKey:@"optionInfo"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selected = self.dataArray[indexPath.row];
}

- (void)didReceiveCaseData:(NSArray *)caseData
{
    NSLog(@"%@",caseData);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
