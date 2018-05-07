MiradorRails::Engine.routes.draw do
  match '/:id/translation',
        to: 'mirador_rails/locales#locale',
        via: :get,
        as: :locales,
        defaults: { format: :json }
end
