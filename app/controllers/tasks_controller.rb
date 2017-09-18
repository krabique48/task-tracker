class TasksController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :task, through: :project

  def show
  end

  def new
  end

  def edit
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(update_task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end


  private
  
  def task_params
    params.require(:task).permit(:title, :description, :status, :user_id)
  end
  
end
