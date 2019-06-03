//
//  AppDelegate.swift
//  Paramount
//
//  Created by Yugasalabs-28 on 27/05/2019.
//  Copyright © 2019 Yugasalabs. All rights reserved.
//

#import "ServerHandler.h"
#define BaseUrl @"http://203.92.41.131/ms-backend/api"

@implementation ServerHandler

-(void)serviceRequestWithInfo:(NSDictionary *)infoDict serviceType:(ServiceRequestType)serviceType params:(id)params completionBlock:(CompletionBlock)block
{
    self.completionBlock=block;
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    
    NSString * urlString;
    
    if (serviceType == ServiceTypeLogin)
    {
        urlString = [NSString stringWithFormat:@"%@/login",BaseUrl];
    }
    else if (serviceType == ServiceTypeForgetPassword)
    {
        urlString = [NSString stringWithFormat:@"%@",BaseUrl];
    }
    else if (serviceType == ServiceTypeGetCurrency)
    {
        urlString = [NSString stringWithFormat:@"http://data.fixer.io/api/latest?access_key=a8385073328d4bf3b32350c631ef323b&format=1"];
    }
   
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"Url : %@",urlString);
    
    if (params)
    {
        NSLog(@" Check Params %@",params);
        [request setURL:[NSURL URLWithString:urlString]];
        NSData *myData = [NSJSONSerialization dataWithJSONObject:params
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:nil];;
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:myData];
    }
    
    
    NSURL * url = [NSURL URLWithString:urlString];
    [request setURL:url];
    NSURLConnection * connection = [NSURLConnection connectionWithRequest:request delegate:(id)self];
    
}

#pragma NSURL Connection Delegates

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    NSLog(@"error : %@",error.localizedDescription);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary * dict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:nil];
    self.completionBlock(dict,nil);
    NSLog(@"Finished");
}


@end

