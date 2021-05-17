<template>
  <b-modal
    id="modal-1"
    title="Nouveau cours"
    scrollable
    centered
    @ok="handleSubmit"
  >
    <label>Matière</label>
    <b-form-input v-model="formularNewTitle" type="text" list="list_title" placeholder="Nom du cours" required />
    <b-form-datalist id="list_title" :options="formular_options.title" />
    <b-form-input v-model="formularNewDate" type="date" required />
    <!--
      <b-form-select v-model="formularAdaptor(selectedCourse)" :options="formular_options.occurences" />
      <b-form-select v-model="formularAdaptor(selectedCourse)" :options="formular_options.duration" />
      <b-form-input v-if="formularAdaptor(selectedCourse) === null || Number(formular.duration) != Number.NaN" v-model="formular.duration" type="number" placeholder="Nombre de semaine" />
      <b-form-input v-model="formularAdaptor(selectedCourse)" type="text" list="list_teacher" placeholder="Professeur" />
      <b-form-datalist id="list_teacher" :options="formular_options.teacher" />
      <br>
      -->
    <br>
    <div class="debug" />
  </b-modal>
</template>

<script>
import { getInputFormatedDate } from '~/assets/js/formatedDate.js'

export default {
  props: {
    scheduleReferenceDate: {
      type: Date,
      required: true
    },
    selectedCourse: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      formular: this.formularAdaptor(this.selectedCourse),
      formular_options: {
        title: ['Algorithmique', 'Logique', 'Projet'],
        teacher: ['Line JAMET JAKUBIEC', 'Victor CEPOI', 'Séverine Fratanie'],
        groups: ['Aix/L3 info', 'Luminy/L3 info', 'L2 chimie'],
        occurences: [{ text: 'Choisir une occurence', value: null }, { text: 'spontané', value: 0 }, { text: 'journalier', value: 1 }, { text: 'hebdomadaire', value: 7 }, { text: 'bihebdomadaire', value: 14 }, { text: 'mensuel', value: 30 }],
        duration: [{ text: 'Choisir une durée', value: null }, { text: 'spontané', value: 0 }, { text: '1 semaine', value: 7 }, { text: 'semi-semestriel', value: 45 }, { text: 'semestriel', value: 90 }, { text: 'annuel', value: 365 }]
      }
    }
  },
  computed: {
    formularNewTitle: {
      set (value) {
        this.formular.title = value
      },
      get () {
        return this.formular.title
      }
    },
    formularNewDate: {
      set (value) {
        this.fomular.date = value
      },
      get () {
        return this.formular.date
      }
    },
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
  watch: {
    selectedCourse () {
      this.formular = this.formularAdaptor(this.selectedCourse)
    }
  },
  methods: {
    handleSubmit () {
      console.log(this.formular)
    },
    formularAdaptorTitle (course) {
      return course.ue.field.value
    },
    formularAdaptorDate (course) {
      return getInputFormatedDate(new Date(course.date.year, course.date.month, course.date.day))
    },
    formularAdaptorOccurence (course) {
      return null
    },
    formularAdaptorDuration (course) {
      return null
    },
    formularAdaptorGroup (course) {
      const extract = []
      for (const group of course.groups) {
        extract.push(group.value)
      }
      return extract
    },
    formularAdaptorTeacher (course) {
      return course.teacher.value
    },
    formularAdaptorRoom (course) {
      return course.place.room.value
    },
    formularAdaptorCampus (course) {
      return course.place.campus.value
    },
    formularAdaptor (course) {
      console.log(course)
      if (course.groups !== undefined) { // on assume que tout est indefinie
        console.log('a')
        return {
          title: this.formularAdaptorTitle(course),
          date: this.formularAdaptorDate(course),
          occurences: this.formularAdaptorOccurence(course),
          duration: this.formularAdaptorDuration(course),
          groups: this.formularAdaptorGroup(course),
          teacher: this.formularAdaptorTeacher(course),
          room: this.formularAdaptorRoom(course),
          campus: this.formularAdaptorCampus(course)
        }
      }
      return {
        title: null,
        date: getInputFormatedDate(this.scheduleReferenceDate),
        occurences: null, // default value
        duration: null,
        groups: [],
        teacher: null,
        room: null,
        campus: null
      }
    }
  }
}
</script>

<style scoped>
.formularContainer {
  color: black;
}
</style>
