<template>
  <div style="width: 100%">
    <div
      v-for="(i, currentInterval) in (((workingHours.end - workingHours.start) / ordinateAxisHoursInterval)) + 1"
      :key="currentInterval"
      :style="{top: scheduleGetHeightFromDate(currentInterval, scheduleHeight, ordinateAxisHoursInterval)}"
      class="line Ckdulzlinevertical"
    />
  </div>
</template>

<script>
export default {
  props: {
    workingHours: {
      type: Object,
      default () { return { start: 6, end: 20 } }
    },
    scheduleHeight: {
      type: Number,
      required: true
    },
    ordinateAxisHoursInterval: {
      type: Number,
      default: 2
    },
    ordinateAxisMinutesInterval: { // unused
      type: Number,
      default: 0
    }
  },
  data () {
    return {
      offset: 0 // px
    }
  },
  methods: {
    scheduleGetHeightFromDate (currentInterval, scheduleHeight, ordinateAxisHoursInterval) { // à fusionner
      const unit = scheduleHeight / (this.workingHours.end - this.workingHours.start)
      const top = (unit * currentInterval * ordinateAxisHoursInterval)
      return top + 'px'
    }

  }
}
</script>

<style scoped>
.line {
  position: absolute;
  width: 100%;
  z-index: 9;
}

</style>
