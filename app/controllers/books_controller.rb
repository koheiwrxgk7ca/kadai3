class BooksController < ApplicationController

  def create
       @book = Book.new(book_params)
       @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book.id)
    else
       @books = Book.all
       @user = current_user
       render :index
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @book1 = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
      @book=Book.find(params[:id])
   if @book.user == current_user
      render 'edit'
   else
      redirect_to books_path
   end

  end

  def update
      @book =Book.find(params[:id])
   if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
   else
      render :edit
   end
  end

 # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end