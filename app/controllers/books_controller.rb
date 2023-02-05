class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @books = Book.new
    @book_comment = BookComment.new
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
    # showアクションを実行した時、ViewCountテーブルの中に（）の中と一致するレコードが見つからなかった時、↓を実行
      current_user.view_counts.create(book_id: @book.id)
      # ※ViewCount.create(user_id: current_user.id, book_id: @book.id)と同じ意味
      # ViewCountテーブルの中のuser_idカラムにcurrent_user.idを当てはめ、book_idに@book.idを当てはめてレコードを作成
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @favorites = Book.includes(:favorite_users).sort {|b,a| a.favorite_users.size <=> b.favorite_users.size}
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
    @user=@book.user
    redirect_to(books_path) unless @user == current_user
  end
  
end
