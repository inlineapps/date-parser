words =
  at: '(?:在|於|@|要在)'
  zero: '(?:零|０|0)'
  one: '(?:一|１|1)'
  two: '(?:二|兩|２|2)'
  three: '(?:三|３|3)'
  four: '(?:四|４|4)'
  five: '(?:五|５|5)'
  six: '(?:六|６|6)'
  seven: '(?:七|７|7)'
  sun: '(?:日|天)'
  eight: '(?:八|８|8)'
  nine: '(?:九|９|9)'
  ten: '十'
  half: '半'
  end: '末'
  dot: '(?:\.|點|:|：)'
  hour: '(?:時|小時|點|:|：)'
  minute: '(?:分|分鐘|:|：)'
  second: '秒'
  morning: '(?:早|早上|早晨|am|AM)'
  noon: '(?:中午)'
  afternoon: '(?:下午|午後|pm|PM)'
  night: '(?:晚|晚上|晚間|夜晚|夜間)'
  midnight: '(?:午夜|半夜|凌晨)'
  after: '後'
  today: '(?:今|今天|今日)'
  tomorrow: '(?:明|明天|明日)'
  acquired: '(?:後天|後日)'
  yesterday: '(?:昨天|昨日)'
  the_day_before_yesterday: '(?:前天|前日)'
  this: '(?:這|這個|今)'
  next: '(?:下|下個|明)'
  previous: '(?:上|上個|去|昨)'
  week: '(?:禮拜|星期|週|周)'
  year: '(?:年|/|-)'
  year_relative: '(?:今年|去年|明年)'
  month: '(?:月|/|-)'
  month_relative: '(?:這個月|上個月|下個月)'
  day: '(?:日|號|/|-)'
  to: '(?:到|－|-|~)'
  event_prefix: '(?:有|舉辦|舉行|要|的|，| )'
  event_postfix: '(?:在|，| )'
  interjection: '(?:個|的|，| )'
  unit: '(?:個)'

words.numbers = "(?:#{words.zero}|#{words.one}|#{words.two}|#{words.three}|#{words.four}|#{words.five}|#{words.six}|#{words.seven}|#{words.eight}|#{words.nine}|#{words.ten}|#{words.half}|#{words.unit})"
words.zero_to_nine = "(?:#{words.zero}|#{words.one}|#{words.two}|#{words.three}|#{words.four}|#{words.five}|#{words.six}|#{words.seven}|#{words.eight}|#{words.nine})"
words.am = "(?:#{words.midnight}|#{words.morning})"
words.pm = "(?:#{words.noon}|#{words.afternoon}|#{words.night})"
words.this_previous_next = "(?:#{words.this}|#{words.previous}|#{words.next})"
words.dayPeriods = "(?:#{words.morning}|#{words.noon}|#{words.afternoon}|#{words.night}|#{words.midnight})"
words.time = "(?:#{words.numbers}+#{words.hour}(?:#{words.numbers}+)?(?:#{words.minute})?(?:#{words.numbers}+)?(?:#{words.second})?)"
words.like_time = "(?:#{words.numbers}+(?:#{words.numbers}|#{words.hour}|#{words.minute}|#{words.second}){1,12})"
words.dayTime = "(?:(?:#{words.dayPeriods}?#{words.interjection}?#{words.like_time}) ?#{words.dayPeriods}?|#{words.dayPeriods})"
words.year_month_day = "(?:#{words.year}|#{words.month}|#{words.day}|#{words.year_relative}|#{words.month_relative})"
words.date = "(?:(?:(?:(?:#{words.numbers}{1,4}|#{words.this_previous_next}) ?#{words.year})? ?(?:#{words.numbers}{1,3}|#{words.this_previous_next}) ?#{words.month})? ?#{words.numbers}{1,3} ?#{words.day}?)"
words.like_date = "(?:(?:#{words.numbers}|#{words.year_month_day}){1,12}#{words.year_month_day}#{words.numbers}{0,3})"
words.weekdays = "(?:#{words.zero}|#{words.one}|#{words.two}|#{words.three}|#{words.four}|#{words.five}|#{words.six}|#{words.seven}|#{words.sun}|#{words.end})"
words.weekExpression = "(?:#{words.this_previous_next}?#{words.week}#{words.weekdays})"
words.dateExpression = "(?:#{words.like_date}|#{words.weekExpression}|#{words.today}|#{words.tomorrow}|#{words.acquired}|#{words.yesterday}|#{words.the_day_before_yesterday})"
words.separators = "(?:#{words.event_prefix}|#{words.event_postfix})"

number2integer = (number) ->
  return null if not number
  if match = number.match RegExp("(#{words.zero_to_nine})(#{words.zero_to_nine})(#{words.zero_to_nine})(#{words.zero_to_nine})")
    return number2integer(match[1])*1000 + number2integer(match[2])*100 + number2integer(match[3])*10 + number2integer(match[4])
  else if match = number.match RegExp("(#{words.zero_to_nine})(#{words.ten})?(#{words.zero_to_nine})#{words.unit}?")
    if match[1] == words.ten
      return number2integer(match[3]) + 10
    else
      n = number2integer(match[3])
      n = 0 if n >= 10
      return number2integer(match[1])*10 + n
  else if match = number.match RegExp("(#{words.numbers}+)#{words.unit}#{words.half}")
    return number2integer(match[1]) + 0.5
  else if number.match RegExp(words.half)
    return 0.5
  else if number.match RegExp(words.zero)
    return 0
  else if number.match RegExp(words.one)
    return 1
  else if number.match RegExp(words.two)
    return 2
  else if number.match RegExp(words.three)
    return 3
  else if number.match RegExp(words.four)
    return 4
  else if number.match RegExp(words.five)
    return 5
  else if number.match RegExp(words.six)
    return 6
  else if number.match RegExp(words.seven)
    return 7
  else if number.match RegExp(words.sun)
    return 7
  else if number.match RegExp(words.eight)
    return 8
  else if number.match RegExp(words.nine)
    return 9
  else if number.match RegExp(words.ten)
    return 10
  else
    return null

time2object = (time) ->
  return null if not time
  if match = time.match RegExp("(?:(#{words.numbers}+)#{words.hour}(#{words.numbers}*)(?:#{words.minute})?(#{words.numbers}*)(?:#{words.second})?)")
    hour = number2integer(match[1]) or 0
    minute = number2integer(match[2]) or 0
    second = number2integer(match[3]) or 0
    if hour == 30
      hour = 0
      minute += 30
    if (f = hour % 1) > 0
      hour -= f
      minute += 30
    while second > 60
      second -= 60
      minute += 1
    while minute > 60
      minute -= 60
      hour += 1
    return {
      hour: hour,
      minute: minute,
      second: second
    }
  else
    return null

dayTime2date = (daytime, date) ->
  return null if not daytime
  if match = daytime.match RegExp("(?:(?:(#{words.dayPeriods})?#{words.interjection}?(#{words.time}) ?(#{words.dayPeriods})?)|(#{words.dayPeriods}))")
    if period = match[4]
      date = date or new Date()
      date.endTime = date?.endTime or (date and new Date(date?.getTime())) or new Date()
      date.setMinutes(0)
      date.setSeconds(0)
      date.endTime.setMinutes(0)
      date.endTime.setSeconds(0)
      if period.match RegExp(words.morning)
        date.setHours(9)
        date.endTime.setHours(11)
      else if period.match RegExp(words.noon)
        date.setHours(12)
        date.endTime.setHours(13)
      else if period.match RegExp(words.afternoon)
        date.setHours(14)
        date.endTime.setHours(16)
      else if period.match RegExp(words.night)
        date.setHours(18)
        date.endTime.setHours(20)
      else if period.match RegExp(words.midnight)
        date.setHours(0)
        date.endTime.setHours(4)
      return date
    else
      period = match[1] or match[3] or ''
      time = time2object(match[2])
      return null if not time
      time.hour += 12 if period.match(RegExp(words.pm)) and time.hour < 12
      date = (date and new Date(date?.getTime())) || new Date()
      if time.hour < 12 and not period
        time.hour += 12 if time.hour > (date.getHours() - 12) and time.hour < (date.getHours())
      date.setHours(time.hour)
      date.setMinutes(time.minute or 0)
      date.setSeconds(time.second or 0)
      return date
  else
    return null

date2object = (date) ->
  return null if not date
  if match = date.match RegExp("(?:(?:(?:(#{words.numbers}+|#{words.this_previous_next}) ?#{words.year})? ?(#{words.numbers}+||#{words.interjection}#{words.this_previous_next}) ?#{words.month})? ?(?:(#{words.numbers}+) ?#{words.day}?))")
    now = new Date()
    year = number2integer(match[1]) or null
    if year and year < 100
      now.getUTCFullYear()
      c = parseInt(now.getUTCFullYear()/100)*100
      year = year + c
    month = number2integer(match[2]) or null
    day = number2integer(match[3]) or null
    if match[1]?.match RegExp(words.this)
      year = now.getUTCFullYear()
    else if match[1]?.match RegExp(words.previous)
      year = now.getUTCFullYear() - 1
    else if match[1]?.match RegExp(words.next)
      year = now.getUTCFullYear() + 1
    if match[2]?.match RegExp(words.this)
      year = now.getMonth() + 1
    else if match[2]?.match RegExp(words.previous)
      year = now.getMonth()
    else if match[2]?.match RegExp(words.next)
      year = now.getMonth() + 2
    return {
      year: year,
      month: month,
      day: day
    }
  else
    return null

dateExpression2date = (dateExp) ->
  return null if not dateExp
  date = new Date()
  date.setHours(0)
  date.setMinutes(0)
  date.setSeconds(0)
  if match = dateExp.match RegExp(words.today)
    return date
  else if match = dateExp.match RegExp(words.tomorrow)
    date.setDate date.getDate() + 1
    return date
  else if match = dateExp.match RegExp(words.acquired)
    date.setDate date.getDate() + 2
    return date
  else if match = dateExp.match RegExp(words.yesterday)
    date.setDate date.getDate() - 1
    return date
  else if match = dateExp.match RegExp(words.the_day_before_yesterday)
    date.setDate date.getDate() - 2
    return date
  else if match = dateExp.match RegExp("(#{words.this_previous_next})?#{words.week}(#{words.weekdays})")
    if match[1]?.match RegExp(words.previous)
      date.setDate date.getDate() - 7
    else if match[1]?.match RegExp(words.next)
      date.setDate date.getDate() + 7
    day = number2integer(match[2])
    if match[2].match RegExp(words.end)
      day = 6
    day = 0 if day >= 7
    diff = day - date.getDay()
    date.setDate date.getDate() + diff
    if match[2].match RegExp(words.end)
      date.endTime = new Date(date?.getTime())
      date.endTime.setDate date.getDate() + 1
    return date
  else if match = dateExp.match RegExp(words.like_date)
    theDate = date2object(match[0])
    return null unless theDate
    date.setDate(theDate.day) if theDate.day
    date.setMonth(theDate.month - 1) if theDate.month
    date.setYear(theDate.year) if theDate.year
    return date
  else return null

expressions = []

# 「<事件> 時間後 <在...> <事件>」
expressions.push (text) ->
  if match = text.match RegExp("^(?:([^#{words.separators}]+) ?#{words.event_postfix} ?)?(#{words.time})#{words.after} ?(?:#{words.at} ?([^#{words.separators}]+))? ?(?:#{words.event_prefix}#{words.interjection}?([^#{words.separators}]+))?$")
    time = time2object(match[2])
    location = match[3]
    eventName = match[1] or match[4]
    date = new Date()
    date.setHours date.getHours() + time.hour
    date.setMinutes date.getMinutes() + time.minute
    date.setSeconds date.getSeconds() + time.second
    date.location = location if location
    date.eventName = eventName if eventName
    return date

# 「<事件> 日期 <時間> 到 日期 <時間> <在...> <事件>」
expressions.push (text) ->
  if match = text.match RegExp("^(?:([^#{words.separators}]+) ?#{words.event_postfix})? ?(#{words.dateExpression}) ?(#{words.dayTime})? ?(?:#{words.to} ?(#{words.dateExpression}) ?(#{words.dayTime})? ?) ?(?:#{words.at} ?([^#{words.separators}]+))? ?(?:#{words.event_prefix}#{words.interjection}?([^#{words.separators}]+))?$")
    date = dateExpression2date(match[2]) or new Date()
    date = dayTime2date(match[3], date) if match[3]
    if not match[3] and not match[5]
      date.fullDay = true
    endTime = dateExpression2date(match[4])
    if match[5] and endTime
      endTime = dayTime2date(match[5], endTime)
    location = match[6]
    eventName = match[1] or match[7]
    date.location = location if location
    date.eventName = eventName if eventName
    date.endTime = endTime if endTime
    if date.endTime and not match[5]
      date.endTime.setHours(23)
      date.endTime.setMinutes(59)
      date.endTime.setSeconds(59)
    return date

# 「<事件> 日期 時間 <到 時間> <在...> <事件>」
expressions.push (text) ->
  if match = text.match RegExp("^(?:([^#{words.separators}]+) ?#{words.event_postfix})? ?(?:(#{words.dateExpression})) ?(#{words.dayTime}) ?(?:#{words.to} ?(#{words.dayTime}) ?)? ?(?:#{words.at} ?([^#{words.separators}]+))? ?(?:#{words.event_prefix}#{words.interjection}?([^#{words.separators}]+))?$")
    date = dateExpression2date(match[2]) or new Date()
    date = dayTime2date(match[3], date) if match[3]
    endTime = dayTime2date(match[4], date)
    location = match[5]
    eventName = match[1] or match[6]
    date.location = location if location
    date.eventName = eventName if eventName
    date.endTime = endTime if endTime
    return date

# 「<事件> 時間 <到 時間> <在...> <事件>」
expressions.push (text) ->
  if match = text.match RegExp("^(?:([^#{words.separators}]+) ?#{words.event_postfix})? ?(#{words.dayTime}) ?(?:#{words.to} ?(#{words.dayTime}) ?)? ?(?:#{words.at} ?([^#{words.separators}]+))? ?(?:#{words.event_prefix}#{words.interjection}?([^#{words.separators}]+))?$")
    date = dayTime2date(match[2]) if match[2]
    endTime = dayTime2date(match[3], date)
    location = match[4]
    eventName = match[1] or match[5]
    date.location = location if location
    date.eventName = eventName if eventName
    date.endTime = endTime if endTime
    return date

# 「<事件> 日期 <時間> <到 日期 <時間>> <在...> <事件>」
expressions.push (text) ->
  if match = text.match RegExp("^(?:([^#{words.separators}]+) ?#{words.event_postfix})? ?(#{words.dateExpression}) ?(#{words.dayTime})? ?(?:#{words.to} ? (#{words.dateExpression}) ?(#{words.dayTime})? ?)? ?(?:#{words.at} ?([^#{words.separators}]+))? ?(?:#{words.event_prefix}#{words.interjection}?([^#{words.separators}]+))?$")
    date = dateExpression2date(match[2]) or new Date()
    time = dayTime2date(match[3], date) if match[3]
    if not match[3] and not match[5]
      date.fullDay = true
    endTime = dateExpression2date(match[5])
    if match[5] and endTime
      endTime = dayTime2date(match[5], endTime)
    location = match[6]
    eventName = match[1] or match[7]
    date.location = location if location
    date.eventName = eventName if eventName
    date.endTime = endTime if endTime
    if date.endTime and not match[5]
      date.endTime.setHours(23)
      date.endTime.setMinutes(59)
      date.endTime.setSeconds(59)
    return date

module.exports =
  words: words
  expressions: expressions
  number2integer: number2integer
  time2object: time2object
  dayTime2date: dayTime2date
  date2object: date2object
  dateExpression2date: dateExpression2date
  testStrings: ['明天晚上到下禮拜六早上要開會', '10月10號 早上 10:00 ~ 下午 4:00', '十月十號']
