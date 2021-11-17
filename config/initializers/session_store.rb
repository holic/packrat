Rails.application.config.session_store :cookie_store,
  key: '_packrat_session',
  expire_after: 1.day
