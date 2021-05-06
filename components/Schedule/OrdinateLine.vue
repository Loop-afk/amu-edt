<template>
  <div style="width: 100%">
    <div
      v-for="(i, currentInterval) in (((workingHours.end - workingHours.start) / ordinateAxisHoursInterval)) + 1"
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
  data () {
    return {
      offset: 0 // px
    }
  },
  methods: {
    scheduleGetHeightFromDate (currentInterval) {
      const unit = this.scheduleHeight / (this.workingHours.end - this.workingHours.start)
      const top = (unit * currentInterval * this.ordinateAxisHoursInterval + unit * this.ordinateAxisHoursInterval) + this.offset
      return top + 'px'
    }
  }
}
</script>

<style scoped>
.line {
  position: absolute;
  width: 100%;
  box-shadow: 0px 0px 0px 1px rgb(50, 27, 184);
  z-index: 9;
}

</style>
