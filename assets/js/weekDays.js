import { getComparableFromDate, compareComparableDate } from '~/assets/js/comparableDate.js'

let weekDays = null
let date = null

export function getWeekDays (scheduleSettingsDate, days) {
  const scheduleSettingsDateComparable = getComparableFromDate(scheduleSettingsDate)
  if (date === null) {
    date = scheduleSettingsDateComparable
    return weekDays
  }
  if (compareComparableDate(date, scheduleSettingsDateComparable) && weekDays.length === days) {
    return weekDays
  }
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
