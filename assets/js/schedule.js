import { getComparableFromDate, compareComparableDate } from './comparableDate'
import { getInputFormatedDate } from './formatedDate'

const schedule = []
export const scheduleGetAll = function () {
  return schedule
}

export const scheduleGet = function (weekDays, scheduleDisplayedGroups) {
  const dayFiltered = schedule.filter(course => weekDays.some(date => compareComparableDate(course.date, getComparableFromDate(date))))
  const groupFiltered = dayFiltered.filter(course => scheduleDisplayedGroups.includes(course.groups.id) === true)
  return groupFiltered
}

export const schedulePush = function (array) {
  if (array === undefined) { return }
  for (const el of array) { schedule.push(el) }
}

export const schedulePrepareRequest = function (weekDays, scheduleDisplayedGroups) {
  weekDays = weekDays.filter(day => searchInSchedule(getComparableFromDate(day)) === false)
  if (weekDays.length === 0) { return null }
  const interval = getIntervalFromWeekDays(weekDays)
  const request = 'http://192.168.1.29:8000/affichage/?from=' + getInputFormatedDate(interval.start) + '&to=' + getInputFormatedDate(interval.end)
  console.log("[AMU'EDT log] Sending to server =>", request)
  return request
}

const getIntervalFromWeekDays = function (weekDays) {
  console.log(weekDays)
  return { start: weekDays[0], end: weekDays[weekDays.length - 1] }
}

const searchInSchedule = function (comparableDate) {
  for (const course of schedule) {
    if (compareComparableDate(comparableDate, course.date)) { return true }
  }
  return false
}
