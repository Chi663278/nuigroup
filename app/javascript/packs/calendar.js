import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from "@fullcalendar/list";

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  var screen_name = document.getElementById('screen_name').innerHTML;
  var calendar = new Calendar(calendarEl, {
    plugins: [dayGridPlugin, listPlugin],
    initialView: 'listMonth',
    events: '/users/' + screen_name +'/events.json',
    eventContent: function(arg) {
      let arrayOfDomNodes = []
      // title event
      let titleEvent = document.createElement('div')
      if(arg.event._def.title) {
        titleEvent.innerHTML = arg.event._def.title
        titleEvent.classList = "fc-event-title fc-sticky"
      }

      // image event
      let imgEventWrap = document.createElement('div')
      if(arg.event.extendedProps.img) {
        let imgEvent = '<img class="photo" src="'+arg.event.extendedProps.img+'" >'
        imgEventWrap.innerHTML = imgEvent;
        imgEventWrap.classList = "fc-event-img"
      }

      arrayOfDomNodes = [ titleEvent,imgEventWrap ]

      return { domNodes: arrayOfDomNodes }
    },
  });

  calendar.render();
});

