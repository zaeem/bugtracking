class TasksController < ApplicationController

    helper_method :is_manager , :is_developer , :is_qa


    def index
        
        @project = Project.find(params[:project_id])
        
        if current_user.user_type == "Developer"
            @tasks = @project.tasks.where(resolver_id: current_user.id)
            @count = @tasks.count
        else
            @tasks = @project.tasks
            @count = @tasks.count
        end
    end


    def new
        if is_developer
            flash[:danger] = "you don't have right to create new task"
            redirect_to action: "index"
        end
        @project = Project.find(params[:project_id])
        @developer = User.where(user_type: "Developer")
        @count1 = @developer.count
        if @count1 == 0
            flash[:danger] = "you don't have any developer yet"
            redirect_to action: "index"
        end
        @developer_array = @developer.map { |dev| [dev.email, dev.email] } 
        @task = Task.new
    end

  
    def create
        if is_developer
            flash[:danger] = "you don't have right to create new task"
            redirect_to action: "index"
        end

        @project = Project.find(params[:project_id])
        @user = current_user
        @resolver = User.where(email: params[:developer]).first
        @task = Task.new
        @task.description = params[:description]
        @task.title = params[:title]
        @task.task_category = params[:task_category] 
        @task.status = "new"
        @task.project_id = @project.id
        @task.creator_id = @user.id
        @task.resolver_id = @resolver.id
        @task.avatar = params[:avatar]

        puts "ell\n"
        puts params[:file]

        if @task.save
            if !UserProject.where(user_id: @resolver.id, project_id: @project.id).first
                @user_project = UserProject.create(user: @resolver, project: @project)
            end
            flash[:success] = "Task has been Created Successfully"
            redirect_to action: "index"
            
        else      
            flash[:danger] = "#{@task.errors.full_messages}"
            redirect_to action: "new"
        end
    end


    def destroy  
        @task = Task.find(params[:id])
        @project = Project.find(params[:project_id])

        if is_developer || @task.creator_id != current_user.id
            flash[:danger] = "you don't have right to delete task"
            redirect_to action: "index"
        else

            @task.delete
            @assignedUser = User.find(@task.resolver_id)
            @assignedTaskscount = @assignedUser.resolved_tasks.count
            if @assignedTaskscount==0
                @user_project = UserProject.where(user_id: @assignedUser.id, project_id: @project.id).first
                @user_project.delete
            end
            flash[:success] = "Sucessfully deleted #{@task.title}"
            redirect_to action: "index"
        end
    end


    def edit
        @task = Task.find(params[:id])
        if @task.resolver_id!= current_user.id && @task.creator_id != current_user.id
            flash[:danger] = "you don't have right to edit this task"
            redirect_to action: "index"
        end

        @project = Project.find(params[:project_id])
        @resolver = User.where(id: @task.resolver_id).first
    end


    def update
        @task = Task.find(params[:id])
        if @task.resolver_id!= current_user.id && @task.creator_id != current_user.id
            flash[:danger] = "you don't have right to edit this task"
            redirect_to action: "index"
        else

            if @task.resolver_id != current_user.id

                if @task.update(description: params[:description] , title: params[:title] , status: params[:task_status])
                    flash[:success] = "Task has been updated Successfully"
                    redirect_to action: "index"
                    
                else      
                    flash[:danger] = "#{@task.errors.full_messages}"
                    redirect_to action: "edit"
                end
            else

                if @task.update(status: params[:task_status])
                    flash[:success] = "Task has been updated Successfully"
                    redirect_to action: "index"
                    
                else      
                    puts "hell \n" *12
                    puts @task.title
                    flash[:danger] = "#{@task.errors.full_messages}"
                    redirect_to action: "edit"
                end
            end

        end
    end


    def show 
        @task = Task.find(params[:id])
        if @task.resolver_id!= current_user.id && @task.creator_id != current_user.id
            flash[:danger] = "you don't have right to create new task"
            redirect_to action: "index"
        end
        @project = Project.find(params[:project_id])
        @task = Task.find(params[:id])
    end


    def task_params
        params.require(:task).permit(:title , :description) 
    end


    def is_manager
        current_user.user_type == "Manager"
    end

    def is_developer
        current_user.user_type == "Developer"
    end

    def is_qa
        current_user.user_type == "QA"
    end

end