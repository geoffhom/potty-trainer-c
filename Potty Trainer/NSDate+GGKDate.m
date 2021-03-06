//
//  NSDate+GGKDate.m
//  Potty Trainer
//
//  Created by Geoff Hom on 2/25/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "NSDate+GGKDate.h"

@implementation NSDate (GGKDate)

- (NSComparisonResult)compareByDay:(NSDate *)theDate
{
    NSComparisonResult theComparisonResult;
    
    // Was using the code that is commented below. However, it seems to calculate based on a specific time zone, e.g. GMT. So two dates may be different in GMT but the same in PST.
    
//    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSInteger thisDateDay = [gregorianCalendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSEraCalendarUnit forDate:self];
//    NSInteger theDateDay = [gregorianCalendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSEraCalendarUnit forDate:theDate];
//    theComparisonResult = [[NSNumber numberWithInteger:thisDateDay] compare:[NSNumber numberWithInteger:theDateDay]];
    
    // We'll get the year, month and day for both dates, then compare them.
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit aCalendarUnit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *thisDateDateComponents = [gregorianCalendar components:aCalendarUnit fromDate:self];
    NSDateComponents *theDateDateComponents = [gregorianCalendar components:aCalendarUnit fromDate:theDate];
    
    theComparisonResult = [@(thisDateDateComponents.year) compare:@(theDateDateComponents.year)];
    if (theComparisonResult == NSOrderedSame) {
        
        theComparisonResult = [@(thisDateDateComponents.month) compare:@(theDateDateComponents.month)];
        if (theComparisonResult == NSOrderedSame) {
            
            theComparisonResult = [@(thisDateDateComponents.day) compare:@(theDateDateComponents.day)];
        }
    }
    
    return theComparisonResult;
}

- (BOOL)dateIsToday {
    BOOL dateIsToday = NO;
    
    NSDate *todayDate = [NSDate date];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit aCalendarUnit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *thisDateDateComponents = [gregorianCalendar components:aCalendarUnit fromDate:self];
    NSDateComponents *todayDateDateComponents = [gregorianCalendar components:aCalendarUnit fromDate:todayDate];
    if (thisDateDateComponents.day == todayDateDateComponents.day && thisDateDateComponents.month == todayDateDateComponents.month && thisDateDateComponents.year == todayDateDateComponents.year) {
        
        dateIsToday = YES;
    }
    
    return dateIsToday;
}
- (NSDate *)dateWithTime:(NSInteger)theSecondsAfterMidnightInteger {
    NSDate *aTodayDate = [NSDate date];
    NSCalendar *aCalendar = [NSCalendar currentCalendar];
    NSUInteger aSpecificDayCalendarUnit = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
    NSDateComponents *aSpecificDayDateComponents = [aCalendar components:aSpecificDayCalendarUnit fromDate:aTodayDate];
    NSDate *aMidnightTodayDate = [aCalendar dateFromComponents:aSpecificDayDateComponents];
    NSDate *aDate = [aMidnightTodayDate dateByAddingTimeInterval:theSecondsAfterMidnightInteger];
    return aDate;
}
- (NSString *)hourMinuteAMPMString
{
    NSString *hourMinuteAMPMDateFormatString = [NSDateFormatter dateFormatFromTemplate:@"hmma" options:0 locale:[NSLocale currentLocale]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:hourMinuteAMPMDateFormatString];
    NSString *theDateString = [dateFormatter stringFromDate:self];
    return theDateString;
}

- (NSInteger)minutesAfterTime:(NSDateComponents *)theDateComponents {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit aCalendarUnit = NSMinuteCalendarUnit | NSHourCalendarUnit;
    NSDateComponents *thisDateDateComponents = [gregorianCalendar components:aCalendarUnit fromDate:self];
    NSInteger theDateMinutes = theDateComponents.hour * 60 + theDateComponents.minute;
    NSInteger thisDateMinutes = thisDateDateComponents.hour * 60 + thisDateDateComponents.minute;
    NSInteger theMinutesAfterInteger = thisDateMinutes - theDateMinutes;
    return theMinutesAfterInteger;
}

- (NSString *)monthDayString
{
    // Abbreviated month and the day (e.g., Feb 23): MMMd.
    // http://waracle.net/iphone-nsdateformatter-date-formatting-table/
    
    NSString *monthDayDateFormatString = [NSDateFormatter dateFormatFromTemplate:@"MMMd" options:0 locale:[NSLocale currentLocale]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:monthDayDateFormatString];
    NSString *theDateString = [dateFormatter stringFromDate:self];
    return theDateString;
}
- (NSInteger)secondsAfterMidnightInteger {
    NSCalendar *aCalendar = [NSCalendar currentCalendar];
    NSUInteger aTimeCalendarUnit = (NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit);
    NSDateComponents *aTimeDateComponents = [aCalendar components:aTimeCalendarUnit fromDate:self];
    // 1 h = 60 min * 60 s / min. 1 min = 60 s.
    NSInteger theSecondsAfterMidnightInteger = aTimeDateComponents.hour * 60 * 60 + aTimeDateComponents.minute * 60 + aTimeDateComponents.second;
    return theSecondsAfterMidnightInteger;
}
@end
