module MiradorRails
  class Locale
    attr_reader :language

    def initialize(language)
      @language = language
    end

    def path
      "#{language}/translation.json"
    end

    def file_source
      raise MiradorRails::Exceptions::LocaleNotFound, "Could not find #{path}" if file.blank?
      file.source.force_encoding('UTF-8')
    end

    def file
      # Rails.application.assets is `nil` in production mode (where compile assets is enabled).
      # This workaround is based off of this comment: https://github.com/fphilipe/premailer-rails/issues/145#issuecomment-225992564
      (Rails.application.assets || ::Sprockets::Railtie.build_environment(Rails.application)).find_asset(path)
    end
  end
end
