class ScheduleWorker
  include Sidekiq::Worker

  def perform(message_id)
	message = Message.find(message_id)
	deliver message
  end

  def deliver message
      response = nexmo.send_message(
        from: message.user.phone_number,
        to: message.to,
        text: message.text
      )
  end

	def nexmo
		require 'nexmo'
		# We do not pass in any API key or secret as
		# we're using environment variables `NEXMO_API_KEY`
		# and `NEXMO_API_SECRET`
		client = Nexmo::Client.new(
		key: "9fc3fc73Y",
		secret: "t3ehZXqoXh5kk97i"
		)
	end

end
