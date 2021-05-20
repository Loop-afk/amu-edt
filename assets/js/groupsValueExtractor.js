export default function (groups) {
  const extract = []
  for (const group of groups) {
    extract.push(Number(group.value))
  }
  return extract
}
