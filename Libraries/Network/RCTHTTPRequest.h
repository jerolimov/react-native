/**
 * Copyright (c) 2015-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <Foundation/Foundation.h>

@interface RCTHTTPRequest : NSMutableURLRequest

typedef NS_ENUM(NSInteger, RCTURLRequestRedirect) {
  RCTURLRequestRedirectFollow = 0,
  RCTURLRequestRedirectError,
  RCTURLRequestRedirectManual,
};

@property (nonatomic, assign) RCTURLRequestRedirect redirect;

- (instancetype)initWithQuery:(NSDictionary<NSString *, id> *)query;

@end
