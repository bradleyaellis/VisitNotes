import Vue from 'vue/dist/vue.esm'
import TurbolinksAdapter from 'vue-turbolinks'
import VueResource from 'vue-resource'

Vue.use(VueResource)
Vue.use(TurbolinksAdapter)
document.addEventListener('turbolinks:load', () => { 
  console.log("LOADED")
  Vue.http.headers.common['X-CSRF-Token'] = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute('content')

  let element = document.getElementById('visit-notes-form')
  if (element != null) { 
    let visitNote = JSON.parse(element.dataset.visitNote)
    let patientId = element.dataset.patientId
    app = new Vue({
      el: element,
      data: () => ({ 
         visit_note: visitNote,
         newId: 0
      }),
      computed: { 
        id() {
          return (this.visit_note.id ? this.visit_note.id : this.newId)
        },
      },
      methods: { 
        Flash(message){  
          span = document.getElementById('notice')
          span.innerHTML = message
        },
        Submit(quicksave=false){
          if (this.id == null) { 
            // NEW
            http 
              .post `/patients/${visit_note.patient_id}/visit_notes`, { visit_note: visit_note, quicksave: quicksave } 
              .then((response) => {  
                console.log("RESPONSE", response.body.patient_id)
                if (!quicksave) { 
                  Turbolinks.visit `/patients/${visit_note.patient_id}/visit_notes/${response.body.id}`
                } else { 
                  this.newId = response.body.id 
                  console.log("Quicksaved")
                }
              })
              .catch((err) => { 
                let errors = errdata.errors
                return
              })
          } else {
            // EDIT   
            http 
              .put `/patients/${visit_note.patient_id}/visit_notes/${visit_note.id}`, { visit_note: visit_note, quicksave: quicksave }
              .then((response) => {  
                if (!quicksave) {
                  Turbolinks.visit `/patients/${response.body.patient_id}/visit_notes/${response.body.id}`
              } else { 
                  this.Flash("Note Quicksaved!")
                return
              }
              })
              .catch((response) => { 
                  let errors = response.data.errors 
                  return
              })
          }
          return
        }
      }
    })
  }
})