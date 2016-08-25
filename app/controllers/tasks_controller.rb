class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!

  def history
    @to_dos = current_user.tasks.where(completed: true, style: 'to_do')
    @habits = current_user.tasks.where(style: "habit")
  end

  def set_submit
    @submit = Submit.new(submit_params)
    @submit.user_id = current_user.id
      if @submit.save

        render json: { status: :created, location: @submit }
      end
  end

  def index
    @habits = current_user.tasks.where(style: "habit")
    @to_dos = current_user.tasks.where(style: "to_do", completed: false)
    @task = Task.new
    @task.submits.build
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
        format.js   { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.js   { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
        format.js   { render layout: false }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.js   { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render layout: false }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:sunday, :monday, :tuesday, :wednesday,
                                   :thursday, :friday, :saturday, :style,
                                   :due_date, :user_id, :title, :description,
                                   :assigned_by, :risk, :difficulty, :type,
                                   :completed, :completed_on, :home_page,
                                   :reminder_type, :submitted, :submit_count,
                                   :consecutive_submits, :consecutive_record,
                                   :performance, :over_due,
                                   submits_attributes: [:id, :user_id,
                                   :task_id, :_destroy, :on_time, :week_day, :on_repeat])
    end

    def submit_params
      params.require(:submit).permit(:user_id, :task_id, :on_time, :week_day, :on_repeat)
    end
end
