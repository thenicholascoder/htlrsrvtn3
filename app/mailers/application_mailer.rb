class ApplicationMailer < ActionMailer::Base
 # This is for test/development
#  default from: "user@realdomain.com"


 # This is for production
 default from: "thenicholashernandez@gmail.com"


 layout "mailer"
end
