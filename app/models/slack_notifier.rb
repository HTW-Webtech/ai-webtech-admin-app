class Notifier
  def self.notifier
    @notifier ||= Slack::Notifier.new ENV.fetch('SLACK_WEBHOOK_URL'),
                    channel: '#app-notifications',
                    username: 'app-bot'
  end

  def self.notify(message)
    notifier.ping message
  end
end
