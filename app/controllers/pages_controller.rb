class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def about
  end

  def contact
  end
end
