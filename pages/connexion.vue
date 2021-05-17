<template>
  <div class="background">
    <div>
      <svg
        id="svg"
        style="position: fixed;  bottom: -150px;
  right: 0;"
        height="100%"
        width="100%"
        viewBox="0 0 1440 500"
      ><defs><linearGradient id="gradient"><stop offset="5%" stop-color="#0070ba66" /><stop offset="95%" stop-color="#0bbbef66" /></linearGradient></defs><path d="M 0,500 C 0,500 0,125 0,125 C 86.93779904306217,99.49760765550239 173.87559808612434,73.99521531100478 286,81 C 398.12440191387566,88.00478468899522 535.4354066985646,127.51674641148324 624,139 C 712.5645933014354,150.48325358851676 752.382775119617,133.9377990430622 846,118 C 939.617224880383,102.0622009569378 1087.0334928229665,86.73205741626795 1195,88 C 1302.9665071770335,89.26794258373205 1371.4832535885166,107.13397129186603 1440,125 C 1440,125 1440,500 1440,500 Z" stroke="none" stroke-width="0" fill="url(#gradient)" class="transition-all duration-300 ease-in-out delay-150" /><defs><linearGradient id="gradient"><stop offset="5%" stop-color="#0070ba88" /><stop offset="95%" stop-color="#0bbbef88" /></linearGradient></defs><path d="M 0,500 C 0,500 0,250 0,250 C 79.27272727272728,233.74162679425837 158.54545454545456,217.48325358851676 256,234 C 353.45454545454544,250.51674641148324 469.0909090909091,299.80861244019144 563,296 C 656.9090909090909,292.19138755980856 729.0909090909091,235.2822966507177 814,220 C 898.9090909090909,204.7177033492823 996.5454545454545,231.0622009569378 1103,243 C 1209.4545454545455,254.9377990430622 1324.7272727272727,252.4688995215311 1440,250 C 1440,250 1440,500 1440,500 Z" stroke="none" stroke-width="0" fill="url(#gradient)" class="transition-all duration-300 ease-in-out delay-150" /><defs><linearGradient id="gradient"><stop offset="5%" stop-color="#0070baff" /><stop offset="95%" stop-color="#0bbbefff" /></linearGradient></defs><path d="M 0,500 C 0,500 0,375 0,375 C 80.93779904306217,393.63157894736844 161.87559808612434,412.2631578947368 259,419 C 356.12440191387566,425.7368421052632 469.43540669856463,420.57894736842104 578,402 C 686.5645933014354,383.42105263157896 790.3827751196171,351.42105263157896 874,339 C 957.6172248803829,326.57894736842104 1021.0334928229665,333.7368421052632 1112,343 C 1202.9665071770335,352.2631578947368 1321.4832535885166,363.63157894736844 1440,375 C 1440,375 1440,500 1440,500 Z" stroke="none" stroke-width="0" fill="url(#gradient)" /></svg>
      <form class="formcontainer cContainer" @submit="userLogin">
        <div>
          <label>Username</label>
          <input v-model="login.username" type="text">
        </div>
        <div>
          <label>Password</label>
          <input v-model="login.password" type="text">
        </div>
        <div>
          <button type="submit" class="submit">
            Submit
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      login: {
        username: '',
        password: ''
      }
    }
  },
  methods: {
    async userLogin () {
      try {
        const response = await this.$auth.loginWith('local', { data: this.login })
        console.log(response)
      } catch (err) {
        console.log(err)
      }
    }
  }
}
</script>

<style scoped>
.background {
  background-color: whitesmoke;
  width: 100%;
  height: 100%;
  position: absolute;
}
.formcontainer {
  height: 250px;
  width: 30%;
  min-width: 350px;
  top: calc(50% - 125px);
  left: calc(50% - 300px);
}

.submit {
  position: relative;
}
</style>
