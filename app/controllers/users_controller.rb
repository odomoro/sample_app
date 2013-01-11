class UsersController < ApplicationController
  
  #usado para chamar um metodo antes de determinadas ações
  #(antes de todas, por default, mas pode ser limitado o escopo usando only:)
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  #usado para verificar se o usuario logado he o mesmo que será editado
  before_filter :correct_user,   only: [:edit, :update]
  #usado para permitir que apenas administradores possam executar a ação de delete
  before_filter :admin_user,     only: :destroy
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 15)
  end
  
  def new
    @user = User.new
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  
  
  
  def edit
  end

  def index
     @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
