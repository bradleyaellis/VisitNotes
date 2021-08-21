require "test_helper"

class VisitNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @visit_note = visit_notes(:one)
  end

  test "should get index" do
    get visit_notes_url
    assert_response :success
  end

  test "should get new" do
    get new_visit_note_url
    assert_response :success
  end

  test "should create visit_note" do
    assert_difference('VisitNote.count') do
      post visit_notes_url, params: { visit_note: { body: @visit_note.body, title: @visit_note.title } }
    end

    assert_redirected_to visit_note_url(VisitNote.last)
  end

  test "should show visit_note" do
    get visit_note_url(@visit_note)
    assert_response :success
  end

  test "should get edit" do
    get edit_visit_note_url(@visit_note)
    assert_response :success
  end

  test "should update visit_note" do
    patch visit_note_url(@visit_note), params: { visit_note: { body: @visit_note.body, title: @visit_note.title } }
    assert_redirected_to visit_note_url(@visit_note)
  end

  test "should destroy visit_note" do
    assert_difference('VisitNote.count', -1) do
      delete visit_note_url(@visit_note)
    end

    assert_redirected_to visit_notes_url
  end
end
