export function getComparableFromDate (date) {
  return { day: date.getDate(), month: date.getMonth() + 1, year: date.getFullYear() }
}

export function compareComparableDate (c1, c2) {
  return c1.day === c2.day && c1.month === c2.month && c1.year === c2.year
}
