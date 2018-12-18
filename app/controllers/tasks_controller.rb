class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    if logged_in?
      if params[:task]
        @tasks = Task.where(user_id: current_user.id)
                    .page(params[:page]).per(20)
                    .title_search(params[:task])
                    .status_choise(params[:task])
                    .priority_choise(params[:task])
                    .priority_order(params[:task])
                    .deadline_order(params[:task])
        @form_default = params[:task]
      else
        @tasks = Task.where(user_id: current_user.id)
                      .page(params[:page]).per(20)
                      .order(created_at: :desc)
      end
    else
      redirect_to new_session_path
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
    @task = Task.new(format_fix(task_params))
    if @task.save
      redirect_to @task, notice: 'タスクの保存に成功しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(format_fix(task_params))
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
    params.require(:task)
          .permit(:title,
                  :content,
                  :deadline,
                  :status,
                  :priority)
  end

  def format_fix(task_params)
    task_params[:priority] = task_params[:priority].to_i
    task_params[:user_id] = current_user.id
    return task_params
  end
end
