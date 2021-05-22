<template>
  <b-modal
    id="modal-formular"
    title="Nouveau cours"
    scrollable
    centered
    @ok="handleSubmit"
  >
    <label>Matière</label>
    <b-form-input v-model="formularNewUeName" type="text" list="list_title" placeholder="Nom du cours" required />
    <b-form-datalist id="list_title" :options="formularOptions.ueName" />

    <b-form-input v-model="formularNewTimeStart" type="time" />

    <b-form-input v-model="formularNewTimeEnd" type="time" />

    <b-form-select v-model="formularNewOccurence" :options="formularOptions.occurences" />

    <b-form-select v-model="formularNewDuration" :options="formularOptions.duration" />

    <b-form-input v-model="formularNewTeacher" type="text" list="list_teacher" placeholder="Professeur" />
    <b-form-datalist id="list_teacher" :options="formularOptions.teacher" />

    <b-form-input v-model="formularNewGroups" placeholder="Classes" list="list_groups" />
    <b-form-datalist id="list_groups" :options="formularOptions.groups" />

    <b-form-input v-model="formularNewRoom" type="text" list="list_room" placeholder="Salle de cours" />
    <b-form-datalist id="list_room" :options="formularOptions.room" />

    <b-form-input v-model="formularNewCampus" type="text" list="list_campus" placeholder="Campus" />
    <b-form-datalist id="list_campus" :options="formularOptions.campus" />
  </b-modal>
</template>

<script>
import { getInputFormatedDate, getInputFormatedCustomTime } from '~/assets/js/formatedDate.js'

export default {
  props: {
    scheduleReferenceDate: {
      type: Date,
      required: true
    },
    selectedCourse: {
      type: Object,
      required: true
    },
    formularOptions: {
      type: Object,
      default: () => {},
      required: false
    }
  },
  data () {
    return {
      formularNewUeName: null,
      formularNewDate: null,
      formularNewTimeStart: null,
      formularNewTimeEnd: null,
      formularNewOccurence: null,
      formularNewDuration: null,
      formularNewTeacher: null,
      formularNewGroups: null,
      formularNewRoom: null,
      formularNewCampus: null
    }
  },
  watch: {
    selectedCourse (newSelectedCourse, oldSelectedCourse) {
      this.formularNewTimeStart = getInputFormatedCustomTime(newSelectedCourse.start)
      this.formularNewTimeEnd = getInputFormatedCustomTime(newSelectedCourse.end)
      this.formularNewUeName = newSelectedCourse.ue.field.value
      this.formularNewTeacher = newSelectedCourse.teacher.value
      this.formularNewRoom = newSelectedCourse.place.room.value
      this.formularNewCampus = newSelectedCourse.place.campus.value
      this.formularNewGroups = newSelectedCourse.groups.value
    }
  },
  methods: {
    handleSubmit () {
      const course = {
        ueName: this.selectedCourse.ue.field.id,
        date: getInputFormatedDate(this.scheduleReferenceDate),
        start: this.formularNewTimeStart, // format "hh:mm"
        end: this.formularNewTimeEnd,
        occurences: this.formularNewOccurence,
        duration: this.formularNewDuration,
        groups: this.selectedCourse.groups.id,
        teacher: this.selectedCourse.teacher.id,
        room: this.selectedCourse.place.room.id,
        campus: this.selectedCourse.place.campus.id
      }
      const callbackSendNewCourse = (course, status) => {
        this.makeToast(course, status)
      }
      this.sendNewCourse(course, callbackSendNewCourse)
    },
    sendNewCourse (course, callbackSendNewCourse) {
      console.log(course) // fetch ici
      const res = fetch(`http://192.168.1.29:8000/nouveau/cours/?ueName=${course.ueName}&date=${course.date}&start=${course.start}&occurences=${course.occurences}&duration=${course.duration}&groups=${course.groups}&teacher=${course.teacher}&room=${course.room}&campus=${course.campus}`)
      res.then(res => res.json())
        .then((data) => { return data })
        .catch(error => console.error(error))
      const status = (res.ok === 200) ? 1 : 0
      callbackSendNewCourse(course, status)
    },
    makeToast (course, status) {
      if (status === 0) {
        this.$bvToast.toast(`${course.ueName}`, {
          title: 'Echec d\'ajout',
          autoHideDelay: 10000,
          variant: 'danger',
          appendToast: false
        })
      } else {
        this.$bvToast.toast(`${course.ueName}`, {
          title: 'Cours ajouté',
          autoHideDelay: 5000,
          appendToast: false
        })
      }
    },
    groupsExtractor (group) {
      return group.value
    }
  }
}
</script>

<style scoped>
.formularContainer {
  color: black;
}
</style>
