class UserMailer < ApplicationMailer

  default from: 'no-reply@jungle.com'

  def order_receipt_email(order)
    @order = order
    mail(to: order.email.to_s, subject: 'Your order #{@order.id}')
  end

end
