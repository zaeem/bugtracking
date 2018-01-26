class TasksController < ApplicationController

    def index
        @project = Project.find(params[:project_id])
        @tasks = @project.tasks
    end


    def new
        @project = Project.find(params[:project_id])
        @task = Task.new
    end

    def create
        @project = Project.find(params[:project_id])
        @user = current_user

        @task = Task.new
        @task.description = params[:description]
        @task.title = params[:title]
        @task.task_category = params[:task_category] 
        @task.status = "new"

        if @task.save
            flash[:danger] = "#{@task.errors.full_messages}"
            redirect_to action: "new"
            
        else      
            flash[:danger] = "#{@task.errors.full_messages}"
            redirect_to action: "new"
        end
    end



end