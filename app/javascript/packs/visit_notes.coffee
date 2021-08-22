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
    patientId = element.dataset.patientId
    app = new Vue(
      el: element
      data: ->
        { visit_note: visitNote }
      methods:
        Flash: (message) -> 
          span = document.getElementById 'notice'
          span.innerHTML = message
           
        Submit: (quicksave=false) ->
          console.log("HereEerere", patientId);
          visitNote.patient_id = patientId
          if visitNote.id == null
            @$http # NEW
              .post "/patients/#{@visit_note.patient_id}/visit_notes", { visit_note: @visit_note, quicksave: quicksave } 
              .then (response) ->
                if !quicksave
                  Turbolinks.visit "/patients/#{@visit_note.patient_id}/visit_notes/#{response.body.id}"
                else 
                  console.log("Quicksaved")
                return
              (response) -> 
                @errors = response.data.errors
                return
          else 
            @$http # EDIT 
              .put "/patients/#{@visit_note.patient_id}/visit_notes/#{@visit_note.id}", { visit_note: @visit_note, quicksave: quicksave }
              .then (response) -> 
                if !quicksave
                  Turbolinks.visit "/patients/#{response.body.patient_id}/visit_notes/#{response.body.id}"
                else
                  console.log("quicksave", response);
                  this.Flash("Note Quicksaved!")
                  console.log("Quicksaved")
                return
              (response) ->
                  @errors = response.data.errors 
                  return
          return
    )
)
