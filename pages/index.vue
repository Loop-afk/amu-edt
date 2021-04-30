<template>
  <div>
    <b-container>
      <b-row>
        <b-col cols="4" class="box">
          <list-groups />
        </b-col>
        <b-col cols="8" class="box">
          <schedule />
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import ListGroups from '~/components/ListGroups.vue'
import Schedule from '~/components/Schedule.vue'
export default {
  components: {
    ListGroups, Schedule
  }
}
</script>

<style>
.box{
  box-shadow: 1px 1px 1px red;
}
</style>
