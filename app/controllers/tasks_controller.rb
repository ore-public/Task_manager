class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    if params[:task]
      @tasks = Task.all.title_search(params[:task]).status_choise(params[:task]).priority_choise(params[:task]).deadline_order(params[:task])
    else
      @tasks = Task.all.order(created_at: :desc)
    end
  end

  def show
  end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = Task.new(priority_int(task_params))
    if @task.save
      redirect_to @task, notice: 'タスクの保存に成功しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(priority_int(task_params))
      redirect_to @task, notice: 'タスクの編集に成功しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to "/", notice: 'タスクの削除に成功しました'
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end

  def priority_int(task_params)
    task_params[:priority] = task_params[:priority].to_i
    return task_params
  end
end
