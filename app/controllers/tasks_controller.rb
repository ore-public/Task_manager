class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    @tasks = Task.all.order(id: :desc)
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
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: 'タスクの保存に成功しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'タスクの編集に成功しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root, notice: 'タスクの削除に成功しました'
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content)
  end
end
