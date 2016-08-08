require 'kramdown'

class Feedback < ActiveRecord::Base
  belongs_to :app
  belongs_to :user

  def body_as_html
    Kramdown::Document.new(body).to_html.html_safe
  end
end
