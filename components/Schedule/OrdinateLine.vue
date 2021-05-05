<template>
  <div style="width: 100%">
    <div
      v-for="(i, currentInterval) in (((workingHours.end - workingHours.start) / ordinateAxisHoursInterval))"
      :key="currentInterval"
      :style="{top: scheduleGetHeightFromDate(currentInterval)}"
      class="line"
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
  methods: {
    scheduleGetHeightFromDate (currentInterval) {
      const unit = this.scheduleHeight / (this.workingHours.end - this.workingHours.start)
      const top = (unit * currentInterval * this.ordinateAxisHoursInterval + unit * this.ordinateAxisHoursInterval)
      return top + 'px'
    }
  }
}
</script>

<style>
.line {
  position: absolute;
  width: 100%;
  box-shadow: 0px 0px 0px 1px rgb(50, 27, 184);
}

</style>
