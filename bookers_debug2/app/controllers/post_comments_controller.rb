class PostCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.books.new(book_params)
    comment.book_id = book.id
    book.save
    redirect_to book_path(book)
  end
  
  def destroy
    book = book.find(params[:book_id])
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to book_path(book)
  end
end
