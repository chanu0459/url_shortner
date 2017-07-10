class UrlShortnersController < ApplicationController
  # GET /url_shortners
  # GET /url_shortners.json
  def index
    @url_shortners = UrlShortner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @url_shortners }
    end
  end

  # GET /:id
  # Params id - unique code
  def go
    @url_shortner = UrlShortner.where(unique_code: params[:id]).where("expires_at > ?" , Time.now()).first
    Rails.logger.debug "request.base_url #{}"
    if @url_shortner.present? && @url_shortner.url.present?
      @url_shortner.clicks += 1
      @url_shortner.save!
      redirect_to @url_shortner.url 
    end
  end

  # POST /url_shortners/shorten_url
  # Params long_url - mail url, expires_at - time at which it has to expire
  def shorten_url
    if params[:long_url].present?
      Rails.logger.debug "request.base_url #{request.base_url}"
      url = request.base_url
      @url_shortner = UrlShortner.where(url: params[:long_url]).where("expires_at > ?" , Time.now()).first 
      code = @url_shortner.unique_code if @url_shortner.present?
      message = "Unique code generated"
      unless @url_shortner.present? && @url_shortner.unique_code.present?
        code = UrlShortnersHelper.generate_unique_code
        expires_at = params[:expires_at] || Time.now + 2.days
        UrlShortner.create(url: params[:long_url], unique_code: code, clicks: 0, expires_at: expires_at)
        url += '/' + code
      end
    else
      message = "Url is required"
      code = ''
    end
    render json: {message: message, url: url}
  end

end
