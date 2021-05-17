<template>
  <b-modal id="modal-1" title="Nouveau cours" scrollable centered>
    <form novalidate="true" @submit="onSubmit">
      <label>Matière</label>
      <b-form-input v-model="formularAdaptor(selectedCourse).title" type="text" list="list_title" placeholder="Nom du cours" required />
      <b-form-datalist id="list_title" :options="formular_options.title" />
      <b-form-input v-model="formularAdaptor(selectedCourse).day" type="date" required />
      <b-form-select v-model="formularAdaptor(selectedCourse).occurences" :options="formular_options.occurences" />
      <b-form-select v-model="formularAdaptor(selectedCourse).duration" :options="formular_options.duration" />
      <b-form-input v-if="formularAdaptor(selectedCourse).duration === null || Number(formular.duration) != Number.NaN" v-model="formular.duration" type="number" placeholder="Nombre de semaine" />
      <b-form-input v-model="formularAdaptor(selectedCourse).teacher" type="text" list="list_teacher" placeholder="Professeur" />
      <b-form-datalist id="list_teacher" :options="formular_options.teacher" />
      <br>
      <br>
      <div class="debug" />
      <b-button type="submit" variant="primary">
        Ajouter un cour
      </b-button>
      <b-button type="reset" variant="secondary">
        Effacer
      </b-button>
    </form>
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
      default: null,
      required: false
    }
  },
  data () {
    return {
      formular: this.formularAdaptor(this.selectedCourse),
      formular_options: {
        title: ['Algorithmique', 'Logique', 'Projet'],
        teacher: ['Line JAMET JAKUBIEC', 'Victor CEPOI', 'Séverine Fratanie'],
        groups: ['Aix/L3 info', 'Luminy/L3 info', 'L2 chimie'],
        occurences: [{ text: 'Choisir une occurence', value: null }, 'spontané', 'journalier', 'hebdomadaire', 'bihebdomadaire', 'mensuel'],
        duration: [{ text: 'Choisir une durée', value: null }, 'spontané', '1 semaine', 'semi-semestriel', 'semestriel', 'annuel']
      }
    }
  },
  methods: {
    onSubmit () {

    },
    formularGroupsAdaptor (groups) {
      const extract = []
      for (const group of groups) {
        extract.push(group.value)
      }
      return extract
    },
    formularAdaptor (course) { // TODO optimiser + TODO heures
      if (course === null) { // on start up
        return {
          title: null,
          day: getInputFormatedDate(this.scheduleReferenceDate),
          occurences: null, // default value
          duration: null,
          groups: [],
          teacher: null,
          room: null,
          campus: null
        }
      }
      return {
        title: course.ue.field.value,
        day: getInputFormatedDate(new Date(course.day.year, course.day.month, course.day.day)),
        groups: this.formularGroupsAdaptor(course.groups),
        teacher: course.teacher.value,
        room: course.place.room.value,
        campus: course.place.campus.value
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
