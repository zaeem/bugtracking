class ProjectsController < ApplicationController

    def index
        @user = current_user
        @projects = current_user.projects
        @count = @projects.count
    end

    def new 
        @project = Project.new
    end

    def create
        @project = Project.new(project_params)
        @project.user_id = current_user.id
        
        if @project.save
            flash[:success] = "Sucessfully Created #{@project.project_name}"
            redirect_to action: "index"
        else      
            flash[:danger] = "#{@project.errors.full_messages}"
            redirect_to action: "new"
        end
    end

    def destroy
        @project = Project.find(params[:id])
        if(@project.user_id = current_user.id)
            @project.delete
            flash[:success] = "Sucessfully deleted #{@project.project_name}"
            redirect_to action: "index"
        else
            flash[:danger] = "You Don't have right to delete #{@project.project_name}"
            redirect_to action: "index"
        end
    end

    def edit

        @project = Project.find(params[:id])

        if(@project.user_id != current_user.id)
            flash[:danger] = "you don't have permission to change #{@project.project_name}"
            redirect_to action: "index"
        end
    end

    def update

        @project = Project.find(params[:id])
 
        if @project.update(project_params)
            flash[:success] = "Sucessfully Updated #{@project.project_name}"
            redirect_to action: "index"
        else
            flash[:danger] = "#{@project.errors.full_messages}"
            redirect_to action: "edit"
        end

    end

    def show
        @project = Project.find(params[:id])
        @users = User.all
    end


    
    def project_params
        params.require(:project).permit(:project_name , :description, current_user) 
    end
end