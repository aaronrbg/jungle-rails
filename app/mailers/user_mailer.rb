class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'
    
    def order_mail (stuff)
        @cart = stuff[:cart]
        @order = stuff[:order]
        byebug
        mail(to: 'aaronrbg@gmail.com', subject: @order.id)
    end

end
