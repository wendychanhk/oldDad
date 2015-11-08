require "rubygems"
require "braintree"

class UsersController < ApplicationController
	before_action :authenticate_user!


 #  named_scope :without_user, lambda{|user| user ? {:conditions => ["id != ?", user.id]} : {} }
  # GET /users
  def index
    @conversations = Conversation.involving(current_user).order("created_at DESC")
    @users = User.all_except(current_user)
end

def clienttoken
   @clientToken = Braintree::ClientToken.generate
end 

def checkout
  nonce = params[:payment_method_nonce]

  result = Braintree::Transaction.sale(
  :amount => "10",
  :payment_method_nonce => nonce
)
end

  # GET /users/1
  def show
    @users = User.all

  end

  # GET /users/new
  def new
    @user = User.new

  end

  # GET /users/1/edit
  def edit
    @user = current_user
    
  end

  def profile
    @user = current_user
    render 'users/profile'
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user = current_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end



  private
  
  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :country_code, :city, :introduction, :avatar, :birthday, {:interest => []})
  end
end



