import Vue from 'vue/dist/vue.esm'
import TurbolinksAdapter from 'vue-turbolinks'
import VueResource from 'vue-resource'

Vue.use(VueResource)
Vue.use(TurbolinksAdapter)
document.addEventListener('turbolinks:load', () => { 

  Vue.http.headers.common['X-CSRF-Token'] = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute('content')

  let element = document.getElementById('visit-notes-form')
  if (element != null) { 
    let visitNote = JSON.parse(element.dataset.visitNote)
    console.log(element.dataset);
    let noteWords = JSON.parse(element.dataset.visitNoteWords);
    // let patientId = element.dataset.patientId
    const app = new Vue({
      el: element,
      data: () => ({ 
         visit_note: visitNote,
         note_words: noteWords,
         newId: 0
      }),
      computed: { 
        id() {
          return (this.visit_note.id ? this.visit_note.id : this.newId)
        },
        percentage(){
          console.log(this.note_words);
          let values = this.note_words.map(nw => nw.rating)
          values = values.reduce((a, b) => a + b, 0);
          console.log(values, this.note_words.length);
          let percentage = ((this.note_words.length / values).toFixed(2)) * 100;

          return percentage;
        }
      },
      mounted() {
        console.log("YEAH", noteWords)
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