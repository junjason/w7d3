class UsersController < ApplicationController
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def destroy
        user = User.find(params[:id])
        if user&.destroy
            flash.now[:messages] = ["User successfully deleted"]
            redirect_to users_url
        else
            flash.now[:errors] = ["User not found"]
            redirect_to users_url
        end
    end

    def index
        @users = User.all
        render :index
    end

    def new
        @user = User.new
        render :new
    end

    def show
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end
