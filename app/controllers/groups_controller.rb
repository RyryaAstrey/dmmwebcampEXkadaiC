class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def new
    @group=Group.new
  end
  
  def index
    @book = Book.new
    @groups = Group.all
  end
  
  def show
    @book=Book.new
    @group=Group.find(params[:id])
    owner=@group.owner_id
    @user=User.find(owner)
  end
  
  def edit
  end
  
  def create
    @group=Group.new(group_params)
    @group.owner_id=current_user.id
    if @group.save
      redirect_to group_path(@group.id)
    else
      render 'new'
    end
  end
  
  def update
    if @group.update(group_params)
      redirect_to group_path(@group.id)
    else
      render 'edit'
    end
  end
  
  def destroy
    @group.destroy
    redirect_to groups_path
  end
  
  def new_mail
    @group=Group.find(params[:group_id])
  end
  
  def send_mail
    @group=Group.find(params[:group_id])
    group_users=@group.users
    @mail_title=params[:mail_title]
    @mail_content=params[:mail_content]
    ContactMailer.send_mail(@mail_title, @mail_content,group_users).deliver
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end
  
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
