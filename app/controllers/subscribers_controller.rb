class SubscribersController < Spree::StoreController

  before_filter :get_subscriber, :only => [:show, :unsubscribe, :resubscribe]
 
  def new
    @subscriber = Subscriber.new
  end
  
  def show
    return redirect_to(new_subscriber_path) unless @subscriber && @subscriber.active?
  end
  
  def create
    @subscriber = Subscriber.new
    @subscriber.email = params[:subscriber].first[1]
    if @subscriber.valid? && @subscriber.save
      flash[:notice] = t('subscribe_success')
      redirect_to root_path
    else
      subsc = Subscriber.find_by_email(params[:subscriber].first[1])
      if subsc
        flash[:error] = "user already subscribed #{subsc.email}"
      else
        flash[:error] = "failed to subscribe"
      end
      render :action => 'new'
    end
  end
  
  def unsubscribe
    if current_user.nil?
      redirect_to login_path
   #@subscriber = Subscriber.find_by_email(current_user.email)
    elsif @subscriber.unsubscribed_at.nil? && @subscriber.unsubscribe!
    #if @subscriber.email == params[:subscriber][:email] && @subscriber.unsubscribe!
      flash[:notice] = t('unsubscribe_success_public')
      redirect_to current_user ? account_path : root_path
    else
      if !@subscriber.unsubscribed_at.nil?
        flash[:error] = "already unsubscribed #{@subscriber.unsubscribed_at.nil?}"
      else
        flash[:error]  = t('unsubscribe_failed_public')    
      end
      redirect_to products_path
    end
#    render :action => 'new'
  end
  
  def resubscribe
    @subscriber = Subscriber.find_by_email(current_user.email)
    if !@subscriber.unsubscribed_at.nil? && @subscriber.resubscribe!
      flash[:notice] = t('subscribe_success_public')
      redirect_to current_user ? account_path : subscriber_path
    else
      if @subscriber && @subscriber.unsubscribed_at.nil?
        flash[:notice]  = "already subscribed"
      end

      #redirect_to resubscribe_subscriber_path(@subscriber)
      redirect_to account_path
    end
  end
  
  def subscribe
    return redirect_to new_subscriber_path unless current_user
    @subscriber = Subscriber.find_by_email(current_user.email) rescue nil
    flash[:notice] = "already subscribed"
    return redirect_to spree.account_path if @subscriber && @subscriber.active?
    @subscriber = Subscriber.new
    @subscriber.email = current_user.email
    if @subscriber.save
      flash[:notice] = t('subscribe_success_public')
      redirect_to account_path
    else
      flash[:error]  = "#{@subscriber}"
      redirect_to spree.root_path 
    end
    
  end
    
  private
  
    def get_subscriber
      @subscriber = Subscriber.find_by_email(current_user ? current_user.email : '')
      return redirect_to new_subscriber_path unless @subscriber 
    end

end
