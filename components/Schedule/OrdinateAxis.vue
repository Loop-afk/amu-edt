<template>
  <div class="ordinateAxis">
    <div
      v-for="(i, currentInterval) in (((workingHours.end - workingHours.start) / ordinateAxisHoursInterval)) + 1"
      :key="currentInterval"
      :style="{top: scheduleGetHeightFromDate(currentInterval, scheduleHeight, ordinateAxisHoursInterval)}"
      class="hourInterval textDark"
    >
      {{ currentInterval * ordinateAxisHoursInterval + workingHours.start }}
    </div>
  </div>
</template>

<script>
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
  methods: {
    scheduleGetHeightFromDate (currentInterval, scheduleHeight, ordinateAxisHoursInterval) {
      const unit = scheduleHeight / (this.workingHours.end - this.workingHours.start)
      const top = (unit * currentInterval * ordinateAxisHoursInterval)
      return top + 'px'
    }
  }
}
</script>

<style scoped>
.hourInterval {
  position: absolute;
}

.ordinateAxis {
  position: relative;
}

</style>
