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
  console.log(JSON.parse(element.dataset.visitNote));
  if element != null
    visitNote = JSON.parse(element.dataset.visitNote)
    app = new Vue(
      el: element
      data: ->
        { visit_note: visitNote }
      methods: Submit: (quicksave=false) ->
        console.log(quicksave, 'sq');
        if visitNote.id == null
          @$http # NEW
            .post '/patient_visit_notes', visit_note: @visit_note, quicksave: quicksave 
            .then(resp) -> 
              #Turbolinks.visit "/patient_visit_notes/#{resp.body.id}"
              return
            (resp) -> 
              @errors = resp.data.errors
              return
        else 
          @$http # EDIT 
            .put "/visit_notes/#{visit_note.id}", visit_note: @visit_note
            .then(resp) -> 
                #Turbolinks.visit "/visit_notes/#{resp.body.id}"
                return
            (resp) ->
                @errors = resp.data.errors 
                return
        return
    )
)
