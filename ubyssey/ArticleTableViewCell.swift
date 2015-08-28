//
//  ArticleTableViewCell.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-06.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImageView: UIImageView!
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleTimeSince: UILabel!
    @IBOutlet weak var articlePublishedAt: UILabel!
    @IBOutlet weak var articleSection: UILabel!
    
    func setData(article: Article) {
        
        articleSection.text = article.section.uppercaseString
        
        articleTimeSince.font = UIFont(name: "LFTEtica-SemiBold", size: 10)
        articleSection.font = UIFont(name: "LFTEtica-SemiBold", size: 10)

        articleTitle.text = article.longHeadline
        articleTitle.font = UIFont(name: "LFTEtica-Book", size: 18)
        
        
        articleImageView.sd_setImageWithURL(NSURL(string: article.imageUrl))
        articleImageView.clipsToBounds = true

        // If article was published between the current time and midnight of
        // the current day, show "HH:mm a", else show "yyyy-MM-dd"
        if article.publishedAt.0 != nil && article.publishedAt.1 != nil {
            let currentDate = NSDate()
            let currentDateFormatter = NSDateFormatter()
            currentDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if getyyyyMMdd((currentDate, currentDateFormatter)) ==
                getyyyyMMdd((article.publishedAt.0!, article.publishedAt.1!)) {
                articlePublishedAt.text = getHHmm_a((article.publishedAt.0!, article.publishedAt.1!))
                if articlePublishedAt.text == nil {
                    articlePublishedAt.text = ""
                }
            } else {
                let testStr = article.publishedAt.1!.stringFromDate(article.publishedAt.0!)
                articlePublishedAt.text = getyyyyMMdd((article.publishedAt.0!, article.publishedAt.1!))
                if articlePublishedAt.text == nil {
                    articlePublishedAt.text = ""
                }
            }
            if articlePublishedAt.text == nil {
                articlePublishedAt.text = ""
            }
        } else {
            articlePublishedAt.text = ""
        }

        // If article was published between the current time and minute of
        // the current day, show "x second(s)"
        // else if article was published between the current time and hour of
        // the current day, show "x minute(s)"
        // else if article was published between the current time and the
        // current day, show "x hour(s)"
        // else if article was published between the current time and year of
        // the current year, show "x day(s)"
        // else show "x year(s)"
        if article.publishedAt.0 != nil && article.publishedAt.1 != nil {
            func yearsElapsed(since: (NSDate, NSDateFormatter)) -> Int? {
                let now = NSDate()
                let nowFormatter = NSDateFormatter()
                nowFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                var currentYear = nowFormatter.stringFromDate(now)
                // e.g. "1918-01-02T03:04:05-0000" -> "1918"
                currentYear.removeRange(advance(currentYear.startIndex, 4)..<advance(currentYear.endIndex, 0))

                var pastYear = since.1.stringFromDate(since.0)
                // e.g. "1918-01-02T03:04:05-0000" -> "1918"
                pastYear.removeRange(advance(pastYear.startIndex, 4)..<advance(pastYear.endIndex, 0))

                if let currentYearInt = currentYear.toInt() {
                    if let pastYearInt = pastYear.toInt() {
                        let delta = Int.subtractWithOverflow(currentYearInt, pastYearInt)
                        if delta.overflow {
                            println("WARNING: overflow in yearsElapsed(since)")
                        } else if delta.0 >= 0 {
                            return delta.0
                        }
                    }
                }
                return nil
            }

            func monthsElapsed(since: (NSDate, NSDateFormatter)) -> Int? {
                if yearsElapsed(since) == 0 {
                    let now = NSDate()
                    let nowFormatter = NSDateFormatter()
                    nowFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                    var currentMonth = nowFormatter.stringFromDate(now)
                    // e.g. "1918-01-02T03:04:05-0000" -> "01"
                    currentMonth.removeRange(advance(currentMonth.startIndex, 0)..<advance(currentMonth.startIndex, 5))
                    currentMonth.removeRange(advance(currentMonth.startIndex, 2)..<advance(currentMonth.endIndex, 0))

                    var pastMonth = since.1.stringFromDate(since.0)
                    // e.g. "1918-01-02T03:04:05-0000" -> "01"
                    pastMonth.removeRange(advance(pastMonth.startIndex, 0)..<advance(pastMonth.startIndex, 5))
                    pastMonth.removeRange(advance(pastMonth.startIndex, 2)..<advance(pastMonth.endIndex, 0))

                    if let currentMonthInt = currentMonth.toInt() {
                        if let pastMonthInt = pastMonth.toInt() {
                            let delta = Int.subtractWithOverflow(currentMonthInt, pastMonthInt)
                            if delta.overflow {
                                println("WARNING: overflow in monthsElapsed(since)")
                            } else if delta.0 >= 0 {
                                return delta.0
                            }
                        }
                    }
                }
                return nil
            }

            func daysElapsed(since: (NSDate, NSDateFormatter)) -> Int? {
                if yearsElapsed(since) == 0 && monthsElapsed(since) == 0 {
                    let now = NSDate()
                    let nowFormatter = NSDateFormatter()
                    nowFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                    var currentDay = nowFormatter.stringFromDate(now)
                    // e.g. "1918-01-02T03:04:05-0000" -> "02"
                    currentDay.removeRange(advance(currentDay.startIndex, 0)..<advance(currentDay.startIndex, 8))
                    currentDay.removeRange(advance(currentDay.startIndex, 2)..<advance(currentDay.endIndex, 0))

                    var pastDay = since.1.stringFromDate(since.0)
                    // e.g. "1918-01-02T03:04:05-0000" -> "02"
                    pastDay.removeRange(advance(pastDay.startIndex, 0)..<advance(pastDay.startIndex, 8))
                    pastDay.removeRange(advance(pastDay.startIndex, 2)..<advance(pastDay.endIndex, 0))

                    if let currentDayInt = currentDay.toInt() {
                        if let pastDayInt = pastDay.toInt() {
                            let delta = Int.subtractWithOverflow(currentDayInt, pastDayInt)
                            if delta.overflow {
                                println("WARNING: overflow in daysElapsed(since)")
                            } else if delta.0 >= 0 {
                                return delta.0
                            }
                        }
                    }
                }
                return nil
            }

            func hoursElapsed(since: (NSDate, NSDateFormatter)) -> Int? {
                if yearsElapsed(since) == 0 && monthsElapsed(since) == 0 && daysElapsed(since) == 0 {
                    let now = NSDate()
                    let nowFormatter = NSDateFormatter()
                    nowFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                    var currentHour = nowFormatter.stringFromDate(now)
                    // e.g. "1918-01-02T03:04:05-0000" -> "03"
                    currentHour.removeRange(advance(currentHour.startIndex, 0)..<advance(currentHour.startIndex, 11))
                    currentHour.removeRange(advance(currentHour.startIndex, 2)..<advance(currentHour.endIndex, 0))

                    var pastHour = since.1.stringFromDate(since.0)
                    // e.g. "1918-01-02T03:04:05-0000" -> "03"
                    pastHour.removeRange(advance(pastHour.startIndex, 0)..<advance(pastHour.startIndex, 11))
                    pastHour.removeRange(advance(pastHour.startIndex, 2)..<advance(pastHour.endIndex, 0))

                    if let currentHourInt = currentHour.toInt() {
                        if let pastHourInt = pastHour.toInt() {
                            let delta = Int.subtractWithOverflow(currentHourInt, pastHourInt)
                            if delta.overflow {
                                println("WARNING: overflow in hoursElapsed(since)")
                            } else if delta.0 >= 0 {
                                return delta.0
                            }
                        }
                    }
                }
                return nil
            }

            func minutesElapsed(since: (NSDate, NSDateFormatter)) -> Int? {
                if yearsElapsed(since) == 0 && monthsElapsed(since) == 0 && daysElapsed(since) == 0 && hoursElapsed(since) == 0 {
                    let now = NSDate()
                    let nowFormatter = NSDateFormatter()
                    nowFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                    var currentMinute = nowFormatter.stringFromDate(now)
                    // e.g. "1918-01-02T03:04:05-0000" -> "04"
                    currentMinute.removeRange(advance(currentMinute.startIndex, 0)..<advance(currentMinute.startIndex, 14))
                    currentMinute.removeRange(advance(currentMinute.startIndex, 2)..<advance(currentMinute.endIndex, 0))

                    var pastMinute = since.1.stringFromDate(since.0)
                    // e.g. "1918-01-02T03:04:05-0000" -> "04"
                    pastMinute.removeRange(advance(pastMinute.startIndex, 0)..<advance(pastMinute.startIndex, 14))
                    pastMinute.removeRange(advance(pastMinute.startIndex, 2)..<advance(pastMinute.endIndex, 0))

                    if let currentMinuteInt = currentMinute.toInt() {
                        if let pastMinuteInt = pastMinute.toInt() {
                            let delta = Int.subtractWithOverflow(currentMinuteInt, pastMinuteInt)
                            if delta.overflow {
                                println("WARNING: overflow in minutesElapsed(since)")
                            } else if delta.0 >= 0 {
                                return delta.0
                            }
                        }
                    }
                }
                return nil
            }

            func secondsElapsed(since: (NSDate, NSDateFormatter)) -> Int? {
                if yearsElapsed(since) == 0 && monthsElapsed(since) == 0 && daysElapsed(since) == 0 && hoursElapsed(since) == 0 && minutesElapsed(since) == 0 {
                    let now = NSDate()
                    let nowFormatter = NSDateFormatter()
                    nowFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                    var currentSecond = nowFormatter.stringFromDate(now)
                    // e.g. "1918-01-02T03:04:05-0000" -> "05"
                    currentSecond.removeRange(advance(currentSecond.startIndex, 0)..<advance(currentSecond.startIndex, 17))
                    currentSecond.removeRange(advance(currentSecond.startIndex, 2)..<advance(currentSecond.endIndex, 0))

                    var pastSecond = since.1.stringFromDate(since.0)
                    // e.g. "1918-01-02T03:04:05-0000" -> "05"
                    pastSecond.removeRange(advance(pastSecond.startIndex, 0)..<advance(pastSecond.startIndex, 17))
                    pastSecond.removeRange(advance(pastSecond.startIndex, 2)..<advance(pastSecond.endIndex, 0))

                    if let currentSecondInt = currentSecond.toInt() {
                        if let pastSecondInt = pastSecond.toInt() {
                            let delta = Int.subtractWithOverflow(currentSecondInt, pastSecondInt)
                            if delta.overflow {
                                println("WARNING: overflow in secondsElapsed(since)")
                            } else if delta.0 >= 0 {
                                return delta.0
                            }
                        }
                    }
                }
                return nil
            }

            if article.publishedAt.1!.dateFormat == "yyyy-MM-dd'T'HH:mm:ssZ" {
                if let t = yearsElapsed(article.publishedAt.0!, article.publishedAt.1!) {
                    if t > 1 {
                        articleTimeSince.text = String(t) + " years"
                    } else if t == 1 {
                        articleTimeSince.text = String(t) + " year"
                    } else if let t = monthsElapsed(article.publishedAt.0!, article.publishedAt.1!) {
                        if t > 1 {
                            articleTimeSince.text = String(t) + " months"
                        } else if t == 1 {
                            articleTimeSince.text = String(t) + " month"
                        } else if let t = daysElapsed(article.publishedAt.0!, article.publishedAt.1!) {
                            if t > 1 {
                                articleTimeSince.text = String(t) + " days"
                            } else if t == 1 {
                                articleTimeSince.text = String(t) + " day"
                            } else if let t = hoursElapsed(article.publishedAt.0!, article.publishedAt.1!) {
                                if t > 1 {
                                    articleTimeSince.text = String(t) + " hours"
                                } else if t == 1 {
                                    articleTimeSince.text = String(t) + " hour"
                                } else if let t = minutesElapsed(article.publishedAt.0!, article.publishedAt.1!) {
                                    if t > 1 {
                                        articleTimeSince.text = String(t) + " minutes"
                                    } else if t == 1 {
                                        articleTimeSince.text = String(t) + " minute"
                                    } else if let t = secondsElapsed(article.publishedAt.0!, article.publishedAt.1!) {
                                        if t > 1 {
                                            articleTimeSince.text = String(t) + " seconds"
                                        } else if t == 1 {
                                            articleTimeSince.text = String(t) + " second"
                                        } else {
                                            articleTimeSince.text = ""
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            articleTimeSince.text = ""
        }
    }

    private func getyyyyMMdd(publishedAt: (NSDate, NSDateFormatter))
            -> String? {
        if publishedAt.1.dateFormat == "yyyy-MM-dd'T'HH:mm:ssZ" {
            var dateString = publishedAt.1.stringFromDate(publishedAt.0)
            dateString.removeRange(advance(dateString.startIndex, 10)..<dateString.endIndex)
            return dateString
        }
        return nil
    }

    private func getHHmm_a(publishedAt: (NSDate, NSDateFormatter)) -> String? {
        if publishedAt.1.dateFormat == "yyyy-MM-dd'T'HH:mm:ssZ" {
            var dateString = publishedAt.1.stringFromDate(publishedAt.0)
            // e.g. "1918-01-02T03:04:05-0000" -> "03:04:05-0000"
            dateString.removeRange(advance(dateString.startIndex, 0)..<advance(dateString.startIndex, 11))
            // e.g. "03:04:05-0000" -> "03:04"
            dateString.removeRange(advance(dateString.startIndex, 5)..<advance(dateString.endIndex, 0))

            // e.g. "03:04" -> "3:04 AM"
            // e.g. "12:01" -> "12:01 PM"
            var dateHour = dateString
            dateHour.removeRange(advance(dateString.startIndex, 2)..<advance(dateString.endIndex, 0))
            if let hour = dateHour.toInt() {
                if hour > 12 {
                    // truncate leading hours
                    dateString.removeRange(advance(dateString.startIndex, 0)..<advance(dateString.startIndex, 2))
                    return String(hour - 12) + dateString + " PM"
                }
                else if hour == 12 {
                    return dateString + " PM"
                } else if hour >= 10 {
                    return dateString + " AM"
                } else {
                    // truncate leading 0
                    dateString.removeRange(advance(dateString.startIndex, 0)..<advance(dateString.startIndex, 1))
                    return dateString + " AM"
                }
            }
        }
        return nil
    }
}
