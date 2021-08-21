json.extract! visit_note, :id, :title, :body, :created_at, :updated_at
json.url visit_note_url(visit_note, format: :json)
