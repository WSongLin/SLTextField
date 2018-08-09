//
//  UITextField+SLLimitInput.m
//  LimitInputDemo
//
//  Created by sl on 2018/8/9.
//  Copyright © 2018年 WSonglin. All rights reserved.
//

#import "UITextField+SLLimitInput.h"
#import "UIView+Toast.h"

@implementation UITextField (SLLimitInput)

- (void)limitInputWithMaxCount:(NSInteger)maxCount {
    NSString *lang = [self.textInputMode primaryLanguage];
    // 简体中文输入
    if ([lang isEqualToString:@"zh-Hans"]) {
        //获取高亮内容的范围
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            //判断第三方中文输入法的emoji表情
            [self subStringWithMaxCount:maxCount];
        }
    } else {// 中文输入法以外（英文和emoji）的直接对其统计限制即可
        [self subStringWithMaxCount:maxCount];
    }
}

- (void)subStringWithMaxCount:(NSInteger)maxCount {
    if (self.text.length > maxCount) {
        CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
        style.messageFont = [UIFont systemFontOfSize:14.f];
        style.messageColor = [UIColor redColor];
        style.messageAlignment = NSTextAlignmentCenter;
        style.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.8f];
        
        NSString *message = [NSString stringWithFormat:@"最多只能输入%ld个字符！", (long)maxCount];
        
        [self makeToast:message
               duration:2.0
               position:CSToastPositionBottom
                  style:style];
        
        //rangeOfComposedCharacterSequenceAtIndex: 从参数NSUInteger位置处，向后计算一个完整字符串所占据的range
        NSRange rangeIndex = [self.text rangeOfComposedCharacterSequenceAtIndex:maxCount];
        if (1 == rangeIndex.length) {
            self.text = [self.text substringToIndex:maxCount];
        } else {
            //rangeOfComposedCharacterSequencesForRange: 返回参数range范围内完整字符串所占据的新的range
            NSRange rangeRange = [self.text rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxCount)];
            self.text = [self.text substringWithRange:rangeRange];
        }
    }
}

@end
