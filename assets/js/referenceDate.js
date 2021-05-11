import addDays from '~/assets/js/addDays.js'

let date = null

//  used to avoid a nuxt lifecycle hook bug (all are executed when navigate through nuxt link)

export function getReferenceDate () {
  if (date == null) {
    date = addDays(new Date(), 1)
    return date
  }
  return date
}

export function setReferenceDate (ndate) {
  date = ndate
  return date
}
