<template>
  <div style="width: 100%">
    <div
      v-for="(i, currentInterval) in (((workingHours.end - workingHours.start) / ordinateAxisHoursInterval)) + 1"
      :key="currentInterval"
      :style="{top: scheduleGetHeightFromDate(currentInterval, scheduleHeight, ordinateAxisHoursInterval, workingHours)}"
      class="line clineHorizontal"
    />
  </div>
</template>

<script>
import scheduleGetHeightFromDate from '~/assets/js/scheduleGetHeightFromDate.js'
export default {
  props: {
    workingHours: {
      type: Object,
      required: true
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
    }
  },
  methods: {
    scheduleGetHeightFromDate (currentInterval, scheduleHeight, ordinateAxisHoursInterval, workingHours) {
      return scheduleGetHeightFromDate(currentInterval, scheduleHeight, ordinateAxisHoursInterval, workingHours)
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
