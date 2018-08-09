//
//  UITextField+SLLimitInput.h
//  LimitInputDemo
//
//  Created by sl on 2018/8/9.
//  Copyright © 2018年 WSonglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SLLimitInput)

/**
 限制最大输入字符数

 @param maxCount 最大输入字符数
 */
- (void)limitInputWithMaxCount:(NSInteger)maxCount;

@end
