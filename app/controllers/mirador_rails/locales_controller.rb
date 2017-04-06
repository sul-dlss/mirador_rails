module MiradorRails
  class LocalesController < ::ApplicationController

    def locale
      language = params.fetch(:locale) { I18n.default_locale.to_s }
      locale = MiradorRails::Locale.new(language)
      render json: locale.file_source
    end
  end
end
