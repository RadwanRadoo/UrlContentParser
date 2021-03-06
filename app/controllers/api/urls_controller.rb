class Api::UrlsController < Api::ApiController
  before_action :set_url, only: [:show]

  # # GET /urls
  def index
    urls = Url.all.map do |urls|
      {
        url: urls.link,
        content: urls.contents.select(:tagcontent).map(&:tagcontent)
      }
    end
    render json: {
      urls: urls
    }.to_json
  end

  # # POST /urls
  def create
    @url = Url.new(url_params)
    unless @url.save
      render status: :unprocessable_entity, json: {
        message: 'can not save the url'
      }.to_json
      return
    end

    begin
      page = @url.readContent
      raise 'Invaild Input' unless page
    rescue
      render status: :unprocessable_entity, json: {
        message: 'Invaild Input',
        url: @url
      }.to_json
      return
    end

    elements = page.xpath('//h1', '//h2', '//h3', '//@href', '//a').map do |value| # get all h1 h2 h3 tags
      @content = @url.contents.build(tagcontent: value.text.strip)
      next if @content.save
      render status: :unprocessable_entity, json: {
        message: 'can not save the content',
        content: @content
      }
      return
    end

    render status: :created, json: {
      message: 'page content saved successfully'
    }.to_json
  end

  private

  # Only allow a trusted parameter "white list" through.
  def url_params
    params.require(:url).permit(:link)
  end
end
