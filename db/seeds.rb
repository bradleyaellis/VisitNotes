# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |i|
    Patient.create(name: Faker::FunnyName.name_with_initial, age: Faker::Number.number(digits: 1))
end

Patient.all.each do |p|
    5.times do |i|
        VisitNote.create(patient_id: p.id, title: Faker::Date.forward(days: i * 7), body: Faker::Lorem.paragraph)
    end

    p.visit_notes.each do |vn|
        5.times do |ii|
            ProgressWord.create(name: Faker::Cosmere.aon, rating: Faker::Number.between(from: 1, to: 5), patient_id: p.id, visit_note_id: vn.id)
        end
    end
end
