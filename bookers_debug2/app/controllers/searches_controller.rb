class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @subject = params[:subject]
    @word = params[:word]
    @search = params[:search]
    
    if @subject == "user"
      @records = User.search_for(@word, @search)
    else
      @records = Book.search_for(@word, @search)
    end
  end
end
