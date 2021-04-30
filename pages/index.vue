<template>
  <b-container>
    <b-row>
      <b-col cols="4" class="box">
        aaa
      </b-col>
      <b-col cols="8" class="box">
        bbb
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import ListGroups from '~/components/ListGroups.vue'
import Schedule from '~/components/Schedule.vue'
export default {
  components: ListGroups, Schedule
}
</script>

<style>
.box{
  box-shadow: 1px 1px 1px red;
}
</style>
