class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:create, :destroy]

  def index
     @posts = Post.order("id DESC").limit(20)

     if params[:max_id]
       @posts = @posts.where( "id < ?", params[:max_id])
     end

     respond_to do |format|
       format.html  # 如果客户端要求 HTML，则回传 index.html.erb
       format.js    # 如果客户端要求 JavaScript，回传 index.js.erb
     end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save

    # redirect_to posts_path
  end

  def update
    @post = Post.find(params[:id])
    @post.update!( post_params )

    render :json => { :id => @post.id, :message => "ok"}
  end

  def like
    @post = Post.find(params[:id])
    unless @post.find_like(current_user)
      Like.create( :user => current_user, :post => @post )
    end
    # redirect_to posts_path
  end

  def unlike
    @post = Post.find(params[:id])
    like = @post.find_like(current_user)
    like.destroy

    # redirect_to posts_path
    render "like"
  end

  def fav
    @post = Post.find(params[:id])
    if !current_user.fav_post?(@post)
      current_user.fav!(@post)
    #   flash[:notice] = "收藏#{@post}成功"
    # else
    #   flash[:warning] = "您已收藏过该产品"
    end
    # unless @post.find_fav(current_user)
    #   Fav.create( :user => current_user, :post => @post )
    # end
  end

  def unfav
    @post = Post.find(params[:id])
    if current_user.fav_post?(@post)
      current_user.unfav!(@post)
    #   flash[:alert] = "取消收藏"
    # else
    #   flash[:warning] = "没有收藏，不用取消"
    end
    render "fav"
    # fav = @post.find_fav(current_user)
    # fav.destroy
    #
    # render "fav"
  end

  def destroy
    @post = current_user.posts.find(params[:id])  #只能删除自己的文章
    @post.destroy
    # redirect_to posts_path
    # render :js => "alert('ok');"
    render :json => { :id => @post.id }
  end


  def toggle_flag
    @post = Post.find(params[:id])

    if @post.flag_at
      @post.flag_at = nil
    else
      @post.flag_at = Time.now
    end

    @post.save!

    render :json => { :message => "ok", :flag_at => @post.flag_at, :id => @post.id }
  end

  protected

  def post_params
    params.require(:post).permit(:content, :category_id)
  end
end
