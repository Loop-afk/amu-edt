
let date = null

//  used to avoid a nuxt lifecycle hook bug (all are executed when navigate through nuxt link)

export function getReferenceDate () {
  if (date == null) {
    date = new Date()
    return date
  }
  return date
}

export function setReferenceDate (ndate) {
  date = ndate
  return date
}

/*
 let cndate = getComparableFromDate(ndate)
  if (compareComparableDate(cndate, cdate)) { return date }
  date = ndate
  cdate = cndate
  return date
  */
