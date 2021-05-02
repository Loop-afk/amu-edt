export default function (date, days) { // prise sur stackoverflow
  const copy = new Date(Number(date))
  copy.setDate(date.getDate() + days)
  return copy
}
