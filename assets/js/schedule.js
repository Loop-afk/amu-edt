let schedule = null

//  used to avoid a nuxt lifecycle hook bug (all are executed when navigate through nuxt link)

export function getSchedule () {
  return schedule
}

export function setSchedule (nschedule) {
  schedule = nschedule
}
