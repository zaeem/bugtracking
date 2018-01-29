class ProjectsController < ApplicationController
    helper_method :is_manager , :is_developer , :is_qa

    def index
        @user = current_user
        @projects = current_user.projects
        @count = @projects.count
    end

    def new 
        if !is_manager
            flash[:danger] = "You don't have right to create project"
            redirect_to action: "index"
        end
        @project = Project.new
    end

    def create
        if is_manager
            @project = Project.new(project_params)
            @project.creator_id = current_user.id
            if @project.save
                @user_project = UserProject.new
                @user_project.user_id = current_user.id
                @user_project.project_id = @project.id
                @user_project.save
                flash[:success] = "Sucessfully Created #{@project.project_name}"
                redirect_to action: "index"
            else      
                flash[:danger] = "#{@project.errors.full_messages}"
                redirect_to action: "new"
            end
        else      
            flash[:danger] = "You don't have right to create project"
            redirect_to action: "index"
        end
    end

    def destroy
        @project = Project.find(params[:id])
        if is_manager && @project.creator_id == current_user.id
            @project = Project.find(params[:id])
            Project.find(@project).destroy
            flash[:success] = "Sucessfully deleted #{@project.project_name}"
            redirect_to action: "index"
        else      
            flash[:danger] = "You don't have right to destroy project"
            redirect_to action: "index"
        end
    end

    def edit
        @project = Project.find(params[:id])
        if !is_manager || @project.creator_id != current_user.id
            flash[:danger] = "You don't have right to edit project"
            redirect_to action: "index"
        end
        
    end

    def update
        @project = Project.find(params[:id])
        if is_manager || @project.creator_id != current_user.id
            
            if @project.update(project_params)
                flash[:success] = "Sucessfully Updated #{@project.project_name}"
                redirect_to action: "index"
            else
                flash[:danger] = "#{@project.errors.full_messages}"
                redirect_to action: "edit"
            end
        else      
            flash[:danger] = "You don't have right to update project"
            redirect_to action: "index"
        end
    end

    def show
        @project = Project.find(params[:id])
        if is_manager || @project.creator_id == current_user.id
            
            @existing_users = @project.users
            @count1 = @existing_users.count
            if @count1>0
                @existing_users.reject {|u| u.id == current_user.id}
                @count1 = @count1 -1
            end
        else      
            flash[:danger] = "You don't have right to see info of project"
            redirect_to action: "index"
        end
    end
    
    def project_params
        params.require(:project).permit(:project_name , :description) 
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