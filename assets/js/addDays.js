export default function addDays (date, days) { // prise sur stackoverflow //todo à mettre dans un fichier js à importer
  const copy = new Date(Number(date))
  copy.setDate(date.getDate() + days)
  return copy
}
