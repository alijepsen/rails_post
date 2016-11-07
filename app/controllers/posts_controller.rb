class PostsController < ApplicationController

  # showing all of the posts
  # looks for the index.html.erb template
  def index
    # is going to get all posts
    @posts = Post.all #set instance variable to active record 'command'
  end

  # showing a single post
  # looks for show.html.erb template
  def show
    # going to get a single post by ID
    @post = Post.find(params[:id]) #dynamic route matcher
  end

  # creates a new instance in memory
  # shows an empty form for user to create new post
  def new
    @post = Post.new #creates new instance of the/a post
    #since it's only creating an instance in memory have to create/post method create blw
  end

  # runs the sql query to add a new post to the db
  # redirects or renders depending on outcome
  # There is NO view associated with this method
  def create
    #binding.pry
    # saving the post w/the form values into the database
    @post = Post.new(post_params) #call a new method as params - post in memory
    if @post.save #making active record call to see if we saved in db
      redirect_to post_path(@post) #look at rake routes bundle exec rake routes read right left; rails is smart enough that u don't need @post.id
    else
      # unsuccessful create attempt
      render :new #render new page (most basic flow here)
    end
  end

  # finds a single post in the db
  # looks for the edit.html.erb template and renders it
  def edit
    @post = Post.find(params[:id]) #find the post
  end

  # responsible for finding a post in the db
  # trying to update that post with the given params
  # either redirects or render depending on outcome
  # NO view associated with this method!!
  def update #db edits
    @post = Post.find(params[:id])
    if @post.update(post_params) #calling update not edit, not create
      # successful update in db
      redirect_to post_path(@post)
    else
      # unsuccessful db update
      render :edit #take back to where they started
    end
  end

  # finds a single post in the db
  # removes that record (if found)
  # redirects to the index method
  # this method has NO view associated with it!!
  def destroy
    @post = Post.find(params[:id]) #find post
    @post.destroy # destory via delete action
    redirect_to posts_path #could do root or index but since we're in posts_controller
  end

  private #can't do anything with it outside of this file
    # this is a rails 5 thing called strong params
    def post_params
      params.require(:post).permit(:title, :body, :author, :public) #allows a post to only be submitted with these params - can break the parentheses into multiple lines
    end # copy params.require(:post) into binding.pry - why strong params matter

end
