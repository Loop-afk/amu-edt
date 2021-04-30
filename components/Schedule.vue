<template>
  <div>
    <div>{{ scheduleSettingsDate.getDay() }} {{ hello }}</div>
    <div v-for="day in scheduleSettingsGetWeekDays()" :key="day.id">
      {{ day.id }} - {{ day.day }} - {{ day.isToday }}
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
      hello: 'world',
      dayWeek: [
        { id: 1, day: 'Lundi' },
        { id: 2, day: 'Mardi' },
        { id: 3, day: 'Mercredi' },
        { id: 4, day: 'Jeudi' },
        { id: 5, day: 'Vendredi' },
        { id: 6, day: 'Samedi' },
        { id: 7, day: 'Dimanche' }
      ]
    }
  },
  mounted () {
  },
  methods: {
    scheduleSettingsGetWeekDays () {
      const dayWeek = []
      for (const dayWeekKey of this.dayWeek) {
        dayWeek.push({
          id: dayWeekKey.id,
          day: dayWeekKey.day,
          isToday: (this.scheduleSettingsDate.getDay() === dayWeekKey.id)
        })
      }
      return dayWeek
    }
  }
}
</script>
