import addDays from '~/assets/js/addDays.js'

let date = null

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
