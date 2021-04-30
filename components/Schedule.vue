<template>
  <div>
    <div>{{ hello }}</div>
    <div class="schedule-row">
      <div v-for="day in scheduleSettingsGetWeekDays()" :key="day.id" class="schedule-row-child box" cols="1">
        <!--{{ day.id }} - {{ day.dayString }} - {{ day.isToday }} - {{ day.dayExact }}-->
        <span v-if="day.isToday === true" class="schedule-today">
          {{ day.dayString + ' ' + day.dayDay }}
        </span>
        <span v-else>
          {{ day.dayString + ' ' + day.dayDay }}
        </span>
      </div>
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
          isToday: (this.scheduleSettingsDate.getDay() - 1 === dayWeekKey),
          dayExact: tempDate.toLocaleDateString('fr-fr'),
          dayDay: tempDate.toLocaleDateString('fr-fr', { day: 'numeric' })
        })
      }
      return dayWeek
    }
  }
}
</script>

<style scoped>
.box{
  box-shadow: 0px 0px 0px 1px rgb(255, 71, 71);
}

.schedule-row {
  display: flex;
  flex-flow: row;
  text-align: center;
}

.schedule-row-child {
  width: 100%;
}

.schedule-today {
  color: blue;
}
</style>
