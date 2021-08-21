import Vue from 'vue/dist/vue.esm'
import TurbolinksAdapter from 'vue-turbolinks'
import VueResource from 'vue-resource'

Vue.use(VueResource)
Vue.use(TurbolinksAdapter)
document.addEventListener('turbolinks:load', () -> 
  Vue.http.headers.common['X-CSRF-Token'] = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute('content')
  element = document.getElementById 'visit-notes-form'
  if element != null
    visitNote = JSON.parse(element.dataset.visitNote)
    console.log(visitNote, "VNN");
    app = new Vue(
      el: element
      data: ->
        { visit_note: visitNote }
      methods: Submit: (quicksave=false) ->
        console.log("HereEerere");
        if visitNote.id == null
          console.log("NEW?", quicksave)
          @$http # NEW
            .post "/patients/#{@visit_note.patient_id}/visit_notes", visit_note: @visit_note, quicksave: quicksave 
            .then(response) -> 
              Turbolinks.visit "/patients/#{@visit_note.patient_id}/visit_notes/#{response.body.id}"
              return
            (response) -> 
              @errors = response.data.errors
              return
        else 
          @$http # EDIT 
            .put "/patients/#{@visit_note.patient_id}/visit_notes/#{@visit_note.id}", { visit_note: @visit_note, quicksave: quicksave }
            .then(response) -> 
              console.log(response.body, "RR");
              Turbolinks.visit "/patients/#{@visit_note.patient_id}/visit_notes/#{response.body.id}"
              return
            (response) ->
                @errors = response.data.errors 
                return
        return
    )
)
