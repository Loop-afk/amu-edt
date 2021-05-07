import { getComparableFromDate, compareComparableDate } from '~/assets/js/comparableDate.js'

let weekDays = null
let date = null

export function getWeekDays (scheduleSettingsDate) {
  const scheduleSettingsDateComparable = getComparableFromDate(scheduleSettingsDate)
  if (date === null) {
    // console.log('start')
    date = scheduleSettingsDateComparable
    return weekDays
  }
  console.log('==>', date, scheduleSettingsDateComparable)
  if (compareComparableDate(date, scheduleSettingsDateComparable)) {
    // console.log('same date')
    return weekDays
  }
  // console.log('third')
  weekDays = null
  date = scheduleSettingsDate
  return weekDays
}

export function setWeekDays (newWeekDays) {
  weekDays = newWeekDays
}

export function lenWeekDays () {
  return weekDays.length
}
