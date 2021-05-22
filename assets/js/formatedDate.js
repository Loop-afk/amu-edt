export function getFormatedUnit (minutes) {
  if (minutes < 10) { return '0' + minutes }
  return minutes
}

export function getFormatedHoursMinutes (courseDate) {
  return courseDate.hours + 'h' + getFormatedUnit(courseDate.minutes)
}

export function getReFormatedDate (date) {
  return getFormatedUnit(date.day) + '/' + getFormatedUnit(date.month) + '/' + date.year
}

export function getInputFormatedDate (date) {
  return date.getFullYear() + '-' + getFormatedUnit(date.getMonth() + 1) + '-' + getFormatedUnit(date.getDate())
}

export function getInputFormatedDateFromObject (date) {
  return date.year + '-' + getFormatedUnit(date.month) + '-' + getFormatedUnit(date.day)
}

export function getInputFormatedCustomTime (time) {
  return getFormatedUnit(time.hours) + ':' + getFormatedUnit(time.minutes)
}
