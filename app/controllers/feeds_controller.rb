class FeedsController < ApplicationController
  include ActionController::MimeResponds
  include ActionView::Layouts
  # include ActionController::ImplicitRender

  def index
    logger.info "index"
  end

  def show
    logger.info "show #{params[:id]}"

    @feed = Feed.find_or_create_by(iid: params[:id])

    if @feed.title.nil?
      @feed.title = Faker::Lorem.sentence
      @feed.subtitle = Faker::Company.bs
      @feed.author = Faker::Name.name
      @feed.save
    end

    i = 0
    lastitem = Item.where(feed: @feed).size.positive? ? Item.where(feed: @feed).order("published DESC").first : nil
    one_minute_ago = Time.now - 1.minute

    if lastitem.nil? || lastitem.published.before?(one_minute_ago)
      ts = Time.now 
      while i < 30 && (lastitem.nil? || lastitem.published.before?(ts))
        item = Item.new
        item.feed = @feed
        item.iid = SecureRandom.uuid
        item.title = Faker::Lorem.sentence
        item.link = feed_url(@feed.iid) + "/#{item.iid}"
        item.updated = ts
        item.published = ts
        item.summary = Faker::GreekPhilosophers.quote
        item.content = Faker::Lorem.paragraphs(number: 10).join("")
        item.save
        ts -= 1.minute
        i += 1
      end
    end

    logger.info @feed.inspect

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
