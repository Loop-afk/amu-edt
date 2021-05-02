let targetId = -1

export function clearIdTarget () {
  targetId = -1
}

export function generateTargetId () {
  targetId += 1
  return targetId
}

export function getTargetId () {
  return targetId
}
