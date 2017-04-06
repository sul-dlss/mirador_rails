require 'mirador_rails/exceptions'
require 'mirador_rails/locale'
require 'mirador_rails/version'
require 'mirador_rails/view_helpers'
require 'font-awesome-rails'
require 'material_icons'
require 'openseadragon'
require 'jquery-rails'
require 'tinymce-rails'

module MiradorRails
  ##
  # MiradorRails Engine
  class Engine < ::Rails::Engine
    cattr_accessor :locales_mount_path do
      '/locales'
    end

    initializer 'mirador_rails.helpers' do
      ActionView::Base.send :include, Mirador::ViewHelpers
    end
  end
end
