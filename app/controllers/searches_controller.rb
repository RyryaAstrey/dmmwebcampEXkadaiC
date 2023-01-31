class SearchesController < ApplicationController
  
  def search
    @range = params[:range]
    
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
      redirect_to search_result_path
    else
      @books = Book.looks(params[:search], params[:word])
      redirect_to search_result_path
    end
  end
  
  def search_result
    @users = User.all
    @books = Book.all
  end
end
