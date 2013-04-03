class RatingsController < ApplicationController
  
  def allRatings
    @foundItems = Rating.all
    render :json => { :time=>Time.now ,:items =>@foundItems} , :content_type => 'text/json'
  end
  
  def getRatings
    @foundItems = Rating.where("created_at >= :date OR updated_at >= :date", date: params[:id])
    render :json => { :time=>Time.now ,:items =>@foundItems} , :content_type => 'text/json'
  end
  
  
  def index
  end
  
  def create
    if current_user
      @ratingArr = Rating.where("place_id = '#{params[:rating][:place_id]}' AND user_id = '#{current_user.id}'")
      if @ratingArr.empty?
          @createdRating = Rating.new(params[:rating])
          @rated_place = Place.find(params[:rating][:place_id])
          @rated_place.ratings << @createdRating
          current_user.ratings << @createdRating
          current_user.save
          @createdRating.save
          totalrating = 0 
          for rating in @rated_place.ratings
            totalrating= totalrating + rating.score
          end
          @rated_place.current_rating = totalrating/@rated_place.ratings.count
          if @rated_place.save
            render :json => {:status=>201 , :success=>true , :rating => @rated_place}
          else
            render :json => {:status => 404 , :success=>false}
          end
      else
          @rating = @ratingArr.last
          @rating.update_attributes(params[:rating])
          @rated_place = Place.find(params[:rating][:place_id])
          @rating.save
          totalrating = 0 
          for rating in @rated_place.ratings
            totalrating= totalrating + rating.score
          end
          @rated_place.current_rating = totalrating/@rated_place.ratings.count
          if @rated_place.save
            render :json => {:status=>201 , :success=>true , :rating => @rated_place}
          else
            render :json => {:status => 404 , :success=>false}
          end
      end
    else
      render :json => {:status => 404 , :success=>false , :message => "User Not Logged In"}
    end
    
  end
  
  def show
  end
  
  def new
    
    
  end
  
  def update
  end
  
  def destroy
  end
  
  def edit
  end
end
