//
//  MyLabel.m
//  MyLabel
//
//  Created by James on 14/11/4.
//  Copyright (c) 2014年 pc. All rights reserved.
//

#import "AutoLinkLabel.h"

#pragma mark - 正则列表

#define REGULAREXPRESSION_OPTION(regularExpression,regex,option) \
\
static inline NSRegularExpression * k##regularExpression() { \
static NSRegularExpression *_##regularExpression = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_##regularExpression = [[NSRegularExpression alloc] initWithPattern:(regex) options:(option) error:nil];\
});\
\
return _##regularExpression;\
}\


#define REGULAREXPRESSION(regularExpression,regex) REGULAREXPRESSION_OPTION(regularExpression,regex,NSRegularExpressionCaseInsensitive)


REGULAREXPRESSION(URLRegularExpression,@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)")

REGULAREXPRESSION(PhoneNumerRegularExpression, @"((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}")

REGULAREXPRESSION(TelNumerRegularExpression, @"0(10|2[0-5789]|\\d{3})\\d{7,8}")


REGULAREXPRESSION(EmailRegularExpression, @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}")

REGULAREXPRESSION(AtRegularExpression, @"@[\\u4e00-\\u9fa5\\w\\-\\S\\s]+")

REGULAREXPRESSION_OPTION(PoundSignRegularExpression, @"#([\\u4e00-\\u9fa5\\w\\-\\S\\s]+)#", NSRegularExpressionCaseInsensitive)

#define kURLActionCount 6

NSString * const kURLActions[] = {@"url->",@"phoneNumber->",@"at->",@"email->",@"poundSign->",@"telPhone->"};

@interface AutoLinkLabel()<TTTAttributedLabelDelegate>

@end

@implementation AutoLinkLabel

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.delegate = self;
        self.numberOfLines = 0;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.numberOfLines = 0;
    }
    
    return self;
}

- (void)commonInit {
    
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = NO;
    
    self.font = [UIFont systemFontOfSize:14.0];
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.lineBreakMode = NSLineBreakByCharWrapping;
    
    self.textInsets = UIEdgeInsetsZero;
    self.lineHeightMultiple = 1.0f;
    
    [self setValue:[NSArray array] forKey:@"links"];
    
    NSMutableDictionary *mutableLinkAttributes = [NSMutableDictionary dictionary];
    [mutableLinkAttributes setObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    
    NSMutableDictionary *mutableActiveLinkAttributes = [NSMutableDictionary dictionary];
    [mutableActiveLinkAttributes setObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    
    NSMutableDictionary *mutableInactiveLinkAttributes = [NSMutableDictionary dictionary];
    [mutableInactiveLinkAttributes setObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    
    if ([NSMutableParagraphStyle class]) {
        [mutableLinkAttributes setObject:(__bridge id)[[UIColor blueColor] CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        [mutableActiveLinkAttributes setObject:(__bridge id)[[UIColor redColor] CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        [mutableInactiveLinkAttributes setObject:[UIColor grayColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        
    } else {
        [mutableLinkAttributes setObject:(__bridge id)[[UIColor blueColor] CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        [mutableActiveLinkAttributes setObject:(__bridge id)[[UIColor redColor] CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        [mutableInactiveLinkAttributes setObject:(__bridge id)[[UIColor grayColor] CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        
    }
    
    self.linkAttributes = [NSDictionary dictionaryWithDictionary:mutableLinkAttributes];
    self.activeLinkAttributes = [NSDictionary dictionaryWithDictionary:mutableActiveLinkAttributes];
    self.inactiveLinkAttributes = [NSDictionary dictionaryWithDictionary:mutableInactiveLinkAttributes];
}


-(void)setAutoLinkText:(NSString *)autoLinkText
{
    _autoLinkText = autoLinkText;
    if (!autoLinkText||autoLinkText.length<=0) {
        [super setText:nil];
        return;
    }
    
    NSMutableAttributedString *mutableAttributedString = nil;
    
    mutableAttributedString = [[NSMutableAttributedString alloc]initWithString:autoLinkText];
    
    [self setText:mutableAttributedString afterInheritingLabelAttributesAndConfiguringWithBlock:nil];
    
    NSRange stringRange = NSMakeRange(0, mutableAttributedString.length);
    
    NSRegularExpression * const regexps[] = {kURLRegularExpression(),kPhoneNumerRegularExpression(),kAtRegularExpression(),kEmailRegularExpression(),kPoundSignRegularExpression(),kTelNumerRegularExpression()};
    
    NSMutableArray *results = [NSMutableArray array];
    
    for (NSUInteger i=0; i<kURLActionCount; i++) {
        
        NSString *urlAction = kURLActions[i];
        [regexps[i] enumerateMatchesInString:[mutableAttributedString string] options:0 range:stringRange usingBlock:^(NSTextCheckingResult *result, __unused NSMatchingFlags flags, __unused BOOL *stop) {
            
            //检查是否和之前记录的有交集，有的话则忽略
            for (NSTextCheckingResult *record in results){
                if (NSMaxRange(NSIntersectionRange(record.range, result.range))>0){
                    return;
                }
            }
            //添加链接
            NSString *actionString = [NSString stringWithFormat:@"%@%@",urlAction,[self.text substringWithRange:result.range]];
            
            NSTextCheckingResult *checkResult = [NSTextCheckingResult correctionCheckingResultWithRange:result.range replacementString:actionString];
            
            [results addObject:checkResult];
            
        }];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    //直接调用父类私有方法，setNeedDisplay只调用一次。一次更新所有添加的链接
    [super performSelector:@selector(addLinksWithTextCheckingResults:attributes:) withObject:results withObject:self.linkAttributes];
#pragma clang diagnostic pop
    
}

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result;
{
    if (result.resultType == NSTextCheckingTypeCorrection) {
        //判断消息类型
        for (NSUInteger i=0; i<kURLActionCount; i++) {
            
            if ([result.replacementString hasPrefix:kURLActions[i]]) {
                
                NSString *content = [result.replacementString substringFromIndex:kURLActions[i].length];
                
                if([self.aDelegate respondsToSelector:@selector(autoLinkLabel:didSelectLink:withType:)]){
                    
                    [self.aDelegate autoLinkLabel:self didSelectLink:content withType:i];
                    
                }
            }
        }
    }
}

@end
