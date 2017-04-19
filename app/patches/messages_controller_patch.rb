require_dependency 'messages_controller'

module MatsukeiRedmine
  module MessagesControllerPatch
    unloadable

    extend ActiveSupport::Concern

    included do
      unloadable

      alias_method_chain :show, :wants_replies_in_reverse_order
    end

    # Show a topic and its replies
    def show_with_wants_replies_in_reverse_order
      page = params[:page]
      # Find the page of the requested reply
      replies_order = User.current.wants_replies_in_reverse_order? ? 'DESC' : 'ASC'
      @replies =  @topic.children.
        includes(:author, :attachments, {:board => :project}).
        reorder("#{Message.table_name}.created_on #{replies_order}, #{Message.table_name}.id #{replies_order}")

      if params[:r] && page.nil?
        offset = @replies.pluck(:id).index(params[:r].to_i)
        page = 1 + offset / MessagesController::REPLIES_PER_PAGE
      end

      @reply_count = @topic.children.count
      @reply_pages = MessagesController::Paginator.new @reply_count, MessagesController::REPLIES_PER_PAGE, page

      @replies =  @replies.
        limit(@reply_pages.per_page).
        offset(@reply_pages.offset).
        to_a

      @reply = Message.new(:subject => "RE: #{@message.subject}")
      render :action => "show", :layout => false if request.xhr?
    end

  end
end

MessagesController.send :include, MatsukeiRedmine::MessagesControllerPatch
