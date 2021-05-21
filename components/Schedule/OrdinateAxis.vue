<template>
  <div class="ordinateAxis">
    <div
      v-for="(i, currentInterval) in (((workingHours.end - workingHours.start) / ordinateAxisHoursInterval)) + 1"
      :key="currentInterval"
      :style="{top: scheduleGetHeightFromDate(currentInterval, scheduleHeight, ordinateAxisHoursInterval, workingHours)}"
      class="hourInterval textDark"
    >
      {{ currentInterval * ordinateAxisHoursInterval + workingHours.start }}
    </div>
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
.hourInterval {
  position: absolute;
}

.ordinateAxis {
  position: relative;
}

</style>
