<template>
  <b-modal
    id="modal-1"
    title="Nouveau cours"
    scrollable
    centered
    @ok="handleSubmit"
  >
    <label>Matière</label>
    <b-form-input
      v-model="formularNewTitle"
      type="text"
      list="list_title"
      placeholder="Nom du cours"
      required
      :state="true"
    />
    <b-form-datalist id="list_title" :options="formular_options.title" />
    <custom-input-time
      :selected-course-time="formularNewTimeStart"
      @time-change-event-time="timeChange($event)"
    />
    <custom-input-time
      :selected-course-time="formularNewTimeEnd"
      @time-change-event="timeChange($event)"
    />
    <b-form-select v-model="formularNewOccurence" :options="formular_options.occurences" />
    <b-form-select v-model="formularNewDuration" :options="formular_options.duration" />
    <b-form-input v-model="formularNewTeacher" type="text" list="list_teacher" placeholder="Professeur" />
    <b-form-datalist id="list_teacher" :options="formular_options.teacher" />

    <b-form-input v-model="formularNewRoom" type="text" list="list_room" placeholder="Salle de cour" />
    <b-form-datalist id="list_room" :options="formular_options.room" />
    <b-form-input v-model="formularNewCampus" type="text" list="list_campus" placeholder="Campus" />
    <b-form-datalist id="list_campus" :options="formular_options.campus" />

    <br>
  </b-modal>
</template>

<script>
import { getInputFormatedDate } from '~/assets/js/formatedDate.js'
import CustomInputTime from '~/components/AddCourse/CustomInputTime.vue'
export default {
  components: {
    CustomInputTime
  },
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
      formularNewTitle: null,
      formularNewDate: null,
      formularNewTimeStart: {},
      formularNewTimeEnd: {},
      formularNewOccurence: null,
      formularNewDuration: null,
      formularNewTeacher: null,
      formularNewRoom: null,
      formularNewCampus: null,
      formular_options: {
        title: ['Algorithmique', 'Logique', 'Projet'],
        teacher: ['Line JAMET JAKUBIEC', 'Victor CEPOI', 'Séverine Fratanie'],
        groups: ['Aix/L3 info', 'Luminy/L3 info', 'L2 chimie'],
        occurences: [{ text: 'Choisir une occurence', value: null }, { text: 'spontané', value: 0 }, { text: 'journalier', value: 1 }, { text: 'hebdomadaire', value: 7 }, { text: 'bihebdomadaire', value: 14 }, { text: 'mensuel', value: 30 }],
        duration: [{ text: 'Choisir une durée', value: null }, { text: 'spontané', value: 0 }, { text: '1 semaine', value: 7 }, { text: 'semi-semestriel', value: 45 }, { text: 'semestriel', value: 90 }, { text: 'annuel', value: 365 }],
        campus: [{ text: 'Luminy', value: 1 }, { text: 'Aix en provence', value: 2 }, { text: 'Saint Charles', value: 3 }, { text: 'St Charles', value: 3 }],
        room: [{ text: 'A300', value: 1 }, { text: 'B302', value: 2 }, { text: 'B310', value: 3 }]
      }
    }
  },
  watch: {
    selectedCourse (newSelectedCourse, oldSelectedCourse) {
      console.log('here')
      this.formularNewTimeStart = newSelectedCourse.start
      this.formularNewTimeEnd = newSelectedCourse.end
      this.formularNewTitle = newSelectedCourse.ue.field.value
    }
  },
  methods: {
    handleSubmit () {
      console.log({
        title: this.formularNewTitle,
        date: this.formularNewDate,
        start: this.formularNewTimeStart,
        end: this.formularNewTimeEnd,
        occurences: this.formularNewOccurence,
        duration: this.formularNewDuration,
        groups: [],
        teacher: this.formularNewTeacher,
        room: this.formularNewRoom,
        campus: this.formularNewCampus
      })
    },
    formularDefault () {
      return {
        title: null,
        date: getInputFormatedDate(this.scheduleReferenceDate),
        start: { hours: null, minutes: null },
        end: { hours: null, minutes: null },
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
