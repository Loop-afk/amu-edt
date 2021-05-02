<template>
  <div>
    <!--((workingHours.end - workingHours.start) / ordinateAxisHoursInterval) -->
    <div
      v-for="interval in 12"
      :key="interval"
    >
      {{ interval }}
    </div>
  </div>
</template>

<script>
export default {
  props: {
    workingHours: {
      type: Object,
      default () { return { start: 6, end: 22 } }
    },
    scheduleHeight: {
      type: Number,
      required: true
    },
    ordinateAxisHoursInterval: {
      type: Number,
      default: 2
    },
    ordinateAxisMinutesInterval: {
      type: Number,
      default: 0 // unused
    }
  },
  methods: {
    scheduleGetHeightFromDate (course) {
      const unit = this.scheduleHeight / (this.workingHours.end - this.workingHours.start)
      const height = (unit * (course.end.hours - course.start.hours) + (unit * (course.end.minutes - course.start.minutes) / 60))
      return height + 'px'
    }
  }
}
</script>

<style>

</style>
