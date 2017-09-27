module ApplicationCable
  class Connection < ActionCable::Connection::Base

    def connect
      Rails.logger.info("%!%!%! ActionCable::Connection#connect")
    end

  end
end
