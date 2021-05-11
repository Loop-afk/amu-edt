<template>
  <div>
    Hello
    {{ facts }}
    <ordinate-line
      :working-hours="facts.workingHours"
      :schedule-height="800"
      style="position: absolute; top: 37px;"
    />
  </div>
</template>

<script>
import OrdinateLine from '~/components/Schedule/OrdinateLine.vue'

export default {
  components: {
    OrdinateLine
  },
  async asyncData () {
    const response = await fetch('http://192.168.1.36:18929/schedule/')
    const facts = await response.json()
    console.log(facts)
    return { facts } // Same as return  { facts: facts }
  },
  data () {
    return { }
  },
  computed: { }
}
</script>
