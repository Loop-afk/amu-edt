let weekDays = null
let date = null

export function getWeekDays (scheduleSettingsDate) {
  if (date === null) {
    date = scheduleSettingsDate
    return weekDays
  }
  if (date === scheduleSettingsDate) {
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
