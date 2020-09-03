<template>
  <div>
    <div id="form-modal">
      <createComponent ref="form" @save="saveEvent"></createComponent>
    </div>

    <v-menu bottom right>
      <template v-slot:activator="{ on }">
        <v-btn
          outlined
          color="grey darken-2"
          v-on="on"
        >
          <span>{{type}}</span>
        </v-btn>
      </template>

      <v-list>
        <v-list-item @click="type = 'day'">
          <v-list-item-title>Day</v-list-item-title>
        </v-list-item>
        <v-list-item @click="type = 'week'">
          <v-list-item-title>Week</v-list-item-title>
        </v-list-item>
        <v-list-item @click="type = 'month'">
          <v-list-item-title>Month</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>

    <v-sheet height="500">
      <v-calendar
          ref="calendar"
          locale="ja-jp"
          :type="type"
          :now="today"
          :value="today"
          :events="events"
          color="primary"
          @click:event="clickEvent"
          @click:date="showDay"
          @click:day="createEvent"
      ></v-calendar>
    </v-sheet>

    <v-menu
        v-model="eventAlert"
        :close-on-content-click="false"
        :activator="selectedItem"
      >
        <v-card
          color="grey lighten-4"
          min-width="350px"
          flat
        >

        <v-card-text>
          <span v-html="selectedEvent.id"></span>
          <span v-html="selectedEvent.name"></span>
        </v-card-text>

        <v-btn
          text
          color="primary"
          @click="eventAlert = false"
        >
          閉じる
        </v-btn>

        <v-btn
          text
          color="error"
          @click="deleteTarget = selectedEvent.id; showModal = true"
        >
          削除
        </v-btn>
      </v-card>
    </v-menu>
     <Modal v-if="showModal" @cancel="showModal = false" @ok="deleteEvent(); showModal = false;">
      <div slot="body">Are you sure?</div>
    </Modal>
  </div>
</template>


<script>
  import createComponent from '../components/CreateComponent'
  import Modal from '../components/Modal'
  import axios from 'axios'

  export default {
    name: 'calendarComponent',
    data: () => ({
    today: `2020-05-19`,
    type:'month',
    datas:[],
    events: [
        {
          id: 1,
          name: 'あたりまえ体操をする',
          start: '2020-05-18',
          end: '2020-05-1',
        },
        {
          id: 2,
          name: 'Meeting',
          start: '2020-05-1 09:00',
          end: '2020-05-1 10:00',
        },
      ],
      eventAlert:false,
      selectedItem : null,
      selectedEvent : {},
      deleteTarget: -1,
      showModal: false,
    }),
    components: {
      createComponent,
      Modal
    },
    computed:{
    },
    mounted () {
      axios
      .get('/api/calendar.json')
      .then(response => (this.events = response.data));
      this.updateEvent();
    },
    methods:{
      showDay( { date } ){
        this.today = date
        this.type = 'day'
      },
      createEvent({ date }){
        this.$refs.form.open(date);
      },
      async saveEvent(params){
        await axios.post('api/calendar',params)
          .then( res => {
            console.log(res);
          })
          .catch( e => {
            console.log(e);
          })
          .finally( () => {
            
          })
      },
       // event → day の順番で呼ばれる。
      clickEvent( {nativeEvent,event} ){
        this.selectedEvent = event;
        this.selectedItem = nativeEvent.target;
        //よくわからんが時間差でやるとうまく動作する。
        setTimeout(() => this.eventAlert = true, 10);
        //次にcreateEventが走ってしまうのを防御する
        nativeEvent.stopPropagation();
      },
      deleteEvent: function() {
      if (this.deleteTarget <= 0) {
        console.warn('deleteTarget should be grater than zero.');
        return;
      }

      axios
        .delete(`/api/calendar/${this.deleteTarget}`)
        .then(response => {
          this.deleteTarget = -1;
          this.updateEvent();
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    updateEvent: function() {
      axios
        .get('/api/calendar.json')
        .then(response => (this.events = response.data))
    }
    }
  }
</script>
