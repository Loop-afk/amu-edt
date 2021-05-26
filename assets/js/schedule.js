import { getComparableFromDate, compareComparableDate } from './comparableDate'
import { getInputFormatedDate } from './formatedDate'

let schedule = []
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
  for (const el of array) { if (!schedule.find(({ id }) => id === el.id)) { schedule.push(el) } } // n'est pas adapté à la modification
}

export const schedulePrepareRequest = function (weekDays, scheduleDisplayedGroups, force) {
  scheduleGet(weekDays, scheduleDisplayedGroups)
  if (!force) { weekDays = weekDays.filter(day => searchInSchedule(getComparableFromDate(day)) === false) } else { schedule = [] }
  if (weekDays.length === 0) { return null }
  const interval = getIntervalFromWeekDays(weekDays)
  const request = 'http://localhost:8000/affichage/' + '?from=' + getInputFormatedDate(interval.start) + '&to=' + getInputFormatedDate(interval.end)
  console.log("[AMU'EDT log] Sending to server =>", request)
  return request
}

const getIntervalFromWeekDays = function (weekDays) {
  return { start: weekDays[0], end: weekDays[weekDays.length - 1] }
}

const searchInSchedule = function (comparableDate) {
  for (const course of schedule) {
    if (compareComparableDate(comparableDate, course.date)) { return true }
  }
  return false
}
