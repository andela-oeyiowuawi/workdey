class TasksManagementsController < ApplicationController
  def index
    @tasks = current_user.tasks_created
  end

  def show
  end

  def update
    id = params[:task_id]
    if TaskManagement.update(id, status: "done")
      if review_and_rate(params)
        flash[:notice] = "Task is completed and your reveiw has been recorded."
      else
        flash[:notice] = "Task is completed."
      end
    else
      flash[:alert] = "Operation failed."
    end
    redirect_to dashboard_path
  end

  private

  def review_and_rate(params)
    review = Review.new
    review.rating = params[:rating] if params[:rating]
    review.review = params[:comment] if params[:comment]
    return "success" if review.save
  end

  def general_rating(user_id)
    rating = 0
    user_ratings = Review.where(user_id: user_id)
    user_ratings.select { |user| rating += user.rating }
    user_ratings.empty? ? 0 : rating / (user_ratings.count)
  end
end
