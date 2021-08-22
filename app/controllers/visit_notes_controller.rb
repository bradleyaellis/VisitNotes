class VisitNotesController < ApplicationController
  # before_action :set_visit_note, only: %i[show edit update destroy]
  # before_action :set_patient

  def index
    @visit_notes = VisitNote.all
  end

  def show; 
    @visit_note = set_visit_note
  end

  def new
    @visit_note = VisitNote.new
  end

  def edit; 
    @visit_note = set_visit_note
  end

  def create
    @visit_note = VisitNote.new(visit_note_params)
    if @visit_note.save
      if params[:quicksave]
        render json: @visit_note, status: 200
        return false
      end

      render json: @visit_note, status: 200, notice: 'Visit note was successfully updated.'
    else
      render json: @visit_note.errors, status: :unprocessable_entity
    end
  end

  def update
    @visit_note = set_visit_note
    if @visit_note.update(visit_note_params)
      if params[:quicksave]
        render json: @visit_note, status: 200
        return
      end

      render json: @visit_note, status: 200, notice: 'Visit note was successfully updated.'
    else
      render json: @visit_note.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @visit_note = set_visit_note
    @visit_note.destroy
    respond_to do |format|
      format.html do
        redirect_to visit_notes_path, notice: "Visit note '#{@visit_note.title}' was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  # def set_patient
  #   @patient = Patient.find_by(id: params[:patient_id])
  # end

  private

  def set_visit_note
    @visit_note = VisitNote.find(params[:id])
  end

  def visit_note_params
    params.require(:visit_note).permit(:title, :body)
  end
end
