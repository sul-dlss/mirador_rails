module MiradorRails
  class LocalesController < ::ApplicationController

    def locale
      language = params.fetch(:id) { I18n.default_locale.to_s }
      locale = MiradorRails::Locale.new(language)
      render json: locale.file_source
    rescue MiradorRails::Exceptions::LocaleNotFound
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
