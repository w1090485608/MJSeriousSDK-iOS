//
//  MJPart.h
//  MJDADS
//
//  Created by DANIEL on 2019/7/3.
//  Copyright © 2019 DANIEL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJPart : NSObject
@property (nonatomic , copy) NSArray* collisionCodes;
@property (nonatomic , copy) NSString* partNumber;  //配件oe号
@property (nonatomic , copy) NSString* partPrice;   //配件价格
@property (nonatomic , copy) NSString* srcPartName;  // 配件原厂名称
@property (nonatomic , copy) NSString* stdPartName;  //明觉标准名
@property (nonatomic , copy) NSString* thumbnailURl; //配件缩略图
@property (nonatomic , copy) NSString* operation;   //工项
@property (nonatomic , copy) NSString* source;

@property (nonatomic , assign) BOOL selected;

@end

NS_ASSUME_NONNULL_END
