class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_check
  before_action :correct_user_check, except: [:index, :new, :create]

  def index
    if params[:task]
      @tasks = Task.includes(:stuck_labels)
                  .where(user_id: current_user.id)
                  .title_search(params[:task])
                  .status_choise(params[:task])
                  .priority_choise(params[:task])
                  .label_search(params[:task])
                  .priority_order(params[:task])
                  .deadline_order(params[:task])
                  .page(params[:page]).per(20)
      @form_default = params[:task]
    else
      @tasks = Task.includes(:stuck_labels)
                    .where(user_id: current_user.id)
                    .order(created_at: :desc)
                    .page(params[:page]).per(20)
    end
  end

  def show
  end

  def new
    @task = Task.new
    # params[:back] というのはRailsに用意されてないので不要
  end

  def create
    # @task = Task.new(format_fix(task_params))
    @task = current_user.tasks.new(task_params)
    if @task.save
      label_maker(@label) unless @label.nil?
      redirect_to @task, notice: 'タスクの保存に成功しました'
    else
      render :new
      # ラベルが消えてるよ
    end
  end

  def edit
  end

  def update
    if @task.update(format_fix(task_params))
      label_maker(@label) unless @label.nil?
      redirect_to @task, notice: 'タスクの編集に成功しました'
    else
      render :edit
    end
  end

  def destroy
    if params[:label_id]
      relation = TaskLabelRelation.find_by(task_id: params[:id],label_id: params[:label_id])
      relation.destroy
      redirect_to edit_task_path(id: params[:id])
    else
      @task.destroy
      redirect_to "/", notice: 'タスクの削除に成功しました'
    end
  end

  private
  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def logged_in_check
    redirect_to new_session_path unless logged_in?
  end

  # 不要になる
  def correct_user_check
    redirect_to root_path if @task.user_id != current_user.id
  end

  def task_params
    params.require(:task)
          .permit(:title,
                  :content,
                  :deadline,
                  :status,
                  :priority,
                  :label
                  )
  end

  def format_fix(task_params)
    @label = task_params[:label] unless task_params[:label] == ""
    task_params.delete(:label)
    task_params[:priority] = task_params[:priority].to_i
    # task_params[:user_id] = current_user.id #不要
    return task_params
  end

  # 以下の処理は不要になる。
  # accepts_nested_attributes_for を使ったFormの作り方がある。
  # その形に直した方がいいよ。
  # params{task: {label_attributes: ['aaa','bbb', 'ccc']}} イメージ
  def label_maker(label_text)
    scaned_labels = label_text.scan(/[^ 　\r\n]+/)
    scaned_labels.each do |la|
      if Label.exists?(name: la)
        a = Label.find_by(name: la)
        TaskLabelRelation.create(task_id: @task.id, label_id: a.id) unless @task.stuck_labels.exists?(id: a.id)
      else
        lab = Label.new(name: la)
        lab.save
        TaskLabelRelation.create(task_id: @task.id, label_id: lab.id)
      end
    end
  end
end
