export default function (currentInterval, scheduleHeight, ordinateAxisHoursInterval, workingHours) {
  const unit = scheduleHeight / (workingHours.end - workingHours.start)
  const top = (unit * currentInterval * ordinateAxisHoursInterval)
  return top + 'px'
}
