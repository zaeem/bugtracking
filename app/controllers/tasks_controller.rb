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
        @task = Task.new('title' => params[:title], 'description' => params[:description], 'type' => params[:type] )
        if @task.save
            
        else      
            flash[:danger] = "#{@task.errors.full_messages}"
            redirect_to action: "new"
        end
    end



end