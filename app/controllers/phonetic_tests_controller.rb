class PhoneticTestsController < ApplicationController
  # ユーザがログインしていないと書き換えできない
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  #
  before_action :set_phonetic_test, only: [:show, :edit, :update, :destroy]

  # GET /phonetic_tests
  # GET /phonetic_tests.json
  def index
    @phonetic_tests = PhoneticTest.all
  end

  # GET /phonetic_tests/1
  # GET /phonetic_tests/1.json
  def show
  end

  # GET /phonetic_tests/new
  def new
    @phonetic_test = PhoneticTest.new
  end

  # GET /phonetic_tests/1/edit
  def edit
  end

  # POST /phonetic_tests
  # POST /phonetic_tests.json
  def create
    @phonetic_test = PhoneticTest.new(phonetic_test_params)

    respond_to do |format|
      if @phonetic_test.save
        format.html { redirect_to @phonetic_test, notice: 'Phonetic test was successfully created.' }
        format.json { render :show, status: :created, location: @phonetic_test }
      else
        format.html { render :new }
        format.json { render json: @phonetic_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phonetic_tests/1
  # PATCH/PUT /phonetic_tests/1.json
  def update
    respond_to do |format|
      if @phonetic_test.update(phonetic_test_params)
        format.html { redirect_to @phonetic_test, notice: 'Phonetic test was successfully updated.' }
        format.json { render :show, status: :ok, location: @phonetic_test }
      else
        format.html { render :edit }
        format.json { render json: @phonetic_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phonetic_tests/1
  # DELETE /phonetic_tests/1.json
  def destroy
    @phonetic_test.destroy
    respond_to do |format|
      format.html { redirect_to phonetic_tests_url, notice: 'Phonetic test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phonetic_test
      @phonetic_test = PhoneticTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phonetic_test_params
      params.require(:phonetic_test).permit(:question, :cand1, :cand2, :cand3, :answer)
    end
end
