class PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    @post.author = current_user
    
    if @post.save!
      redirect_to workout_path(@post.subject.workout, activity: @post.subject.id), notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to workout_path(@post.subject.workout, activity: @post.subject.id), notice: "Post was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private
    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body, :subject_id, :subject_type)
    end
end
