# frozen_string_literal: true

class PageController < ApplicationController
  def index; end

  def show; end

  # for rout: /get/static/:permalink
  def permalink
    @page = Page.find_by_permalink(params[:permalink])

    if @page
      render :show # /app/views/pages/show.html.erb
    else
      redirect_to root_path
    end
  end
end
