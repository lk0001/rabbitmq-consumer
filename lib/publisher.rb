require 'bunny'

class Publisher
  def publish(hash)
    msg = hash.slice(:id, :uuid)
    exchange.publish(msg.to_json, routing_key: 'acknowledgements')
  end

  private

  # rabbit stuff

  def connection
    @connection ||= Bunny.new.tap do |c|
      c.start
    end
  end

  def channel
    @channel ||= connection.create_channel
  end

  def exchange
    @exchange ||= channel.exchange('currencies.direct', durable: true)
  end
end
