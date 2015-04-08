require 'sneakers'
require 'json'

class CurrencyWorker
  include Sneakers::Worker
  from_queue "currencies.queue_#{ENV['QUEUE_ID']}", env: nil

  def work(msg)
    currency_hash = JSON.parse(msg)
    save_currency(currency_hash)
    publisher.publish(currency_hash.merge(id: ENV['QUEUE_ID']))
    ack!
  end

  def save_currency(hash)
    Currency.create!(hash.slice(:base, :uuid, :rates))
  end

  def publisher
    @publisher ||= Publisher.new
  end
end
