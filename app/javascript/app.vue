<template>
  <div id="app">
    <v-app>
      <calenderComponent></calenderComponent>
      <Modal></Modal>
    </v-app>
  </div>
</template>

<script>
import calenderComponent from "./components/CalendarComponent.vue";
// import Modal from './components/Modal'
// import createComponent from "./components/CreateComponent.vue";

export default {
  data: function () {
    return {
    }
  },
  components: {
    calenderComponent,
    // Modal,
    // createComponent
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
