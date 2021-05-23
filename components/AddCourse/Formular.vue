<template>
  <b-modal
    id="modal-formular"
    title="Nouveau cours"
    scrollable
    centered
    @ok="handleSubmit"
  >
    <label>Matière</label>
    <b-form-input
      v-model="formularNewUeName"
      type="text"
      list="list_title"
      placeholder="Nom du cours"
      required
      :readonly="deleteMode"
    />
    <b-form-datalist v-if="!deleteMode" id="list_title" :options="formularOptions.ueName" />
    <br>

    <navigator-calendar
      :schedule-reference-date="new Date(formularNewDate)"
      :readonly="deleteMode"
      @calendarDateChangedEvent="dateChange($event)"
    />

    <br>

    <b-form-input v-model="formularNewTimeStart" type="time" :readonly="deleteMode" />

    <br>

    <b-form-input v-model="formularNewTimeEnd" type="time" :readonly="deleteMode" />

    <br>

    <b-form-select v-if="!deleteMode" v-model="formularNewOccurence" :options="formularOptions.occurences" />

    <br v-if="!deleteMode">
    <br v-if="!deleteMode">

    <!-- <b-form-select v-if="!deleteMode" v-model="formularNewDuration" :options="formularOptions.duration" /> -->
    <b-form-input v-if="!deleteMode" v-model="formularNewDuration" type="number" placeholder="Plage" />

    <br v-if="!deleteMode">
    <br v-if="!deleteMode">

    <b-form-input v-model="formularNewTeacher" type="text" list="list_teacher" placeholder="Professeur" :readonly="deleteMode" />
    <b-form-datalist v-if="!deleteMode" id="list_teacher" :options="formularOptions.teacher" />

    <br>

    <b-form-input v-model="formularNewGroups" placeholder="Classes" list="list_groups" :readonly="deleteMode" />
    <b-form-datalist v-if="!deleteMode" id="list_groups" :options="formularOptions.groups" />

    <br>

    <b-form-input v-model="formularNewRoom" type="text" list="list_room" placeholder="Salle de cours" :readonly="deleteMode" />
    <b-form-datalist v-if="!deleteMode" id="list_room" :options="formularOptions.room" />

    <br>

    <b-form-input v-model="formularNewCampus" type="text" list="list_campus" placeholder="Campus" :readonly="deleteMode" />
    <b-form-datalist v-if="!deleteMode" id="list_campus" :options="formularOptions.campus" />
  </b-modal>
</template>

<script>
import NavigatorCalendar from '../Navigator/NavigatorCalendar.vue'
import { getInputFormatedDate, getInputFormatedCustomTime, getInputFormatedDateFromComparable } from '~/assets/js/formatedDate.js'

export default {
  components: { NavigatorCalendar },
  props: {
    scheduleReferenceDate: { type: Date, default: null },
    selectedCourse: {
      type: Object,
      required: true
    },
    formularOptions: {
      type: Object,
      default: () => {},
      required: false
    },
    deleteMode: {
      type: Boolean,
      default: false
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
      this.formularNewDate = getInputFormatedDateFromComparable(newSelectedCourse.date)
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
        id: this.selectedCourse.id,
        ueName: this.selectedCourse.ue.field.id,
        date: (this.deleteMode) ? getInputFormatedDateFromComparable(this.selectedCourse.date) : getInputFormatedDate(this.scheduleReferenceDate),
        start: this.formularNewTimeStart, // format "hh:mm"
        end: this.formularNewTimeEnd,
        occurences: this.formularNewOccurence,
        duration: this.formularNewDuration,
        groups: this.selectedCourse.groups.id,
        teacher: this.selectedCourse.teacher.id,
        room: this.selectedCourse.place.room.id,
        campus: this.selectedCourse.place.campus.id
      }
      const callbackSendRequest = (course, status) => {
        this.makeToast(course, status)
      }
      this.sendRequest(course, callbackSendRequest)
    },
    sendRequest (course, callbackSendRequest) {
      console.log(course)
      const request = (!this.deleteMode)
        ? `http://192.168.1.29:8000/nouveau/cours/?ueName=${course.ueName}&date=${course.date}&start=${course.start}&end=${course.end}&occurences=${course.occurences}&duration=${course.duration}&groups=${course.groups}&teacher=${course.teacher}&room=${course.room}&campus=${course.campus}`
        : `http://192.168.1.29:8000/supprimer/cours/?courseId=${course.id}`
      console.log("[AMU'EDT log] Sending to server =>", request)
      const res = fetch(request)
      res.then(res => res.json())
        .then((data) => { return data })
        .catch(error => console.error(error))
      callbackSendRequest(course, res.status)
    },
    makeToast (course, status) {
      if (status !== 200) {
        console.log(status)
        this.$bvToast.toast(`Numéro de l'ue: ${course.ueName}, code d'erreur: ${status}`, {
          title: (!this.deleteMode) ? 'Echec d\'ajout' : 'Echec de suppression',
          autoHideDelay: 10000,
          variant: 'danger',
          appendToast: false
        })
      } else {
        this.$bvToast.toast(`${course.ueName}`, {
          title: (this.deleteMode) ? 'Cours ajouté' : 'Cours supprimé',
          autoHideDelay: 5000,
          appendToast: false
        })
      }
    },
    groupsExtractor (group) {
      return group.value
    },
    dateChange (value) {
      this.$emit('calendarDateChangedEvent', value)
    }
  }
}
</script>
