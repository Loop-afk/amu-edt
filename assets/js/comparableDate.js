export function getComparableFromDate (date) {
  return { day: date.getDate(), month: date.getMonth() + 1, year: date.getFullYear() }
}

export function compareComparableDate (c1, c2) {
  /*
  console.log(c1.day, c2.day)
  console.log(c1.month, c2.month)
  console.log(c1.year, c2.year)
  console.log('(----)')
  */
  return c1.day === c2.day && c1.month === c2.month && c1.year === c2.year
}
