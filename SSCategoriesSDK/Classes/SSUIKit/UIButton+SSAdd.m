//
//  UIButton+SSAdd.m
//  12313213
//
//  Created by jiuhao-yangshuo on 16/5/24.
//  Copyright © 2016年 jiuhao. All rights reserved.
//

#import "UIButton+SSAdd.h"
#import <objc/runtime.h>
@implementation UIButton (SSAdd)

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

#pragma mark - EnlargeTouchArea
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)SSEnlargedRect {
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}

- (UIView*) hitTest:(CGPoint) point withEvent:(UIEvent*) event {
    CGRect rect = [self SSEnlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

@end


@implementation UIButton (SSUIButtonInfo)

- (NSString *)buttonDefultString {
    return objc_getAssociatedObject(self, cachesIDKey);
}

- (void)setButtonDefultString:(NSString *)buttonDefultString {
    objc_setAssociatedObject(self, cachesIDKey, buttonDefultString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDicInfo:(id)dicInfo {
    objc_setAssociatedObject(self, cachesIDKey2, dicInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)dicInfo {
    return objc_getAssociatedObject(self, cachesIDKey2);
}

@end
