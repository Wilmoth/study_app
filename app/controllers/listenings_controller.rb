class ListeningsController < ApplicationController
  before_action :set_listening, only: [:show, :edit, :update, :destroy]

  # GET /listenings
  # GET /listenings.json
  def index
    @listenings = Listening.all
  end

  # GET /listenings/1
  # GET /listenings/1.json
  def show
  end

  # GET /listenings/new
  def new
    @listening = Listening.new
  end

  # GET /listenings/1/edit
  def edit
  end

  # POST /listenings
  # POST /listenings.json
  def create
    @listening = Listening.new(listening_params)

    respond_to do |format|
      if @listening.save
        format.html { redirect_to @listening, notice: 'Listening was successfully created.' }
        format.json { render :show, status: :created, location: @listening }
      else
        format.html { render :new }
        format.json { render json: @listening.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listenings/1
  # PATCH/PUT /listenings/1.json
  def update
    respond_to do |format|
      if @listening.update(listening_params)
        format.html { redirect_to @listening, notice: 'Listening was successfully updated.' }
        format.json { render :show, status: :ok, location: @listening }
      else
        format.html { render :edit }
        format.json { render json: @listening.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listenings/1
  # DELETE /listenings/1.json
  def destroy
    @listening.destroy
    respond_to do |format|
      format.html { redirect_to listenings_url, notice: 'Listening was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listening
      @listening = Listening.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listening_params
      params.require(:listening).permit(:level, :question, :cand1, :cand2, :cand3, :answer)
    end
end
