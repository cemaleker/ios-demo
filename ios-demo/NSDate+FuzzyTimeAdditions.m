#import "NSDate+FuzzyTimeAdditions.h"

@implementation NSDate (FuzzyTime)


-(NSString *)fuzzyTime {
    NSDate *now = [NSDate date];
    double deltaSeconds = fabs([self timeIntervalSinceDate:now]);
    double deltaMinutes = deltaSeconds / 60.0f;
    
    if(deltaSeconds < 60) {
        return [NSString stringWithFormat:@"%ds", (int)deltaSeconds];
    } else if(deltaSeconds < 120) {
        return @"1m";
    } else if (deltaMinutes < 60) {
        return [NSString stringWithFormat:@"%dm", (int)deltaMinutes];
    } else if (deltaMinutes < 120) {
        return @"1h";
    } else if (deltaMinutes < (24 * 60)) {
        return [NSString stringWithFormat:@"%dh", (int)floor(deltaMinutes/60)];
    } else if (deltaMinutes < (24 * 60 * 2)) {
        return @"1d";
    } else if (deltaMinutes < (24 * 60 * 7)) {
        return [NSString stringWithFormat:@"%dd", (int)floor(deltaMinutes/(60 * 24))];
    } else if (deltaMinutes < (24 * 60 * 14)) {
        return @"1w";
    } else if (deltaMinutes < (24 * 60 * 31)) {
        return [NSString stringWithFormat:@"%dw", (int)floor(deltaMinutes/(60 * 24 * 7))];
    } else if (deltaMinutes < (24 * 60 * 61)) {
        return @"1mo";
    } else if (deltaMinutes < (24 * 60 * 365.25)) {
        return [NSString stringWithFormat:@"%dmo", (int)floor(deltaMinutes/(60 * 24 * 30))];
    } else if (deltaMinutes < (24 * 60 * 731)) {
        return @"1y";
    }
    return [NSString stringWithFormat:@"%dy", (int)floor(deltaMinutes/(60 * 24 * 365))];
}

@end