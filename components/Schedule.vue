<template>
  <div>
    <div>aaa</div>
    <div>bbb</div>
    <div>{{ scheduleSettingsDate.getDay() }} {{ hello }}</div>
  </div>
</template>

<script>
export default {
  props: {
    scheduleSettingsDate: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      hello: 'world'
    }
  },
  mounted () {
  },
  methods: {
    scheduleSettingsGetWeekDays () {
      const dayWeek = []
      dayWeek.push('monday')
      dayWeek.push('thuesday')
      dayWeek.push('thursday')
      return dayWeek
    }
  }
}
</script>
