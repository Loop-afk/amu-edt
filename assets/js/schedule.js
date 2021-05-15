import { getComparableFromDate, compareComparableDate } from './comparableDate'

const schedule = []
export const scheduleGetAll = function () {
  return schedule
}

export const scheduleGet = function (weekDays, scheduleDisplayedGroups) {
  const dayFiltered = schedule.filter(course => weekDays.some(day => compareComparableDate(course.day, getComparableFromDate(day))))
  return dayFiltered.filter(course => scheduleDisplayedGroups.some(eachGroup => course.groups.some(courseAllowed => courseAllowed.id === eachGroup)) === true)
}

export const schedulePush = function (array) {
  for (const el of array) { schedule.push(el) }
}
