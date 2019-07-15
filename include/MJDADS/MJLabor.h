//
//  MJLabor.h
//  MJDADS
//
//  Created by DANIEL on 2019/7/4.
//  Copyright © 2019 DANIEL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJLabor : NSObject
@property (nonatomic , strong) NSString* laborName; //工时名称
@property (nonatomic , strong) NSString* operation; // 实际工项（例如: replace、panel、fit、accessoryFit、paint, material、externalRepair、electrical）【更换、钣金/维修、拆装、附件拆装、喷漆、辅料、外修、机电】
@property (nonatomic , strong) NSString* laborHour; //工时数目
@property (nonatomic , strong) NSString* laborCost; //工时金额
@end

NS_ASSUME_NONNULL_END
