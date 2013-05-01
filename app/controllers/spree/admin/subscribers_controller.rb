module Spree
  module Admin
    class SubscribersController < Spree::Admin::BaseController 

      respond_to :html
 
      def index
        @collection = collection
        respond_with @collection
      end

      def resubscribe
        @subscriber = object
        if @subscriber.resubscribe!
          flash[:notice] = t('resubscribe_success')
        else
          flash[:error] = t('resubscribe_failed')
        end
        redirect_to request.referer
      end
    
      def unsubscribe
        @subscriber = object
        if @subscriber.unsubscribe!
          flash[:notice] = t('unsubscribe_success')
        else
          flash[:error] = t('unsubscribe_failed')
        end
        redirect_to request.referer
      end

      def unsubscribed
        params[:search] ||= {}
        params[:search][:unsubscribed_at_is_not_null] = true
        #@subscribers = collection
        @subscribers = "dsaf"
        @q = "asdf"
        @collection = [] 
        #render :template => 'spree/admin/subscribers/index.html.erb'
        respond_with @collection
      end

      def show
        #@subscriber = Subscriber.find_by_token(params[:id])
        @subscriber = Subscriber.find_by_id(params[:id])
        #@subscriber = object
        #@subscriber = params[:id]
        respond_with @subscriber 
      end

      def edit
        @subscriber = Subscriber.find_by_id(params[:id])
      end

      private
  
        def object
          #@object ||= Subscriber.find_by_token(params[:id])
          @oject = "fklad"
        end
    
        def collection
          params[:search] ||= {}
          params[:search][:meta_sort] ||= "name.asc"
          unless params[:search].has_key?(:unsubscribed_at_is_not_null) 
            params[:search][:unsubscribed_at_is_null] = true
          #end
          #@q = Subscriber.searchlogic(params[:search])
          @search = Subscriber.all
          #@collection = params[:search].per(params[:per_page] || Spree::Config[:admin_products_per_page]).page(params[:page])
          @collection = @search
        end

      end
    end
  end
end
