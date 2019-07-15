 # MJDADS

## 依赖外部引用
    pod 'MBProgressHUD'
    pod 'AFNetworking'
    pod 'Masonry'
    pod 'SDWebImage' 
    pod 'ReactiveCocoa' ,'~> 2.5'
    pod 'MJExtension'
    pod 'SVProgressHUD'



## Installation

1.将压缩包内所有文件以及Lic文件全部导入至工程内，并将cocoapods添加以上依赖库
2.引入：MJDADS.h 并遵循MJDADSDelegate代理
3.使用 [[MJDADS sharedSDK]startSDKComplete:nil];初始化SDK后使用SDK后续功能。

## SDK简述
本SDK开发旨在提供方便快捷地获取汽车配件信息，通过VIN码进行车辆定型后即可使用圈选或者配件名、OE等形式获取配件信息。 

本SDK使用时需要获取license。商务合作请联系[明觉科技](http://www.dataenlighten.com)，SDK仅提供合作客户使用，违用必究!


----------
## SDK介绍
### 一、提供两个服务
#### 1.VIN定型接口，传入合法的VIN码，返回VIN解析结果。

``` objectivec
- (void)vinParseWithVinCode:(NSString*)vinCode complete:(ServiceResponseBlock)complete;
```
由于部分车型原厂无法锁定唯一，所以vin定型后有可能返回多个车型信息，请根据返回值中的optionCode进行区分，

----------
#### 2. 获得圈选页面，传入VIN和已选定车型的optionCode，快速得到一个带有导航栏的圈选页面的ViewController

``` objectivec
- (void)getDrawCircleControllerWithVinCode:(NSString*)vinCode optionCode:(NSString*)optionCode complete:(ServiceResponseBlock)complete;
```
返回的respones即是圈选页面的NavController

----------

## 代理方法
``` objectivec
- (void)didReceiveCaseData:(NSArray*)caseData;
```
当用户点最终完成按钮的时候，SDK会同步回调案件信息给app，caseData包含配件和工时，分别为MJPart、MJLabor

## 错误码介绍

| ErrorCode | ErrorDesc                |
| --------- | ------------------------ |
| 9001      | 警告!非法请求!           |
| 3001      | 车型信息获取失败         |
| 50001     | 请先进行VIN定型          |
| 50002     | VIN码错误                |
