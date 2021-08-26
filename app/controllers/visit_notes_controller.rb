class VisitNotesController < ApplicationController
  before_action :set_visit_note, only: [:show, :edit, :update, :destroy]
  before_action :set_patient

  def index
    @visit_notes = VisitNote.where(patient_id: params[:patient_id])
  end

  def show
  end

  def new
    @visit_note = VisitNote.new
  end

  def edit
    Rails.logger.debug @visit_note.visit_note_words.inspect
  end

  def create
    @visit_note = VisitNote.new(visit_note_params)
    @visit_note.patient_id = params[:patient_id]

    if @visit_note.save
      if params[:quicksave]
        Rails.logger.debug "#{@visit_note.inspect} QUICKSAVED"
        render json: @visit_note
        return false
      end

      render json: @visit_note, status: 200, notice: "Visit note was successfully updated." 
    else
      render json: @visit_note.errors, status: :unprocessable_entity 
    end
  end

  def update
      if @visit_note.update(visit_note_params)
        if params[:quicksave] 
          render json: @visit_note, status: 200 
          return 
        end

        render json: @visit_note, status: 200, notice: "Visit note was successfully updated." 
      else
        render json: @visit_note.errors, status: :unprocessable_entity 
      end
  end

  def destroy
    @visit_note.destroy
    respond_to do |format|
      format.html { redirect_to patient_visit_notes_url(params[:patient_id]), notice: "Visit note '#{@visit_note.title}' was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def set_patient 
    @patient = Patient.find_by(id: params[:patient_id])
  end

  private
    def set_visit_note
      @visit_note = VisitNote.includes(:visit_note_words).find_by(id: params[:id])
    end
  
    def visit_note_params
      params.require(:visit_note).permit(:title, :body)
    end


end
