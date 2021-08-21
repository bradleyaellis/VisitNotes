require "application_system_test_case"

class VisitNotesTest < ApplicationSystemTestCase
  setup do
    @visit_note = visit_notes(:one)
  end

  test "visiting the index" do
    visit visit_notes_url
    assert_selector "h1", text: "Visit Notes"
  end

  test "creating a Visit note" do
    visit visit_notes_url
    click_on "New Visit Note"

    fill_in "Body", with: @visit_note.body
    fill_in "Title", with: @visit_note.title
    click_on "Create Visit note"

    assert_text "Visit note was successfully created"
    click_on "Back"
  end

  test "updating a Visit note" do
    visit visit_notes_url
    click_on "Edit", match: :first

    fill_in "Body", with: @visit_note.body
    fill_in "Title", with: @visit_note.title
    click_on "Update Visit note"

    assert_text "Visit note was successfully updated"
    click_on "Back"
  end

  test "destroying a Visit note" do
    visit visit_notes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Visit note was successfully destroyed"
  end
end
