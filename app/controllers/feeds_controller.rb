class FeedsController < ApplicationController
  include ActionController::MimeResponds
  include ActionView::Layouts

  def index
    logger.info "index"
  end

  def show
    logger.info "show #{params[:id]}"

    @feed = get_feed(params[:id])

    i = 0
    lastitem = Item.where(feed: @feed).size.positive? ? Item.where(feed: @feed).order("published DESC").first : nil
    interval_s = (params[:interval] || 60).to_i.seconds
    @num_items = (params[:items] || 30).to_i
    ts = Time.now

    while i < @num_items && nil_or_after(lastitem, ts - interval_s)
      create_item(@feed, ts)
      ts -= interval_s
      i += 1
    end

    logger.info @feed.inspect

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  private

  def get_feed(iid)
    @feed = Feed.find_or_create_by(iid: iid)

    if @feed.title.nil?
      @feed.title = Faker::Lorem.sentence
      @feed.subtitle = Faker::Company.bs
      @feed.author = Faker::Name.name
      @feed.save
    end

    return @feed
  end

  def create_item(feed, timestamp)
    item = Item.new
    item.feed = feed
    item.iid = SecureRandom.uuid
    item.title = Faker::Lorem.sentence
    item.link = feed_url(feed.iid) + "/#{item.iid}"
    item.updated = timestamp
    item.published = timestamp
    item.summary = Faker::GreekPhilosophers.quote
    item.content = Faker::Lorem.paragraphs(number: 10).join("")
    item.save
  end

  def nil_or_after(item, timestamp)
    item.nil? || item.published.before?(timestamp)
  end
end
