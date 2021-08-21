class VisitNotesController < ApplicationController
  before_action :set_visit_note, only: [:show, :edit, :update, :destroy]

  def index
    @visit_notes = VisitNote.where(patient_id: params[:patient_id])
  end

  def show
    @visit_note
  end

  def new
    @visit_note = VisitNote.new
  end

  def edit
  end

  def create
    @visit_note = VisitNote.new(visit_note_params)

    respond_to do |format|
      if @visit_note.save
        format.html { redirect_to @visit_note, notice: "Visit note was successfully created." }
        format.json { render :show, status: :created, location: @visit_note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @visit_note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    Rails.logger.debug quicksave.inspect
      if @visit_note.update(visit_note_params)
        format.html { redirect_to @visit_note, notice: "Visit note was successfully updated." }
        format.json { render :show, status: :ok, location: @visit_note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @visit_note.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @visit_note.destroy
    respond_to do |format|
      format.html { redirect_to visit_notes_url, notice: "Visit note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_visit_note
      @visit_note = VisitNote.find(params[:id])
    end
  
    def visit_note_params
      params.require(:visit_note).permit(:title, :body)
    end
end
