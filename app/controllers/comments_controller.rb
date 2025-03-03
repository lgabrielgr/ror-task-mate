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
      CommentNotificationJob.perform_later(@ticket.assignee, @comment, :created)
      redirect_to ticket_view_path(@ticket)
    else
      render "new"
    end
  end

  def edit
    set_ticket
    @comment = Comment.find_by(id: params[:comment_id])
    authorize @comment, :edit?
  end

  def update
    set_ticket
    @comment = Comment.find_by(id: params[:comment_id])
    authorize @comment, :update?
    @comment.edited = true
    if @comment.update(comment_params)
      CommentNotificationJob.perform_later(@ticket.assignee, @comment, :edited)
      redirect_to ticket_view_path(@ticket)
    else
      render "edit"
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
