module I18nHelpers
  def with_translations(locale, translations)
    I18n.t translations.keys.first
    I18n.backend.store_translations locale, translations
    yield
  ensure
    I18n.reload!
  end
end
