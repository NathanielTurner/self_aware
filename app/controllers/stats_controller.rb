class StatsController < ApplicationController
  before_action :set_stat, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /stats
  # GET /stats.json
  def index
    @budgets = current_user.budgets
    @withdrawals = current_user.withdrawals
    @submits = current_user.submits
    @to_dos = current_user.tasks.where(style: 'to_do')
    @stat = current_user.stat
  end

  # GET /stats/1
  # GET /stats/1.json
  def show
  end

  # GET /stats/new
  def new
    @stat = Stat.new
  end

  # GET /stats/1/edit
  def edit
  end

  # POST /stats
  # POST /stats.json
  def create
    @stat = Stat.new(stat_params)

    respond_to do |format|
      if @stat.save
        format.html { redirect_to @stat, notice: 'Stat was successfully created.' }
        format.json { render :show, status: :created, location: @stat }
      else
        format.html { render :new }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stats/1
  # PATCH/PUT /stats/1.json
  def update
    respond_to do |format|
      if @stat.update(stat_params)
        format.html { redirect_to @stat, notice: 'Stat was successfully updated.' }
        format.json { render :show, status: :ok, location: @stat }
      else
        format.html { render :edit }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stats/1
  # DELETE /stats/1.json
  def destroy
    @stat.destroy
    respond_to do |format|
      format.html { redirect_to stats_url, notice: 'Stat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stat
      @stat = Stat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stat_params
      params.require(:stat).permit(:user_id, :nightmare_habit_ratio, :vhard_habit_ratio, :hard_habit_ratio, :nomral_habit_ratio, :easy_habit_ratio, :nightmare_todo_ratio, :vhard_todo_ratio, :hard_todo_ratio, :normal_todo_ratio, :easy_todo_ratio, :best_habit, :worst_habit_string, :best_todo, :worst_todo, :monthly_budget_ratio, :weekly_budget_ratio, :spent_per_day, :most_spent)
    end
end
