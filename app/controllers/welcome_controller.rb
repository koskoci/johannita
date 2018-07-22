class WelcomeController < ApplicationController
  def index
    @counter = Counter.find_or_create_by(name: "default")
    @counter.value = (@counter.value || 0) + 1
    @counter.save!
    # render plain: "Fine New Counter #{counter.value}; #{Rails.version}/#{RUBY_VERSION}"
    render "welcome/index"
  end
end
