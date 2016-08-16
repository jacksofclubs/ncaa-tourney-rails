class BracketsController < ApplicationController
  before_action :set_bracket, only: [:show, :edit, :update, :destroy]

  # GET /brackets
  # GET /brackets.json
  def index
    @brackets = Bracket.all
  end

  # GET /brackets/1
  # GET /brackets/1.json
  def show
  end

  # GET /brackets/new
  def new
    @bracket = Bracket.new
  end

  # GET /brackets/1/edit
  def edit
  end

  # POST /brackets
  # POST /brackets.json
  def create
    @bracket = Bracket.new(bracket_params)

    respond_to do |format|
      if @bracket.save
        format.html { redirect_to @bracket, notice: 'Bracket was successfully created.' }
        format.json { render :show, status: :created, location: @bracket }
      else
        format.html { render :new }
        format.json { render json: @bracket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brackets/1
  # PATCH/PUT /brackets/1.json
  def update
    respond_to do |format|
      if @bracket.update(bracket_params)
        format.html { redirect_to @bracket, notice: 'Bracket was successfully updated.' }
        format.json { render :show, status: :ok, location: @bracket }
      else
        format.html { render :edit }
        format.json { render json: @bracket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brackets/1
  # DELETE /brackets/1.json
  def destroy
    @bracket.destroy
    respond_to do |format|
      format.html { redirect_to brackets_url, notice: 'Bracket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def selectparticipants
    @participants = Participant.all
  end

  def selectteams
    @teams = Team.all
    @teams_options = Team.all.map{ |t| [ t.school_name, t.id ] }
    @regions_options = Region.all
  end

  def activateteams
    # creates SQL statement similar to the following:
    # UPDATE Participants SET playing = true where id IN participant_ids[];
    Participant.update_all(playing: false)
    Participant.where(id: params[:participant_ids]).update_all(playing: true)
    redirect_to brackets_selectteams_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bracket
      @bracket = Bracket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bracket_params
      params.require(:bracket).permit(:round_of_tourny, :active)
    end
end
