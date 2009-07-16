class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    if @user.save
      Profile.create(params[:profile].merge(:user_id => @user.id))
      flash[:notice] = 'Cadastro realizado com sucesso!'
      redirect_to home_url
    else
      flash[:error] = 'Dados inválidos.'
      render :new
    end
  end
end
