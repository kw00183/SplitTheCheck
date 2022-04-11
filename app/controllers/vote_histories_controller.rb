class VoteHistoriesController < ApplicationController
  before_action :set_vote_history, only: %i[ show ]
  before_action :restrict_destroy_edit, only: [:edit, :update, :destroy]

  # GET /vote_histories or /vote_histories.json
  def index
    @vote_histories = VoteHistory.all
  end

  # GET /vote_histories/1 or /vote_histories/1.json
  def show
  end

  # GET /vote_histories/new
  def new
    @vote_history = VoteHistory.new
  end

  # GET /vote_histories/1/edit
  def edit
  end

  # POST /vote_histories or /vote_histories.json
  def create
    @vote_history = VoteHistory.new(vote_history_params)

    respond_to do |format|
      if @vote_history.save
        format.html { redirect_to vote_history_url(@vote_history), notice: "Vote history was successfully created." }
        format.json { render :show, status: :created, location: @vote_history }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vote_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vote_histories/1 or /vote_histories/1.json
  def update
    respond_to do |format|
      if @vote_history.update(vote_history_params)
        format.html { redirect_to vote_history_url(@vote_history), notice: "Vote history was successfully updated." }
        format.json { render :show, status: :ok, location: @vote_history }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vote_histories/1 or /vote_histories/1.json
  def destroy
    @vote_history.destroy

    respond_to do |format|
      format.html { redirect_to vote_histories_url, notice: "Vote history was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote_history
      @vote_history = VoteHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_history_params
      params.require(:vote_history).permit(:user_id, :restaurant_id, :vote_split)
    end
end
