<template>
  <div class="ordinateAxis">
    <div
      v-for="(i, currentInterval) in (((workingHours.end - workingHours.start) / ordinateAxisHoursInterval)) + 1"
      :key="currentInterval"
      :style="{top: scheduleGetHeightFromDate(currentInterval)}"
      class="hourInterval"
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
  methods: {
    scheduleGetHeightFromDate (currentInterval) {
      const unit = this.scheduleHeight / (this.workingHours.end - this.workingHours.start)
      const top = (unit * currentInterval * this.ordinateAxisHoursInterval)
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
  top: 0px;
}

</style>
