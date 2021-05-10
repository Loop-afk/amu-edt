import { getComparableFromDate, compareComparableDate } from '~/assets/js/comparableDate.js'

let date = null

//  todo not working

export function getReferenceDate (ndate) {
  if (compareComparableDate(getComparableFromDate(new Date()), getComparableFromDate(ndate))) { return ndate }
  date = ndate
  return date
}
