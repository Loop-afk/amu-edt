<template>
  <div class="formularContainer">
    <!-- novalidate à tester -->
    <form novalidate="true" @submit="onSubmit">
      <label>Matière</label>
      <b-form-input v-model="formular.title" type="text" list="list_title" placeholder="Nom du cours" required />
      <b-form-datalist id="list_title" :options="formular_options.title" />
      <b-form-input v-model="formular.day" type="date" required />
      <b-form-input v-model="startTime" type="time" required />
      <b-form-input v-model="endTime" type="time" required />
      <b-form-select v-model="formular.occurences" :options="formular_options.occurences" />
      <b-form-select v-model="formular.duration" :options="formular_options.duration" />
      <b-form-input v-if="formular.duration === null || Number(formular.duration) != Number.NaN" v-model="formular.duration" type="number" placeholder="Nombre de semaine" />
      <b-form-input v-model="formular.teacher" type="text" list="list_teacher" placeholder="Professeur" />
      <b-form-datalist id="list_teacher" :options="formular_options.teacher" />
      <br>
      <br>
      <br>
      <br>
      <div class="debug">
        {{ endTime }}
      </div>
      <b-button type="submit" variant="primary">
        Ajouter un cour
      </b-button>
      <b-button type="reset" variant="secondary">
        Effacer
      </b-button>
    </form>
  </div>
</template>

<script>
import { getInputFormatedDate } from '~/assets/js/formatedDate.js'

export default {
  props: {
    scheduleReferenceDate: {
      type: Date,
      required: true
    }
  },
  data () {
    return {
      formular: {
        title: null,
        day: getInputFormatedDate(this.scheduleReferenceDate),
        occurences: null, // default value
        duration: null,
        groups: [],
        start: { hour: null, minutes: null },
        end: { hour: null, minutes: null },
        teacher: null,
        room: null
      },

      formular_options: {
        title: ['Algorithmique', 'Logique', 'Projet'],
        teacher: ['Line JAMET JAKUBIEC', 'Victor CEPOI', 'Séverine Fratanie'],
        groups: ['Aix/L3 info', 'Luminy/L3 info', 'L2 chimie'],
        occurences: [{ text: 'Choisir une occurence', value: null }, 'spontané', 'journalier', 'hebdomadaire', 'bihebdomadaire', 'mensuel'],
        duration: [{ text: 'Choisir une durée', value: null }, 'spontané', '1 semaine', 'semi-semestriel', 'semestriel', 'annuel']
      }
    }
  },
  computed: {
    startTime: { // @Overide de v-model
      get () {
        return this.formular.start.hour + ':' + this.formular.start.minutes
      },
      set (value) {
        const temp = value.split(':')
        this.formular.start.hour = temp[0]
        this.formular.start.minutes = temp[1]
      }
    },
    endTime: { // @Overide de v-model
      get () {
        return this.formular.end.hour + ':' + this.formular.end.minutes
      },
      set (value) {
        const temp = value.split(':')
        this.formular.end.hour = temp[0]
        this.formular.end.minutes = temp[1]
      }
    }
  },
  methods: {
    onSubmit () {

    },
    getInputFormatedDate (date) {
      return getInputFormatedDate(date)
    }
  }
}
</script>

<style scoped>
.formularContainer {
  color: black;
}
</style>
