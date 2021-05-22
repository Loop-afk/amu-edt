import { getComparableFromDate, compareComparableDate } from './comparableDate'

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
  for (const el of array) { schedule.push(el) }
}
