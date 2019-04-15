def last_message_sent_subject
  message = ActionMailer::Base.deliveries.last
  clear_sent_mailbox
  message&.subject
end

def clear_sent_mailbox
  ActionMailer::Base.deliveries = []
end
