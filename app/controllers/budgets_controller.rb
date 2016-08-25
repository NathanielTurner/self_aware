require 'modules/data_maintainer'
include DataMaintainer

class BudgetsController < ApplicationController
  before_action :set_budget, only: [ :edit, :update, :destroy]
  before_action :set_withdrawal, only: [:destroy_withdrawal]
  before_filter :authenticate_user!

  def show
  end

  def edit
  end

  def index
    @budgets = current_user.budgets
    @withdrawal = Withdrawal.new
  end

  def new
    @budget = Budget.new
  end

  def new_withdrawal
    budget = Budget.find(params[:withdrawal][:budget_id])
    @withdrawal = Withdrawal.new(withdrawal_params)
    @withdrawal.user_id = current_user.id
    if @withdrawal.save
      update_balance(budget)
      render :show, locals: { budget: budget, withdrawal: @withdrawal, notice: 'withdrawal'}
    else
      render json: @withdrawal.errors, status: :unprocessable_entity
    end
  end


  def create
    @budget = Budget.new(budget_params)
    @budget.user_id = current_user.id
    respond_to do |format|
      if @budget.save
        DataMaintainer.set_default_reset_time(@budget)
        format.html { redirect_to budgets_path, notice: 'Budget was successfully created.' }
        format.json { render :show, status: :created, location: @budget }
      else
        format.html { render :new }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to budgets_path, notice: 'Budget was successfully updated.' }
        format.json { render :show, status: :ok, location: @budget }
        format.js   { render :show, locals: { budget: budget } }
      else
        format.html { render :edit }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
        format.js   { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_path, notice: 'Budget was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_withdrawal
    budget = Budget.find_by_id(@withdrawal.budget_id)
    amount = @withdrawal.amount
    remove_withdrawal(budget, amount)
    @withdrawal.destroy
    render :show, locals: { budget: budget, amount: amount, notice: "undo" }
  end

  private
    def set_budget
      @budget = Budget.find(params[:id])
    end

    def set_withdrawal
      @withdrawal = Withdrawal.find_by_id(params[:format])
    end

    def withdrawal_params
      params.require(:withdrawal).permit(:user_id, :budget_id, :amount, :description, :type)
    end

    def budget_params
      params.require(:budget).permit(:name, :amount, :initial_amount,
                                     :weekly_limit, :monthly_limit )
    end
end
