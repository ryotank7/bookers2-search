class BooksController < ApplicationController
  before_action :authenticate_user!
   def new
  	@book = Book.new
  	@books = Book.page(params[:page]).reverse_order
    @user = User.find(params[:id])
  end

  def create
  	@book = Book.new(book_params)
  	if @book.save
      flash[:notice] = "book was successfully created "
  		redirect_to book_path(@book.id)
  	else
      @books = Book.page(params[:page]).reverse_order
  		render :new
  	end
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      flash[:notice] = "book was successfully updateed "
      redirect_to book_path(@book.id)
    else
      @books = Book.page(params[:page]).reverse_order
      render :edit
    end
  end

  def index
    @book = Book.new
    @user = User.find_by(id: @book.user_id)
    @book_comment = BookComment.new
    @books = Book.all.search(params[:search])
  end

  def show
  	@book = Book.find(params[:id])
    @user = User.find_by(id: @book.user_id)
    @book_comment = BookComment.new
    @favorite = Favorite.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
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
end
