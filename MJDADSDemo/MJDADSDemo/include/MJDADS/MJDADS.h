//
//  MJDADS.h
//  MJDADS
//
//  Created by DANIEL on 2019/7/2.
//  Copyright © 2019 DANIEL. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *
 *  @brief 服务器响应回调
 *
 *  @param response 返回的结果数据
 *  @param success  是否成功返回数据
 *  @param error    未成功返回时的出错信息
 */
typedef void(^ServiceResponseBlock)(id _Nullable response,BOOL success,NSError *_Nullable error);

@protocol MJDADSDelegate <NSObject>

- (void)didReceiveCaseData:(NSArray*)caseData;

@end

@interface MJDADS : NSObject

@property (nonatomic, weak, nullable) id <MJDADSDelegate> delegate;

+ (instancetype)sharedSDK;

/**
 初始化sdk
 */
- (void)startSDKComplete:(void(^)(BOOL success))completion;


//错误码
//1001    VIN不合法
//1002    VIN不支持
//1003    非乘用车
//1004    VIN错误
//1005    VIN无法解析
//1006    您无权查看该品牌数据，请确认！
//1011     请求VIN的配件数据不存在！
//1012    该车无此配件
//1013    请求图片不存在，请确认！
//1091    后台API程序异常
//1092    获取视图定义失败
//9001    系统错误
//9002     token已过期
//9003    参数不合法


/**
 Vin定型服务，定型成功将返回对应vin得车辆信息

 @param vinCode vin码
 @param complete 返回结果
 */
- (void)vinParseWithVinCode:(NSString*)vinCode complete:(ServiceResponseBlock)complete;


/**
 获得圈选页面

 @param vinCode  vin码
 @param optionCode 车辆配置码，vin定型结果返回的信息中的optionCode字段
 @param complete 返回结果-如果成功将返回带导航栏的圈选页面
 */
- (void)getDrawCircleControllerWithVinCode:(NSString*)vinCode optionCode:(NSString*)optionCode complete:(ServiceResponseBlock)complete;


@end
