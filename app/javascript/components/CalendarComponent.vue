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
          @click="deleteEvent"
        >
          削除
        </v-btn>
      </v-card>
    </v-menu>
  </div>
</template>


<script>
  import createComponent from '../components/CreateComponent'
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
    }),
    components: {
      createComponent
    },
    computed:{
    },
    mounted () {
      axios.get('/')
        .then( res => {
          this.events = res.data;
        })
        .catch( e => {
          console.log(e);
        })
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
        await axios.post('/create',params)
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
      deleteEvent(){
        // 正しい削除処理はLaravelがまだできない
        // とりあえずnewArrayにfilterした結果を突っ込んで返すだけ。
        let newArray = this.events.filter( item => {
          return item.id != this.selectedEvent.id
      });
        this.events = newArray;
        this.eventAlert = false;
      }
    }
  }
</script>
