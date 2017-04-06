require 'mirador_rails/version'
require 'mirador_rails/view_helpers'
require 'font-awesome-rails'
require 'material_icons'
require 'openseadragon'
require 'jquery-rails'

module MiradorRails
  class Engine < ::Rails::Engine
    initializer 'mirador_rails.precompile' do |app|
      app.config.assets.precompile += %w(locales/* plugins/* themes/* skins/*)
    end

    initializer 'mirador_rails.helpers' do
      ActionView::Base.send :include, Mirador::ViewHelpers
    end
  end
end
