<template>
  <div>
    <div>{{ hello }}</div>
    <div v-for="day in scheduleSettingsGetWeekDays()" :key="day.id">
      {{ day.id }} - {{ day.dayString }} - {{ day.isToday }}
    </div>
  </div>
</template>

<script>
export default {
  props: {
    scheduleSettingsDate: {
      type: Date,
      required: true
    }
  },
  data () {
    return {
      hello: 'hello world'
    }
  },
  mounted () {
  },
  methods: {
    capitalizeFirstLetter (word) {
      return word.charAt(0).toUpperCase() + word.slice(1)
    },
    addDays (date, days) { // pris sur internet
      const copy = new Date(Number(date))
      copy.setDate(date.getDate() + days)
      return copy
    },
    scheduleSettingsGetWeekDays () {
      const dayWeek = []
      const currentDate = this.addDays(this.scheduleSettingsDate, -1 * this.scheduleSettingsDate.getDay() + 1)
      for (const dayWeekKey of Array(7).keys()) {
        const tempDate = this.addDays(currentDate, dayWeekKey)
        dayWeek.push({
          id: dayWeekKey,
          dayString: this.capitalizeFirstLetter(
            tempDate.toLocaleDateString('fr-fr', { weekday: 'long' })),
          isToday: (this.scheduleSettingsDate.getDay() - 1 === dayWeekKey)
        })
      }
      return dayWeek
    }
  }
}
</script>
