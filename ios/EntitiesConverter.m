//
//  EntitiesConverter.m
//  Qonversion
//
//  Created by Surik Sarkisyan on 27.11.2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "EntitiesConverter.h"
#import <Qonversion/QNLaunchResult.h>
#import <Qonversion/QNOffering.h>
#import <Qonversion/QNOfferings.h>
#import <Qonversion/QNIntroEligibility.h>
#import <Qonversion/QNExperimentInfo.h>
#import <Qonversion/QNExperimentGroup.h>

@implementation EntitiesConverter

+ (NSDictionary *)convertActionResult:(QONActionResult *)actionResult {
    NSMutableDictionary *result = [NSMutableDictionary new];

    NSDictionary *types = @{
        @(QONActionResultTypeURL): @"url",
        @(QONActionResultTypeDeeplink): @"deeplink",
        @(QONActionResultTypeNavigation): @"navigate",
        @(QONActionResultTypePurchase): @"purchase",
        @(QONActionResultTypeRestore): @"restore",
        @(QONActionResultTypeClose): @"close"
    };

    result[@"type"] = types[@(actionResult.type)] ? : @"unknown";
    result[@"value"] = actionResult.parameters;
    if (actionResult.error) {
        result[@"error"] = [EntitiesConverter convertError:actionResult.error];
    }

    return [result copy];
}

+ (NSDictionary *)convertAutomationsEvent:(QONAutomationsEvent *)event {
    NSMutableDictionary *result = [NSMutableDictionary new];

    NSDictionary *types = @{
        @(QONAutomationsEventTypeTrialStarted): @"trial_started",
        @(QONAutomationsEventTypeTrialConverted): @"trial_converted",
        @(QONAutomationsEventTypeTrialCanceled): @"trial_canceled",
        @(QONAutomationsEventTypeTrialBillingRetry): @"trial_billing_retry_entered",
        @(QONAutomationsEventTypeSubscriptionStarted): @"subscription_started",
        @(QONAutomationsEventTypeSubscriptionRenewed): @"subscription_renewed",
        @(QONAutomationsEventTypeSubscriptionRefunded): @"subscription_refunded",
        @(QONAutomationsEventTypeSubscriptionCanceled): @"subscription_canceled",
        @(QONAutomationsEventTypeSubscriptionBillingRetry): @"subscription_billing_retry_entered",
        @(QONAutomationsEventTypeInAppPurchase): @"in_app_purchase",
        @(QONAutomationsEventTypeSubscriptionUpgraded): @"subscription_upgraded",
        @(QONAutomationsEventTypeTrialStillActive): @"trial_still_active",
        @(QONAutomationsEventTypeTrialExpired): @"trial_expired",
        @(QONAutomationsEventTypeSubscriptionExpired): @"subscription_expired",
        @(QONAutomationsEventTypeSubscriptionDowngraded): @"subscription_downgraded",
        @(QONAutomationsEventTypeSubscriptionProductChanged): @"subscription_product_changed"
    };

    result[@"type"] = types[@(event.type)] ? : @"unknown";
    result[@"timestamp"] = @(event.date.timeIntervalSince1970 * 1000);

    return [result copy];
}

@end
