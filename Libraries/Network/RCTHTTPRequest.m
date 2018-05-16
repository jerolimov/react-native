/**
 * Copyright (c) 2015-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RCTHTTPRequest.h"

#import <React/RCTConvert.h>

@implementation RCTHTTPRequest

- (instancetype)initWithQuery:(NSDictionary<NSString *, id> *)query
{
  self = [super init];
  if (self) {
    self.HTTPMethod = [RCTConvert NSString:RCTNilIfNull(query[@"method"])].uppercaseString ?: @"GET";
    self.URL = [RCTConvert NSURL:query[@"url"]]; // this is marked as nullable in JS, but should not be null

    // Load and set the cookie header.
    NSArray<NSHTTPCookie *> *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:self.URL];
    self.allHTTPHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];

    // Set supplied headers.
    NSDictionary *headers = [RCTConvert NSDictionary:query[@"headers"]];
    [headers enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
      if (value) {
        [self addValue:[RCTConvert NSString:value] forHTTPHeaderField:key];
      }
    }];

    self.timeoutInterval = [RCTConvert NSTimeInterval:query[@"timeout"]];
    self.HTTPShouldHandleCookies = [RCTConvert BOOL:query[@"withCredentials"]];

    NSString *redirect = query[@"redirect"];
    if ([redirect isEqualToString:@"error"]) {
      self.redirect = RCTURLRequestRedirectError;
    } else if ([redirect isEqualToString:@"manual"]) {
      self.redirect = RCTURLRequestRedirectManual;
    }
  }
  return self;
}

@end
