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
    app = new Vue(
      el: element
      data: ->
        { visit_note: visitNote }
      methods:
        Flash: (message) -> 
          span = document.getElementById 'notice'
          span.innerHTML = message
          setTimeout () ->
            span.innerHTML = ''
          , 3000

        Submit: (quicksave=false) ->
          if visitNote.id == null
            @$http # NEW
              .post "/visit_notes", { visit_note: @visit_note, quicksave: quicksave } 
              .then (response) ->
                if !quicksave
                  Turbolinks.visit "/visit_notes/#{response.body.id}"
                else 
                  console.log("Quicksaved")
                return
              (response) -> 
                @errors = response.data.errors
                return
          else 
            @$http # EDIT 
              .put "/visit_notes/#{@visit_note.id}", { visit_note: @visit_note, quicksave: quicksave }
              .then (response) -> 
                if !quicksave
                  Turbolinks.visit "/visit_notes/#{response.body.id}"
                else
                  this.Flash("Note Quicksaved!")
                return
              (response) ->
                  @errors = response.data.errors 
                  return
          return
    )
)
