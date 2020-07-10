class VotesController < ApplicationController
  def new
  end

  def create
    @vote = User.find(session["user_id"]).votes.new(article_id: params[:article_id])

    if @vote.save
      redirect_to article_path(@vote.article_id), notice: "Vote counted!"
    else
      redirect_to article_path(@vote.article_id), alert: "You can't vote twice!"
    end
  end

  def destroy
    vote = Vote.find_by(id: params[:id], user: User.find(session["user_id"]), article_id: params[:article_id])
    if vote
      vote.destroy
      redirect_to(root_path)
    end
  end
end
