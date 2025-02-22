class CommentsController < ApplicationController
  def new
    set_ticket
    @comment = Comment.new(ticket: @ticket)
    authorize @comment, :new?
  end

  def create
    set_ticket
    @comment = Comment.new(comment_params)
    @comment.ticket = @ticket
    @comment.author = current_user
    authorize @comment, :create?
    if @comment.save
      redirect_to ticket_view_path(@ticket)
    else
      render "new"
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
