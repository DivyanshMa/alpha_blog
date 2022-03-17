class UsersController < ApplicationController
    def new
        @user=User.new
    end
    def create 
        @user = User.new(params.require(:user).permit(:username, :email, :password))
        @user.save
        session[:user_id] = @user.id
        if @user.save
            redirect_to articles_path
        else
            render 'new'
        end

    end
    def edit
        @user = User.find(params[:id])
    end

    def update
        @user=User.find(params[:id])
        if(@user.update(params.require(:user).permit(:username, :email, :password)))
            flash[:notice]="User was edited successfully"
            redirect_to @user
        else
            render 'edit'
        end

    end
    def show
        @user=User.find(params[:id])
        @articles = @user.articles
    end
    def index
        @users=User.paginate(page:params[:page], per_page:5)
    end

    private
    def user_params
        params.require(:user).permit(:username, :password, :email)
    end

end