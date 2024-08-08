//
//  QAXSpecResoursLoader.m
//  QAXQRCode
//
//  Created by dufangyi on 2024/8/6.
//

#import "QAXSpecResoursLoader.h"

@implementation QAXSpecResoursLoader

+(UIImage *)imageWithName:(NSString *)imageName{
    /// 静态库 url 的获取
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"QAXQRCode" withExtension:@"bundle"];
    if (!url) {
        /// 动态库 url 的获取
        url = [[NSBundle bundleForClass:[self class]] URLForResource:@"QAXQRCode" withExtension:@"bundle"];
    }
    NSBundle *bundle = [NSBundle bundleWithURL:url];
    
    UIImage *image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    return image;

}
@end
