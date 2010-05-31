class OrderMailer < ActionMailer::Base
  

def notifyseller(member, transaction)
    subject    'this is the subject'
    recipients member.email
    from       'us@andrew.cmu.edu'
    sent_on    Time.now
    
    body       :member => member, :transaction => transaction
  end
    def notifybuyer(member, transaction)
    subject    'this is the subject'
    recipients Member.find_by_id(transaction.buyer_id).email
    from       'us@andrew.cmu.edu'
    sent_on    Time.now

    body       :member => member, :transaction => transaction
  end


    def lostpassword(member)
    subject    'Carnegie Bazaar: Password reset request'
    recipients member.email
    from       'us@andrew.cmu.edu'
    sent_on    Time.now

    body       :member => member
  end

end
